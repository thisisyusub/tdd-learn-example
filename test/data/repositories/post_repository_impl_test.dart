import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_example/core/error/failure.dart';
import 'package:tdd_example/data/repositories/post_repository_impl.dart';
import 'package:tdd_example/domain/entities/post.dart';

import '../../mocks/generate_mocks.mocks.dart';
import '../../mocks/mock_post_models.dart';

void main() {
  late final PostRepositoryImpl postRepositoryImpl;
  late final MockPostRemoteDataSource mockPostRemoteDataSource;
  late final List<Post> posts;

  setUpAll(() {
    mockPostRemoteDataSource = MockPostRemoteDataSource();
    postRepositoryImpl = PostRepositoryImpl(mockPostRemoteDataSource);
    posts = postModels;
  });

  test(
    'should return list of [Post] if it is successful',
    () async {
      when(mockPostRemoteDataSource.getUserPosts(any))
          .thenAnswer((_) async => postModels);

      final result = await postRepositoryImpl.getUserPosts(1);

      expect(result, equals(Right(posts)));
      verify(mockPostRemoteDataSource.getUserPosts(1));
      verifyNoMoreInteractions(mockPostRemoteDataSource);
    },
  );

  test(
    'should return [ServerFailure] if it us successful',
    () async {
      when(mockPostRemoteDataSource.getUserPosts(any)).thenThrow(
        DioError(
          requestOptions: RequestOptions(
            path: '',
          ),
        ),
      );

      final result = await postRepositoryImpl.getUserPosts(1);

      expect(result, equals((Left(ServerFailure()))));
      verify(mockPostRemoteDataSource.getUserPosts(1));
      verifyNoMoreInteractions(mockPostRemoteDataSource);
    },
  );
}
