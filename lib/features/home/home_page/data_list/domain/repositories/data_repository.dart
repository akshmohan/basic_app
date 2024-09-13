import 'package:fpdart/fpdart.dart';
import 'package:machine_test_new/core/errors/failures.dart';

import '../entities/data_entity.dart';

abstract interface class DataRepository {
  Future<Either<Failures, List<DataEntity>>> getData();
}
