import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_example/core/error/exceptions.dart';
import 'package:tdd_example/features/get_users/data/data_sources/user_remote_data_source.dart';
import 'package:tdd_example/features/get_users/data/models/user_model.dart';

import '../../../../core/mocks/mock_http_client.mocks.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  late MockClient mockClient;
  late UserRemoteDataSourceImpl dataSource;

  setUp(() {
    mockClient = MockClient();
    dataSource = UserRemoteDataSourceImpl(mockClient);
  });

  void _createMockClientStub(String body, int statusCode) {
    when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response(body, statusCode),
    );
  }

  group('getUsers', () {
    final usersJsonMap = json.decode(fixture('users.json')) as List<dynamic>;
    final users = usersJsonMap.map((e) => UserModel.fromJson(e)).toList();

    test('should return users list if request is successfull', () async {
      _createMockClientStub(fixture('users.json'), 200);

      final result = await dataSource.getUsers();

      verify(
        mockClient.get(
          Uri.parse('https://jsonplaceholder.typicode.com/users/'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          },
        ),
      );

      expect(result, equals(users));
    });

    test('should throw [ServerException] for response code is 404 or other',
        () async {
      _createMockClientStub('Something went wrong!', 404);

      final call = dataSource.getUsers;

      expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group('getUser', () {
    final usersJsonMap = json.decode(fixture('users.json')) as List<dynamic>;
    final user = UserModel.fromJson(usersJsonMap[0]);
    const userId = 1;

    test('should return users by id if request is successfull', () async {
      _createMockClientStub(json.encode(usersJsonMap[0]), 200);

      final result = await dataSource.getUser(userId);

      verify(
        mockClient.get(
          Uri.parse('https://jsonplaceholder.typicode.com/users/$userId'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          },
        ),
      );

      expect(result, equals(user));
    });

    test('should throw [ServerException] for response code is 404 or other',
        () async {
      _createMockClientStub('Something went wrong!', 404);

      final call = dataSource.getUser;

      expect(() => call(userId), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
