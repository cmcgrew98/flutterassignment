import 'package:flutter/material.dart';

class UserChatTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const UserChatTile({
    super.key,
    required this.text,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(color: Color.fromARGB(10, 0, 0, 0),
        borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(Icons.person),
            Text(text),
          ],
        ),
      ),
    );
  }
}
