import 'package:fpdart/fpdart.dart';
import 'package:machine_test_new/core/entities/user_entity.dart';
import 'package:machine_test_new/core/errors/failures.dart';
import 'package:machine_test_new/core/use_cases/use_case.dart';
import 'package:machine_test_new/features/auth/domain/repositories/auth_repository.dart';

class UserLogin implements UseCase<UserEntity, UserLoginParams> {
  final AuthRepository authRepository;

  UserLogin(this.authRepository);

  @override
  Future<Either<Failures, UserEntity>> call(params) async {
    return await authRepository.loginWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({
    required this.email,
    required this.password,
  });
}
