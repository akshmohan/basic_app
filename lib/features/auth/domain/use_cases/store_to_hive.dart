import 'package:fpdart/fpdart.dart';
import 'package:machine_test_new/core/entities/user_entity.dart';
import 'package:machine_test_new/core/errors/failures.dart';
import 'package:machine_test_new/core/use_cases/use_case.dart';
import 'package:machine_test_new/features/auth/domain/repositories/auth_repository.dart';

class StoreToHive implements UseCase<UserEntity, NoParams> {
  final AuthRepository authRepository;

  StoreToHive(this.authRepository);

  @override
  Future<Either<Failures, UserEntity>> call(NoParams params) async {
    return await authRepository.storeApiResponseToHive();
  }
}
