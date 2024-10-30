import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isCurrentUser;

  const ChatBubble({
    super.key,
    required this.text,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:isCurrentUser ? Colors.blue : Colors.grey.shade400,
        borderRadius: BorderRadius.circular(10)
      ),
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical:5, horizontal: 25),
      child: Text(
          text,
          style: TextStyle(color: Colors.white),
      ),
    );
  }
}