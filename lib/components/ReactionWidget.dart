import 'package:flutter/material.dart';

class ReactionWidget extends StatefulWidget {
  /*
  Code for ReactionWidget, generated mostly using ChatGPT.
   */

  @override
  _ReactionWidgetState createState() => _ReactionWidgetState();
}

class _ReactionWidgetState extends State<ReactionWidget> {
  String selectedReaction = 'No reaction'; // Default reaction

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        PopupMenuButton<String>(
          onSelected: (String result) {
            setState(() {
              selectedReaction = result;
            });
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'Like',
              child: Text('👍 Like'),
            ),
            const PopupMenuItem<String>(
              value: 'Love',
              child: Text('❤️ Love'),
            ),
            const PopupMenuItem<String>(
              value: 'Haha',
              child: Text('😆 Haha'),
            ),
            const PopupMenuItem<String>(
              value: 'Wow',
              child: Text('😲 Wow'),
            ),
            const PopupMenuItem<String>(
              value: 'Sad',
              child: Text('😢 Sad'),
            ),
            const PopupMenuItem<String>(
              value: 'Angry',
              child: Text('😡 Angry'),
            ),
          ],
          child: Row(
            children: [
              Text(
                getReactionIcon(selectedReaction),
                style: TextStyle(
                  color: selectedReaction == 'Like' ? Colors.red : Colors.grey,
                  fontSize: 24, // Adjust the size as needed
                ),
              ),
              const SizedBox(width: 8), // Space between emoji and text
              Text(
                selectedReaction,
                style: TextStyle(
                  fontSize: 20, // Adjust text size as needed
                  color: Colors.black, // Text color
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8), // Small space between icons
      ],
    );
  }
  String getReactionIcon(String reaction) {
    switch (reaction) {
    case 'Wow':
    return '😲'; // Wow emoji
    case 'Love':
    return '❤️'; // Love emoji
    case 'Like':
    return '👍'; // Like emoji
    case 'Sad':
    return '😢'; // Sad emoji
    case 'Angry':
    return '😡'; // Angry emoji
    case 'Haha':
    return '😆'; // Haha emoji
    default:
    return '🤷'; //No reaction emoji

    }
  }
}
