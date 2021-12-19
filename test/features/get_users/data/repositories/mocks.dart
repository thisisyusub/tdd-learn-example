import 'package:mockito/annotations.dart';
import 'package:tdd_example/core/platform/network_info.dart';
import 'package:tdd_example/features/get_users/data/data_sources/user_local_data_source.dart';
import 'package:tdd_example/features/get_users/data/data_sources/user_remote_data_source.dart';

@GenerateMocks([UserRemoteDataSource])
void generateMockRemoteUserDataSource() {}

@GenerateMocks([UserLocalDataSource])
void generateMockLocalUserDataSource() {}

@GenerateMocks([NetworkInfo])
void generateMockNetworkInfo() {}
