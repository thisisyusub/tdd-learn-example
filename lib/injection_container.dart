import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/get_users/data/data_sources/user_local_data_source.dart';
import 'features/get_users/data/data_sources/user_remote_data_source.dart';
import 'features/get_users/data/repositories/user_repository_impl.dart';
import 'features/get_users/domain/repositories/user_repository.dart';
import 'features/get_users/domain/use_cases/get_users.dart';
import 'features/get_users/presentation/bloc/users_cubit.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  initBlocs();
  initUseCases();
  initRepositories();
  initDataSources();
  initCores();
  await initExternals();
}

void initBlocs() {
  getIt.registerFactory(() => UsersCubit(getIt()));
}

void initUseCases() {
  getIt.registerLazySingleton(() => GetUsers(getIt()));
}

void initRepositories() {
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      remoteDataSource: getIt(),
      localDataSource: getIt(),
      networkInfo: getIt(),
    ),
  );
}

void initDataSources() {
  getIt.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(getIt()),
  );

  getIt.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSourceImpl(getIt()),
  );
}

void initCores() {
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(getIt()),
  );
}

Future<void> initExternals() async {
  final prefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => prefs);

  getIt.registerLazySingleton(() => Dio());

  getIt.registerLazySingleton(() => Connectivity());
}
