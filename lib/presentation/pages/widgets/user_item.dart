import 'package:flutter/material.dart';

import '../../../domain/entities/user.dart';

class UserItem extends StatelessWidget {
  const UserItem({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(
          '${user.id}',
        ),
      ),
      title: Text(user.name),
      subtitle: Text(user.email),
    );
  }
}
