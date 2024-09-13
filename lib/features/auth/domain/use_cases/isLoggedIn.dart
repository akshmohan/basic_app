import 'package:fpdart/fpdart.dart';
import 'package:machine_test_new/core/errors/failures.dart';
import 'package:machine_test_new/core/use_cases/use_case.dart';
import 'package:machine_test_new/features/auth/domain/repositories/auth_repository.dart';
import '../../../../core/entities/user_entity.dart';

class IsloggedinCheck implements UseCase<UserEntity, NoParams> {
  final AuthRepository authRepository;
  IsloggedinCheck(this.authRepository);
  @override
  Future<Either<Failures, UserEntity>> call(NoParams params) async {
    return authRepository.isLoggedIn();
  }
}
