import 'package:flutter/material.dart';

class Posts extends StatelessWidget {
  final String user;
  const Posts({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[400],
              ),
            ),
            const SizedBox(width: 10),
            Text(
              user,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          height: 300,
          color: Colors.grey,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Icon(Icons.favorite),
            const SizedBox(width: 8), // Small space between icons
            const Icon(Icons.chat_bubble_outline),
            const SizedBox(width: 8), // Small space between icons
            const Icon(Icons.share),
            const SizedBox(width: 10),
          ],
        ),
        const SizedBox(height: 10), // Added space after the icons
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$user ', // Fixed missing space
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const TextSpan(
                  text: 'This is a post',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
