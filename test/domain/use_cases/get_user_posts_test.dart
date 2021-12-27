import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_example/core/error/failure.dart';
import 'package:tdd_example/domain/use_cases/get_user_posts.dart';

import '../../mocks/generate_mocks.mocks.dart';
import '../../mocks/mock_posts.dart';

void main() {
  late GetUserPosts getUserPosts;
  late MockPostRepository mockPostRepository;

  setUp(() {
    mockPostRepository = MockPostRepository();
    getUserPosts = GetUserPosts(mockPostRepository);
  });

  test('GetUserPosts gets posts successfully', () async {
    when(mockPostRepository.getUserPosts(any)).thenAnswer(
      (_) async => const Right(posts),
    );

    final result = await getUserPosts(1);

    expect(result, equals(const Right(posts)));
    verify(mockPostRepository.getUserPosts(1));
    verifyNoMoreInteractions(mockPostRepository);
  });

  test('GetUserPosts returns Failure', () async {
    when(mockPostRepository.getUserPosts(any)).thenAnswer(
      (_) async => Left(ServerFailure()),
    );

    final result = await getUserPosts(1);

    expect(result, equals(Left(ServerFailure())));
  });
}
