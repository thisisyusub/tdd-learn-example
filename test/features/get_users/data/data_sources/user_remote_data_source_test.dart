import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_example/features/get_users/data/data_sources/user_remote_data_source.dart';
import 'package:dio/dio.dart';
import 'package:tdd_example/features/get_users/data/models/user_model.dart';

import '../../../../core/mocks/mock_dio.mocks.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  late Dio mockDio;
  late MockHttpClientAdapter mockHttpClientAdapter;
  late UserRemoteDataSourceImpl dataSource;

  setUp(() {
    mockDio = Dio();
    mockHttpClientAdapter = MockHttpClientAdapter();
    mockDio.options.baseUrl = 'https://jsonplaceholder.typicode.com';
    mockDio.httpClientAdapter = mockHttpClientAdapter;
    dataSource = UserRemoteDataSourceImpl(mockDio);
  });

  test('should perform a GET request to get users from an endpoint', () async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};

    when(mockHttpClientAdapter.fetch(any, any, any)).thenAnswer(
      (_) async => json.decode(
        fixture('users_cached.json'),
      ),
    );

    final result = await dataSource.getUsers();

    verify(mockDio.get('/users'));
  });
}

RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
  if (T != dynamic &&
      !(requestOptions.responseType == ResponseType.bytes ||
          requestOptions.responseType == ResponseType.stream)) {
    if (T == String) {
      requestOptions.responseType = ResponseType.plain;
    } else {
      requestOptions.responseType = ResponseType.json;
    }
  }
  return requestOptions;
}
