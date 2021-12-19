import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_example/core/error/exceptions.dart';
import 'package:tdd_example/core/error/failure.dart';
import 'package:tdd_example/features/get_users/data/repositories/user_repository_impl.dart';
import 'package:tdd_example/features/get_users/domain/entities/user.dart';

import '../../../../core/mocks/mock_user_models.dart';
import 'mock_data_sources.mocks.dart';

void main() {
  late UserRepositoryImpl userRepositoryImpl;
  late MockUserRemoteDataSource mockUserRemoteDataSource;
  late MockUserLocalDataSource mockUserLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late List<User> users;
  late User user;

  setUp(() {
    mockUserRemoteDataSource = MockUserRemoteDataSource();
    mockUserLocalDataSource = MockUserLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    users = userModels;
    user = userModels[0];
    userRepositoryImpl = UserRepositoryImpl(
      remoteDataSource: mockUserRemoteDataSource,
      localDataSource: mockUserLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  test(
    'should check if the device is online',
    () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      when(mockUserRemoteDataSource.getUsers()).thenAnswer((_) async {
        return userModels;
      });

      userRepositoryImpl.getUsers();

      verify(mockNetworkInfo.isConnected);
    },
  );

  group('getUsers', () {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test('should return remote users when it is successful', () async {
        when(mockUserRemoteDataSource.getUsers()).thenAnswer((_) async {
          return userModels;
        });

        final result = await userRepositoryImpl.getUsers();

        verify(mockUserRemoteDataSource.getUsers());
        expect(result, equals(Right(users)));
      });

      test('should cache  remote users when it is successful', () async {
        when(mockUserRemoteDataSource.getUsers()).thenAnswer((_) async {
          return userModels;
        });

        final result = await userRepositoryImpl.getUsers();

        verify(mockUserRemoteDataSource.getUsers());
        verify(mockUserLocalDataSource.cacheUsers(userModels));
        expect(result, equals(Right(users)));
      });

      test('should return server failure when it is unsuccessful', () async {
        when(mockUserRemoteDataSource.getUsers()).thenThrow(ServerException());

        final result = await userRepositoryImpl.getUsers();

        verify(mockUserRemoteDataSource.getUsers());
        verifyZeroInteractions(mockUserLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    ///
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test(
        'should return last cached users when the cached data is present',
        () async {
          when(mockUserLocalDataSource.getLastUsersModel())
              .thenAnswer((_) async => userModels);

          final result = await userRepositoryImpl.getUsers();

          verifyZeroInteractions(mockUserRemoteDataSource);
          verify(mockUserLocalDataSource.getLastUsersModel());
          expect(result, equals(Right(users)));
        },
      );

      test(
        'should return [CacheFailure]  when there is no cached data',
        () async {
          when(mockUserLocalDataSource.getLastUsersModel())
              .thenThrow(CacheException());

          final result = await userRepositoryImpl.getUsers();

          verifyZeroInteractions(mockUserRemoteDataSource);
          verify(mockUserLocalDataSource.getLastUsersModel());
          expect(result, equals(Left(CacheFailure())));
        },
      );
    });
  });

  group('getUser by Id', () {
    const userId = 1;
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test('should return remote user when it is successful', () async {
        when(mockUserRemoteDataSource.getUser(any)).thenAnswer((_) async {
          return userModels[0];
        });

        final result = await userRepositoryImpl.getUser(userId);

        verify(mockUserRemoteDataSource.getUser(userId));
        expect(result, equals(Right(user)));
      });

      test('should return server failure when it is unsuccessful', () async {
        when(mockUserRemoteDataSource.getUser(any))
            .thenThrow(ServerException());

        final result = await userRepositoryImpl.getUser(userId);

        verify(mockUserRemoteDataSource.getUser(userId));
        expect(result, equals(Left(ServerFailure())));
      });
    });
  });
}
