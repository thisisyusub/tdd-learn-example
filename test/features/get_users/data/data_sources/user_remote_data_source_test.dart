import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_example/features/get_users/data/data_sources/user_remote_data_source.dart';
import 'package:tdd_example/features/get_users/data/models/user_model.dart';

import '../../../../core/mocks/mock_http_client_adapter.mocks.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  late MockHttpClientAdapter adapter;
  late UserRemoteDataSourceImpl dataSource;

  setUp(() {
    final dio = Dio();
    adapter = MockHttpClientAdapter();
    dio.httpClientAdapter = adapter;
    dataSource = UserRemoteDataSourceImpl(dio);
  });

  void createMockResponseStub(String body, int statusCode) {
    final response = ResponseBody.fromString(
      body,
      statusCode,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );

    when(adapter.fetch(any, any, any)).thenAnswer(
      (_) async {
        return response;
      },
    );
  }

  group('getUsers', () {
    final usersJsonMap = json.decode(fixture('users.json')) as List<dynamic>;
    final users = usersJsonMap.map((e) => UserModel.fromJson(e)).toList();

    test('should return users list if request is successful', () async {
      createMockResponseStub(json.encode(usersJsonMap), 200);

      final result = await dataSource.getUsers();

      expect(result, equals(users));
    });

    test('should throw [ServerException] for response code is 404 or other',
        () async {
      createMockResponseStub('Something went wrong!', 404);

      final call = dataSource.getUsers;

      expect(() => call(), throwsA(const TypeMatcher<DioError>()));
    });
  });

  group('getUser', () {
    final usersJsonMap = json.decode(fixture('users.json')) as List<dynamic>;
    final user = UserModel.fromJson(usersJsonMap[0]);
    const userId = 1;

    test('should return users by id if request is successful', () async {
      createMockResponseStub(json.encode(usersJsonMap[0]), 200);

      final result = await dataSource.getUser(userId);

      expect(result, equals(user));
    });

    test('should throw [ServerException] for response code is 404 or other',
        () async {
      createMockResponseStub('Something went wrong!', 404);

      final call = dataSource.getUser;

      expect(() => call(userId), throwsA(const TypeMatcher<DioError>()));
    });
  });
}
