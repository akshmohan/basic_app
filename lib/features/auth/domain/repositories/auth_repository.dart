import 'package:fpdart/fpdart.dart';
import 'package:machine_test_new/core/entities/user_entity.dart';
import 'package:machine_test_new/core/errors/failures.dart';

abstract interface class AuthRepository {
  Future<Either<Failures, UserEntity>> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  Either<Failures, UserEntity> isLoggedIn();

  Future<Either<Failures, UserEntity>> storeApiResponseToHive();

  Future<void> logoutUserFromApp();
}
