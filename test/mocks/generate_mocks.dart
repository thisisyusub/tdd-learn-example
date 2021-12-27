import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_example/core/network/network_info.dart';
import 'package:tdd_example/data/data_sources/post_remote_data_source.dart';
import 'package:tdd_example/data/data_sources/user_local_data_source.dart';
import 'package:tdd_example/data/data_sources/user_remote_data_source.dart';
import 'package:tdd_example/domain/repositories/post_repository.dart';
import 'package:tdd_example/domain/repositories/user_repository.dart';
import 'package:tdd_example/domain/use_cases/get_users.dart';

@GenerateMocks(
  [
    SharedPreferences,
    HttpClientAdapter,
    NetworkInfo,
    UserLocalDataSource,
    UserRemoteDataSource,
    UserRepository,
    Connectivity,
    GetUsers,
    PostRepository,
    PostRemoteDataSource,
  ],
)
void generateMocks() {}
