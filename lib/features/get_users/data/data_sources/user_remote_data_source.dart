import '../models/user_model.dart';

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
