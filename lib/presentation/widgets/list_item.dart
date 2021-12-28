import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
    required this.leading,
    required this.title,
    required this.body,
    this.onTap,
  }) : super(key: key);

  final String leading;
  final String title;
  final String body;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        child: Text(leading),
      ),
      title: Text(title),
      subtitle: Text(body),
    );
  }
}
