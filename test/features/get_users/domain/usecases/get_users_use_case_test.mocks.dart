// Mocks generated by Mockito 5.0.16 from annotations
// in tdd_example/test/features/get_users/domain/usecases/get_users_use_case_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:tdd_example/core/error/failure.dart' as _i5;
import 'package:tdd_example/features/get_users/domain/entities/user.dart'
    as _i6;
import 'package:tdd_example/features/get_users/domain/repositories/i_user_repository.dart'
    as _i3;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [IUserRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockIUserRepository extends _i1.Mock implements _i3.IUserRepository {
  MockIUserRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.User>>> getUsers() =>
      (super.noSuchMethod(Invocation.method(#getUsers, []),
          returnValue: Future<_i2.Either<_i5.Failure, List<_i6.User>>>.value(
              _FakeEither_0<_i5.Failure, List<_i6.User>>())) as _i4
          .Future<_i2.Either<_i5.Failure, List<_i6.User>>>);
  @override
  String toString() => super.toString();
}
