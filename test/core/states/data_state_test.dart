import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_example/core/states/data_state.dart';

import '../../mocks/mock_users.dart';

void main() {
  group(
    'DataState',
    () {
      void buildExpectations<T>(
        DataState<T> state, {
        final bool isInProgress = false,
        final bool isFailure = false,
        final bool isSuccess = false,
        final bool isEmpty = false,
        final T? data,
      }) {
        expect(state.isInProgress, isInProgress);
        expect(state.isFailure, isFailure);
        expect(state.isSuccess, isSuccess);
        expect(state.isEmpty, isEmpty);
        expect(state.data, equals(data));
      }

      test(
        'should return default values',
        () {
          buildExpectations(DataState.initial());
        },
      );

      test(
        'should return [isInProgress = true]',
        () {
          buildExpectations(
            DataState.inProgress(),
            isInProgress: true,
          );
        },
      );

      test(
        'should return [isFailure = true]',
        () {
          buildExpectations(
            DataState.failure(),
            isFailure: true,
          );
        },
      );

      test(
        'should return [isEmpty = true]',
        () {
          buildExpectations(
            DataState.empty(),
            isEmpty: true,
          );
        },
      );

      test(
        'should return [isSuccess = true] and data',
        () {
          buildExpectations(
            DataState.success(users),
            isSuccess: true,
            data: users,
          );
        },
      );
    },
  );
}
