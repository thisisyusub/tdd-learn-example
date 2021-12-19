import '../models/user_model.dart';

abstract class UserLocalDataSource {
  /// Returns the last [UserModel]s when the last time
  /// user had a internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<List<UserModel>> getLastUsersModel();

  Future<void> cacheUsers(List<UserModel> usersToCache);
}
