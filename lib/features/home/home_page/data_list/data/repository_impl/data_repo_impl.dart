import 'package:fpdart/fpdart.dart';
import 'package:machine_test_new/core/errors/exceptions.dart';
import 'package:machine_test_new/core/errors/failures.dart';
import 'package:machine_test_new/core/network/connection_checker.dart';
import '../../domain/entities/data_entity.dart';
import '../../domain/repositories/data_repository.dart';
import '../data_sources/local_data_source.dart';
import '../data_sources/remote_data_source.dart';

class DataRepoImpl implements DataRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final ConnectionChecker connectionChecker;

  DataRepoImpl(
    this.remoteDataSource,
    this.localDataSource,
    this.connectionChecker,
  );

  @override
  Future<Either<Failures, List<DataEntity>>> getData() async {
    try {
      // if (!await (connectionChecker.isConnected)) {
      //   final data = localDataSource.loadData();
      //   return right(data);
      // }
      final data = await remoteDataSource.loadRemoteData();
      // localDataSource.uploadLocalData(data: data);
      return right(data);
    } on ServerException catch (e) {
      return left(Failures(message: e.message));
    }
  }
}
