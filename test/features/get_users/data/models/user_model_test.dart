import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_example/features/get_users/data/models/user_model.dart';
import 'package:tdd_example/features/get_users/domain/entities/user.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const userModels = [
    UserModel(
      id: 1,
      name: 'Test User 1',
      username: 'Test Username 1',
      email: 'testuser1@gmail.com',
    ),
    UserModel(
      id: 2,
      name: 'Test User 2',
      username: 'Test Username 2',
      email: 'testuser2@gmail.com',
    )
  ];

  test('should be a subclass of [User] entity', () {
    expect(userModels[0], isA<User>());
    expect(userModels[1], isA<User>());
  });

  test('should return a valid model when a Json a valid', () {
    final List<dynamic> jsonMap = json.decode(fixture('users.json'));

    final result = jsonMap.map((e) => UserModel.fromJson(e)).toList();

    expect(result, userModels);
  });
}
