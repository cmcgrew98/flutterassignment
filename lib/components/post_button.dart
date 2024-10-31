import 'package:flutter/material.dart';

class PostButton extends StatelessWidget{
  final Function()? onTap;
  const PostButton({super.key,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(25),
          margin: const EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
            color: Colors.lightBlue,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Center(
            child: Text("Make Post",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        )
    );
  }

}