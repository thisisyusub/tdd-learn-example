import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_example/core/states/data_state.dart';
import 'package:tdd_example/features/get_users/domain/entities/user.dart';

import '../mocks/mock_users.dart';

void main() {
  group(
    'DataState',
    () {
      test(
        'should return instance of [Initial]',
        () {
          expect(const DataState.initial(), isA<Initial>());
        },
      );

      test(
        'should return instance of [InProgress]',
        () {
          expect(const DataState.inProgress(), isA<InProgress>());
        },
      );

      test(
        'should return instance of [Failure]',
        () {
          expect(const DataState.failure(), isA<Failure>());
        },
      );

      test(
        'should return instance of [Success] with data',
        () {
          const state = DataState.success(users);

          expect(state, isA<Success>());
          expect((state as Success).data, isA<List<User>>());
        },
      );
    },
  );
}
