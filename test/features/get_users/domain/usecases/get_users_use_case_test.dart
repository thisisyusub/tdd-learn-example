import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_example/features/get_users/domain/entities/user.dart';
import 'package:tdd_example/features/get_users/domain/repositories/i_user_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_example/features/get_users/domain/usecases/get_users.dart';

import 'get_users_use_case_test.mocks.dart';

@GenerateMocks([IUserRepository])
void main() {
  late GetUsers usecase;
  late MockIUserRepository mockUsersRepository;
  late List<User> users;

  group('GetUsers Usecase', () {
    setUp(() {
      mockUsersRepository = MockIUserRepository();
      usecase = GetUsers(mockUsersRepository);

      users = const <User>[
        User(
          id: 1,
          name: 'Test User 1',
          username: 'Test Username 1',
          email: 'testuser1@gmail.com',
        ),
      ];
    });

    test(
      'should get users from the repository',
      () async {
        when(mockUsersRepository.getUsers()).thenAnswer(
          (_) async => Right(users),
        );

        final result = await usecase.execute();

        expect(result, Right(users));
        verify(mockUsersRepository.getUsers());
        verifyNoMoreInteractions(mockUsersRepository);
      },
    );
  });
}
