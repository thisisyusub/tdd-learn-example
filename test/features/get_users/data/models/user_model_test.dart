import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_example/features/get_users/data/models/user_model.dart';
import 'package:tdd_example/features/get_users/domain/entities/user.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../../core/mocks/mock_user_models.dart';

void main() {
  test('should be a subclass of [User] entity', () {
    expect(userModels[0], isA<User>());
    expect(userModels[1], isA<User>());
  });

  test('should return a valid model when a Json a valid', () {
    final List<dynamic> jsonMap = json.decode(fixture('users.json'));

    final result = jsonMap.map((e) => UserModel.fromJson(e)).toList();

    expect(result, userModels);
  });

  test('should return a valid Json when a model a valid', () {
    final userModel = userModels[0];

    final jsonMap = {
      "id": 1,
      "name": "Test User 1",
      "username": "Test Username 1",
      "email": "testuser1@gmail.com",
    };

    final result = userModel.toJson();

    expect(result, jsonMap);
  });
}
