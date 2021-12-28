import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_example/data/models/post_model.dart';
import 'package:tdd_example/domain/entities/post.dart';

import '../../fixtures/fixture_reader.dart';
import '../../mocks/mock_post_models.dart';

void main() {
  test('should be a subclass of [Post] entity', () {
    for (var postModel in postModels) {
      expect(postModel, isA<Post>());
    }
  });

  test('should return a valid model when a Json a valid', () {
    final List<dynamic> jsonMap = json.decode(fixture('posts.json'));

    final result = jsonMap.map((e) => PostModel.fromJson(e)).toList();

    expect(result, postModels);
  });

  test('should return a valid Json when a model a valid', () {
    final postModel = postModels[0];

    final jsonMap = {
      "userId": 1,
      "id": 1,
      "title": 'Post Title 1',
      "body": 'Post Body 1',
    };

    final result = postModel.toJson();

    expect(result, jsonMap);
  });
}
