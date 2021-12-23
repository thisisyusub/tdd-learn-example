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
    final usersString = <String>[];

    for (var user in usersToCache) {
      usersString.add(json.encode(user.toJson()));
    }

    await sharedPreferences.setStringList(cachedUsers, usersString);
  }

  @override
  Future<List<UserModel>> getLastUsers() async {
    final cachedUsersString = sharedPreferences.getStringList(cachedUsers);

    final lastCachedUsers = <UserModel>[];

    if (cachedUsersString != null) {
      for (var user in cachedUsersString) {
        lastCachedUsers.add(UserModel.fromJson(json.decode(user)));
      }

      return lastCachedUsers;
    } else {
      throw CacheException();
    }
  }
}
