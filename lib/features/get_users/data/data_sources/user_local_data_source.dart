import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart';

abstract class UserLocalDataSource {
  /// Returns the last [UserModel]s when the last time
  /// user had a internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<List<UserModel>> getLastUsers();

  Future<void> cacheUsers(List<UserModel> usersToCache);
}

const cachedUsers = 'CACHED_USERS';

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences sharedPreferences;

  UserLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<void> cacheUsers(List<UserModel> usersToCache) async {
    final usersBuffer = StringBuffer();

    for (var user in usersToCache) {
      usersBuffer.write(json.encode(user.toJson()));
    }

    await sharedPreferences.setString(cachedUsers, usersBuffer.toString());
  }

  @override
  Future<List<UserModel>> getLastUsers() async {
    final cachedUsersString = sharedPreferences.getString(cachedUsers);

    if (cachedUsersString != null) {
      final jsonMap = json.decode(cachedUsersString) as List<dynamic>;

      return jsonMap.map((e) => UserModel.fromJson(e)).toList();
    } else {
      throw CacheException();
    }
  }
}
