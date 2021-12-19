import 'package:tdd_example/features/get_users/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required int id,
    required String name,
    required String username,
    required String email,
  }) : super(
          id: id,
          name: name,
          username: username,
          email: email,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
    };
  }
}
