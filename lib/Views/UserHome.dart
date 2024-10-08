import 'package:flutter/material.dart';
import '../components/Stories.dart';

class UserHome extends StatelessWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Stories(),
          Stories(),
          Stories(),
          Stories(),
          Stories(),
        ],
      ),
    );
  }
}
