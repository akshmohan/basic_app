import 'package:fpdart/fpdart.dart';
import 'package:machine_test_new/core/errors/failures.dart';
import 'package:machine_test_new/core/use_cases/use_case.dart';
import '../entities/data_entity.dart';
import '../repositories/data_repository.dart';

class DataLoad implements UseCase<List<DataEntity>, NoParams> {
  final DataRepository dataRepository;

  DataLoad(this.dataRepository);

  @override
  Future<Either<Failures, List<DataEntity>>> call(NoParams params) async {
    return await dataRepository.getData();
  }
}
