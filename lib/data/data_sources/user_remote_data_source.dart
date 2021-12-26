import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../models/user_model.dart';

part 'user_remote_data_source.g.dart';

abstract class UserRemoteDataSource {
  /// Calls the https://jsonplaceholder.typicode.com/users endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<UserModel>> getUsers();
}

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com/')
abstract class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  factory UserRemoteDataSourceImpl(Dio dio, {String baseUrl}) =
      _UserRemoteDataSourceImpl;

  @GET('/users')
  @override
  Future<List<UserModel>> getUsers();
}
