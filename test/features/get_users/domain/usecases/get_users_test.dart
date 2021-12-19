import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_example/features/get_users/domain/usecases/get_users.dart';

import 'mock_user_repository.mocks.dart';
import 'mock_users.dart';

void main() {
  late GetUsers usecase;
  late MockUserRepository mockUsersRepository;

  group('GetUsers Usecase', () {
    setUp(() {
      mockUsersRepository = MockUserRepository();
      usecase = GetUsers(mockUsersRepository);
    });

    test(
      'should get users from the repository',
      () async {
        when(mockUsersRepository.getUsers()).thenAnswer(
          (_) async => const Right(users),
        );

        final result = await usecase();

        expect(result, const Right(users));
        verify(mockUsersRepository.getUsers());
        verifyNoMoreInteractions(mockUsersRepository);
      },
    );
  });
}
