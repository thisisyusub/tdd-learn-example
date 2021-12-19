import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_example/features/get_users/domain/repositories/user_repository.dart';
import 'package:tdd_example/features/get_users/domain/usecases/get_user_by_id.dart';

import 'mock_user_repository.mocks.dart';
import '../../../../core/mocks/mock_users.dart';

@GenerateMocks([UserRepository])
void main() {
  late MockUserRepository mockUserRepository;
  late GetUserById usecase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = GetUserById(mockUserRepository);
  });

  const userId = 1;

  test('should get user by id from the repository', () async {
    when(
      mockUserRepository.getUser(userId),
    ).thenAnswer((_) async => Right(users[0]));

    final result = await usecase(userId);

    expect(result, Right(users[0]));
    verify(mockUserRepository.getUser(userId));
    verifyNoMoreInteractions(mockUserRepository);
  });
}
