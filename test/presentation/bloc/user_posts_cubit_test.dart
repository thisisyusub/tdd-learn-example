import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_example/core/error/failure.dart';
import 'package:tdd_example/core/states/data_state.dart';
import 'package:tdd_example/domain/entities/post.dart';
import 'package:tdd_example/presentation/bloc/user_posts_cubit.dart';

import '../../mocks/generate_mocks.mocks.dart';
import '../../mocks/mock_posts.dart';

typedef Posts = List<Post>;

void main() {
  late UserPostsCubit postsCubit;
  late MockGetUserPosts mockGetUserPosts;

  setUp(() {
    mockGetUserPosts = MockGetUserPosts();
    postsCubit = UserPostsCubit(mockGetUserPosts);
  });

  group('UserPostsCubit', () {
    blocTest<UserPostsCubit, DataState<Posts>>(
      'should emit empty if nothing happened',
      build: () => postsCubit,
      expect: () => [],
    );

    blocTest<UserPostsCubit, DataState<Posts>>(
      'should emit [InProgress] when action is started',
      build: () => postsCubit,
      act: (cubit) => cubit.fetchUserPosts(1),
      expect: () => [DataState<Posts>.inProgress()],
    );

    blocTest<UserPostsCubit, DataState<Posts>>(
      'should emit [Failure] when action is not successful',
      setUp: () {
        when(mockGetUserPosts.call(any)).thenAnswer(
          (_) async => Left(ServerFailure()),
        );
      },
      build: () => postsCubit,
      act: (cubit) => cubit.fetchUserPosts(1),
      expect: () => [
        DataState<Posts>.inProgress(),
        DataState<Posts>.failure(),
      ],
    );

    blocTest<UserPostsCubit, DataState<Posts>>(
      'should emit [Empty] if there is no user',
      setUp: () {
        when(mockGetUserPosts.call(any)).thenAnswer(
          (_) async => const Right([]),
        );
      },
      build: () => postsCubit,
      act: (cubit) => cubit.fetchUserPosts(1),
      expect: () => [
        DataState<Posts>.inProgress(),
        DataState<Posts>.empty(),
      ],
    );

    blocTest<UserPostsCubit, DataState<Posts>>(
      'should emit [Success] with the list of users when action is  successful',
      setUp: () {
        when(mockGetUserPosts.call(any)).thenAnswer(
          (_) async => const Right(posts),
        );
      },
      build: () => postsCubit,
      act: (cubit) => cubit.fetchUserPosts(1),
      expect: () => [
        DataState<Posts>.inProgress(),
        DataState<Posts>.success(posts),
      ],
    );
  });
}
