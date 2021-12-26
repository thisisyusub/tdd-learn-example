import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_example/core/error/exceptions.dart';
import 'package:tdd_example/data/data_sources/user_local_data_source.dart';
import 'package:tdd_example/data/models/user_model.dart';

import '../../fixtures/fixture_reader.dart';
import '../../mocks/generate_mocks.mocks.dart';
import '../../mocks/mock_user_models.dart';

void main() {
  late UserLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = UserLocalDataSourceImpl(mockSharedPreferences);
  });

  group('getLastUsers', () {
    final jsonMap = json.decode(fixture('users_cached.json')) as List<dynamic>;

    final expectedCachedUsers = jsonMap.map((user) {
      return UserModel.fromJson(user);
    }).toList();
    test(
      'should return [User]s from [SharedPreferences] when there is'
      ' data in the cache',
      () async {
        final usersString = <String>[];

        for (var user in userModels) {
          usersString.add(json.encode(user.toJson()));
        }

        when(mockSharedPreferences.getStringList(any)).thenReturn(usersString);

        final result = await dataSource.getLastUsers();

        verify(mockSharedPreferences.getStringList(cachedUsers));
        expect(result, equals(expectedCachedUsers));
      },
    );

    test(
      'should throw [CacheException] when there is no cached '
      'data in the cache',
      () async {
        when(mockSharedPreferences.getStringList(any)).thenReturn(null);

        final call = dataSource.getLastUsers;

        expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
      },
    );
  });

  group('cache users', () {
    test('should call [SharedPreferences] to cache users', () async {
      when(mockSharedPreferences.setStringList(any, any)).thenAnswer(
        (_) async => true,
      );

      await dataSource.cacheUsers(userModels);

      final usersString = <String>[];

      for (var user in userModels) {
        usersString.add(json.encode(user.toJson()));
      }

      verify(mockSharedPreferences.setStringList(cachedUsers, usersString));
    });
  });
}
