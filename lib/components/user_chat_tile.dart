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
        decoration: BoxDecoration(color: Colors.white,
        borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.black,
            width:1.0
          )
        ),
        margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(Icons.person),
            const SizedBox(width:25,),
            Text(text, style: new TextStyle(
              fontSize: 20.0,
            )),
          ],
        ),
      ),
    );
  }
}
