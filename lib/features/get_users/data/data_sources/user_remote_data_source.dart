import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart';

part 'user_remote_data_source.g.dart';

abstract class UserRemoteDataSource {
  /// Calls the https://jsonplaceholder.typicode.com/users endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<UserModel>> getUsers();

  /// Calls the https://jsonplaceholder.typicode.com/users/{id} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<UserModel> getUser(int id);
}

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com/')
abstract class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  factory UserRemoteDataSourceImpl(Dio dio, {String baseUrl}) =
      _UserRemoteDataSourceImpl;

  @GET('/users')
  @override
  Future<List<UserModel>> getUsers();

  @GET('/users/{id}')
  @override
  Future<UserModel> getUser(@Path() int id);
}
//
// class UserRemoteDataSourceImpl implements UserRemoteDataSource {
//   final http.Client client;
//
//   UserRemoteDataSourceImpl(this.client);
//
//   @override
//   Future<List<UserModel>> getUsers() async {
//     final response = await client.get(
//       Uri.parse('https://jsonplaceholder.typicode.com/users/'),
//       headers: {
//         HttpHeaders.contentTypeHeader: 'application/json',
//       },
//     );
//
//     if (response.statusCode == 200) {
//       final parsedResponse = json.decode(response.body) as List<dynamic>;
//
//       return parsedResponse.map((e) => UserModel.fromJson(e)).toList();
//     } else {
//       throw ServerException();
//     }
//   }
//
//   @override
//   Future<UserModel> getUser(int id) async {
//     final response = await client.get(
//       Uri.parse('https://jsonplaceholder.typicode.com/users/$id'),
//       headers: {
//         HttpHeaders.contentTypeHeader: 'application/json',
//       },
//     );
//
//     if (response.statusCode == 200) {
//       return UserModel.fromJson(json.decode(response.body));
//     } else {
//       throw ServerException();
//     }
//   }
// }
