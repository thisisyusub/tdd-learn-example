import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_example/data/data_sources/post_remote_data_source.dart';
import 'package:tdd_example/data/models/post_model.dart';

import '../../fixtures/fixture_reader.dart';
import '../../mocks/generate_mocks.mocks.dart';
import 'mock_response_stub.dart';

void main() {
  late MockHttpClientAdapter adapter;
  late PostRemoteDataSourceImpl postRemoteDataSourceImpl;

  setUp(() {
    adapter = MockHttpClientAdapter();
    postRemoteDataSourceImpl = PostRemoteDataSourceImpl(
      Dio()..httpClientAdapter = adapter,
    );
  });

  final postsJsonMap = json.decode(fixture('posts.json')) as List<dynamic>;
  final posts = postsJsonMap.map((e) => PostModel.fromJson(e)).toList();

  test('should return post list if request is successful', () async {
    adapter.createMockResponseStub(json.encode(postsJsonMap), 200);

    final result = await postRemoteDataSourceImpl.getUserPosts(1);

    expect(result, equals(posts));
  });

  test('should throw [ServerException] for response code is 404 or other',
      () async {
    adapter.createMockResponseStub('Something went wrong!', 404);

    final call = postRemoteDataSourceImpl.getUserPosts;

    expect(() => call(1), throwsA(const TypeMatcher<DioError>()));
  });
}
