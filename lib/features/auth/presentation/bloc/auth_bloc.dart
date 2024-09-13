import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test_new/core/common/cubit/logged_in/logged_in_cubit.dart';
import 'package:machine_test_new/core/entities/user_entity.dart';
import 'package:machine_test_new/core/use_cases/use_case.dart';
import 'package:machine_test_new/features/auth/domain/use_cases/user_logout.dart';
import '../../domain/use_cases/isLoggedIn.dart';
import '../../domain/use_cases/store_to_hive.dart';
import '../../domain/use_cases/user_login.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserLogin _userLogin;
  final UserLogout _userLogout;
  final IsloggedinCheck _isLoggedIn;
  final LoggedInCubit _appUserCubit;
  final StoreToHive _storeToHive;
  AuthBloc(
    UserLogin userLogin,
    IsloggedinCheck isLoggedIn,
    LoggedInCubit appUserCubit,
    StoreToHive storeToHive,
    UserLogout userLogout,
  )   : _userLogin = userLogin,
        _userLogout = userLogout,
        _storeToHive = storeToHive,
        _appUserCubit = appUserCubit,
        _isLoggedIn = isLoggedIn,
        super(AuthInitial()) {
    on<AuthEvent>((event, emit) => emit(AuthLoginLoading()));
    on<AuthLoginPressed>((event, emit) async {
      try {
        final result = await _userLogin.call(
            UserLoginParams(email: event.email, password: event.password));

        result.fold(
          (failure) => emit(AuthLoginFailure(message: failure.message)),
          (user) => emit(AuthLoginSuccess(user: user)),
        );
      } catch (e) {
        emit(AuthLoginFailure(message: e.toString()));
      }
    });

    on<AuthLogoutPressed>((event, emit) {
      _userLogout();
      emit(AuthLoginFailure(message: "Logged Out Successfully"));
    });

    on<IsLoggedIn>(
      (event, emit) async {
        final result = await _isLoggedIn(NoParams());
        result.fold(
          (failure) => emit(AuthLoginFailure(message: failure.message)),
          (user) => _emitAuthSuccess(user, emit),
        );
      },
    );

    on<LoadFromHive>((event, emit) async {
      final result = await _storeToHive(NoParams());
      result.fold(
        (failure) => emit(AuthLoginFailure(message: failure.message)),
        (user) => _emitAuthSuccess(user, emit),
      );
    });
  }

  void _emitAuthSuccess(UserEntity user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthLoginSuccess(user: user));
  }
}
