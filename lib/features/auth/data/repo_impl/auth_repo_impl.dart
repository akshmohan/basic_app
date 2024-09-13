import 'package:fpdart/fpdart.dart';
import 'package:machine_test_new/core/entities/user_entity.dart';
import 'package:machine_test_new/core/errors/exceptions.dart';
import 'package:machine_test_new/core/errors/failures.dart';
import 'package:machine_test_new/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:machine_test_new/features/auth/data/models/user_model.dart';
import 'package:machine_test_new/features/auth/domain/repositories/auth_repository.dart';
import '../data_sources/auth_local_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;
  AuthRepositoryImpl(this.authRemoteDataSource, this.authLocalDataSource);

  @override
  Future<Either<Failures, UserEntity>> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserModel userModel =
          await authRemoteDataSource.loginWithEmailAndPassword(
        email: email,
        password: password,
      );
      authLocalDataSource.uploadUserData(userModel);
      return Right(userModel);
    } on ServerException catch (e) {
      return Left(Failures(message: e.message.toString()));
    }
  }

  @override
  Either<Failures, UserEntity> isLoggedIn() {
    try {
      UserModel? userModel = authLocalDataSource.checkUserLoggedIn();
      if (userModel != null) {
        return Right(userModel);
      } else {
        return const Left(Failures(message: 'User doesn\'t exist'));
      }
    } on ServerException catch (e) {
      return Left(Failures(message: e.message));
    }
  }

  @override
  Future<Either<Failures, UserEntity>> storeApiResponseToHive() async {
    try {
      UserModel? usermodel = authLocalDataSource.checkUserLoggedIn();
      if (usermodel != null) {
        return Right(usermodel);
      } else {
        return const Left(Failures(message: 'User data not found'));
      }
    } on ServerException catch (e) {
      return Left(Failures(message: e.message));
    }
  }

  @override
  Future<void> logoutUserFromApp() async {
    await authLocalDataSource.logoutUser();
  }
}
