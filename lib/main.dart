import 'package:flutter/material.dart';
import 'Views/Login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social Media Platform',
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}

