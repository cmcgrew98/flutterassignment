import 'package:flutter/material.dart';

class ReactionWidget extends StatefulWidget {
  @override
  _ReactionWidgetState createState() => _ReactionWidgetState();
}

class _ReactionWidgetState extends State<ReactionWidget> {
  String selectedReaction = 'Like'; // Default reaction

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
              Icon(
                Icons.favorite,
                color: selectedReaction == 'Like' ? Colors.red : Colors.grey,
              ),
              const SizedBox(width: 8),
              Text(selectedReaction),
            ],
          ),
        ),
        const SizedBox(width: 8), // Small space between icons
      ],
    );
  }
}
