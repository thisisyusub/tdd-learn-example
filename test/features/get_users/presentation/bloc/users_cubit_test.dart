import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_example/core/error/failure.dart' as error;
import 'package:tdd_example/core/no_params.dart';
import 'package:tdd_example/core/states/data_state.dart';
import 'package:tdd_example/features/get_users/domain/entities/user.dart';
import 'package:tdd_example/features/get_users/domain/usecases/get_users.dart';
import 'package:tdd_example/features/get_users/presentation/bloc/users_cubit.dart';

import '../../../../core/mocks/mock_users.dart';
import 'users_cubit_test.mocks.dart';

@GenerateMocks([GetUsers])
void main() {
  late UserCubit userCubit;
  late MockGetUsers mockGetUsers;

  setUp(() {
    mockGetUsers = MockGetUsers();
    userCubit = UserCubit(mockGetUsers);
  });

  group('UserCubit', () {
    blocTest<UserCubit, DataState<List<User>>>(
      'should emit empty if nothing happened',
      build: () => userCubit,
      expect: () => [],
    );

    blocTest<UserCubit, DataState<List<User>>>(
      'should emit [InProgress] when action is started',
      build: () => userCubit,
      act: (cubit) => cubit.fetchUsers(),
      expect: () => [const DataState<List<User>>.inProgress()],
    );

    blocTest<UserCubit, DataState<List<User>>>(
      'should emit [Failure] when action is not successful',
      setUp: () {
        when(mockGetUsers.call(const NoParams())).thenAnswer(
          (_) async => Left(error.ServerFailure()),
        );
      },
      build: () => userCubit,
      act: (cubit) => cubit.fetchUsers(),
      expect: () => [
        const DataState<List<User>>.inProgress(),
        const DataState<List<User>>.failure(),
      ],
    );

    blocTest<UserCubit, DataState<List<User>>>(
      'should emit [Success] with the list of users when action is  successful',
      setUp: () {
        when(mockGetUsers.call(const NoParams())).thenAnswer(
          (_) async => const Right(users),
        );
      },
      build: () => userCubit,
      act: (cubit) => cubit.fetchUsers(),
      expect: () => [
        const DataState<List<User>>.inProgress(),
        const DataState.success(users),
      ],
    );
  });
}
