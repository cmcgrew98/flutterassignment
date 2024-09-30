import 'package:flutter/material.dart';

class FlutterButton extends StatelessWidget{
  final Function()? onTap;
  const FlutterButton({super.key,
  required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: onTap,
      child: Container(
      padding: EdgeInsets.all(25),
      margin: EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
          color: Colors.lightBlue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Text("Sign In",
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