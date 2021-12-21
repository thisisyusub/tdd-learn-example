import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_example/features/get_users/data/models/user_model.dart';

import 'fixtures/fixture_reader.dart';
import 'mock_dio_test.mocks.dart';

import 'package:retrofit/retrofit.dart' as client;

part 'mock_dio_test.g.dart';

@client.RestApi(baseUrl: "https://www.example.com")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @client.GET("/user")
  Future<UserModel> getUser();
}

@GenerateMocks([HttpClientAdapter])
void generateMockClientAdapter() {}

void main() {
  test(
    'test dio get request',
    () async {
      final usersMap = json.decode(fixture('users.json')) as List<dynamic>;
      final userMap = usersMap[0] as Map<String, dynamic>;

      final dio = Dio();
      final adapter = MockHttpClientAdapter();
      dio.httpClientAdapter = adapter;

      final restClient = RestClient(dio);

      final response = ResponseBody.fromString(
        json.encode(userMap),
        200,
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType],
        },
      );

      when(adapter.fetch(any, any, any)).thenAnswer(
        (_) async {
          return response;
        },
      );

      final result = await restClient.getUser();

      print('data: $result');
    },
  );
}
