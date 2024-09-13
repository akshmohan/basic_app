import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:machine_test_new/core/common/cubit/selected/selected_cubit.dart';
import 'package:machine_test_new/core/network/connection_checker.dart';
import 'package:machine_test_new/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:machine_test_new/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:machine_test_new/features/auth/data/repo_impl/auth_repo_impl.dart';
import 'package:machine_test_new/features/auth/domain/use_cases/isLoggedIn.dart';
import 'package:machine_test_new/features/auth/domain/use_cases/store_to_hive.dart';
import 'package:machine_test_new/features/auth/domain/use_cases/user_logout.dart';
import 'package:path_provider/path_provider.dart';
import 'core/common/cubit/logged_in/logged_in_cubit.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/use_cases/user_login.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/home/home_page/data_list/data/data_sources/local_data_source.dart';
import 'features/home/home_page/data_list/data/data_sources/remote_data_source.dart';
import 'features/home/home_page/data_list/data/repository_impl/data_repo_impl.dart';
import 'features/home/home_page/data_list/domain/repositories/data_repository.dart';
import 'features/home/home_page/data_list/domain/use_cases/data_usecase.dart';
import 'features/home/home_page/data_list/presentation/bloc/data_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initData();

  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;

  serviceLocator.registerLazySingleton(() => Hive.box(name: 'data'));
}

void _initAuth() {
  // Datasource
  serviceLocator
    ..registerFactory<AuthLocalDataSource>(
        () => AuthLocalDataSourceImpl(serviceLocator()))
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(),
    )
    // Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator<AuthRemoteDataSource>(),
        serviceLocator<AuthLocalDataSource>(),
      ),
    )
    // Usecases
    ..registerFactory(
      () => UserLogin(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => StoreToHive(
        serviceLocator(),
      ),
    )
    ..registerFactory<IsloggedinCheck>(
      () => IsloggedinCheck(
        serviceLocator<AuthRepository>(),
      ),
    )
    ..registerFactory<UserLogout>(
      () => UserLogout(
        serviceLocator(),
      ),
    )

    // Bloc
    ..registerLazySingleton<LoggedInCubit>(() => LoggedInCubit())
    ..registerLazySingleton<SelectedCubit>(() => SelectedCubit())
    ..registerLazySingleton(
      () => AuthBloc(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    );
}

void _initData() async {
  serviceLocator.registerLazySingleton(() => InternetConnection());
  serviceLocator.registerFactory<ConnectionChecker>(
      () => ConnectionCheckerImpl(serviceLocator<InternetConnection>()));
  // Datasource
  serviceLocator
    ..registerFactory<RemoteDataSource>(
      () => RemoteDataSourceImpl(),
    )
    ..registerFactory<LocalDataSource>(
      () => LocalDataSourceImpl(
        serviceLocator(),
      ),
    )
    // Repository
    ..registerFactory<DataRepository>(
      () => DataRepoImpl(
          serviceLocator<RemoteDataSource>(),
          serviceLocator<LocalDataSource>(),
          serviceLocator<ConnectionChecker>()),
    )
    // Usecases
    ..registerFactory(
      () => DataLoad(
        serviceLocator(),
      ),
    )
    // Bloc
    ..registerLazySingleton<DataBloc>(
      () => DataBloc(
        serviceLocator(),
      ),
    );
}
