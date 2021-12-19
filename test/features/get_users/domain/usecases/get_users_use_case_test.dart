import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_example/features/get_users/domain/entities/user.dart';
import 'package:tdd_example/features/get_users/domain/repositories/i_user_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_example/features/get_users/domain/usecases/get_users.dart';

class MockUsersRepository extends Mock implements IUserRepository {}

void main() {
  late GetUsers usecase;
  late MockUsersRepository mockUsersRepository;
  late final List<User> users;

  group('GetUsers Usecase', () {
    setUp(() {
      mockUsersRepository = MockUsersRepository();
      usecase = GetUsers(mockUsersRepository);
    });

    test(
      'should get users from the repository',
      () async {
        users = const <User>[
          User(
            id: 1,
            name: 'User 1',
            username: 'User 1',
            email: 'user1@gmail.com',
          ),
          User(
            id: 2,
            name: 'User 2',
            username: 'User 2',
            email: 'user2@gmail.com',
          ),
        ];

        when(mockUsersRepository.getUsers()).thenAnswer(
          (_) async => Right(users),
        );

        final result = await usecase.execute();
        print('result: $result');

        expect(result, Right(users));
        verify(mockUsersRepository.getUsers());
        verifyNoMoreInteractions(mockUsersRepository);
      },
    );
  });
}
