import 'package:fpdart/fpdart.dart';
import 'package:machine_test_new/core/errors/failures.dart';

abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failures, SuccessType>> call(Params params);
}

class NoParams {}
