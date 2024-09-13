import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test_new/core/entities/user_entity.dart';

part 'logged_in_state.dart';

class LoggedInCubit extends Cubit<LoggedInState> {
  LoggedInCubit() : super(LoggedInInitial());

  void updateUser(UserEntity? user) {
    if (user == null) {
      emit(LoggedInInitial());
    } else {
      emit(UserLoggedIn(user));
    }
  }
}
