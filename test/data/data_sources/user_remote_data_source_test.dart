import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_example/data/data_sources/user_remote_data_source.dart';
import 'package:tdd_example/data/models/user_model.dart';

import '../../fixtures/fixture_reader.dart';
import '../../mocks/generate_mocks.mocks.dart';
import 'mock_response_stub.dart';

void main() {
  late MockHttpClientAdapter adapter;
  late UserRemoteDataSourceImpl dataSource;

  setUp(() {
    final dio = Dio();
    adapter = MockHttpClientAdapter();
    dio.httpClientAdapter = adapter;
    dataSource = UserRemoteDataSourceImpl(dio);
  });

  group('getUsers', () {
    final usersJsonMap = json.decode(fixture('users.json')) as List<dynamic>;
    final users = usersJsonMap.map((e) => UserModel.fromJson(e)).toList();

    test('should return users list if request is successful', () async {
      adapter.createMockResponseStub(json.encode(usersJsonMap), 200);

      final result = await dataSource.getUsers();

      expect(result, equals(users));
    });

    test('should throw [ServerException] for response code is 404 or other',
        () async {
      adapter.createMockResponseStub('Something went wrong!', 404);

      final call = dataSource.getUsers;

      expect(() => call(), throwsA(const TypeMatcher<DioError>()));
    });
  });
}
