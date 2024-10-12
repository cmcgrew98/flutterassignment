import 'package:flutter/material.dart';
import '../Views/Register.dart';
import '../Views/Login.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showLoginPage) {
      return Login(onTap: togglePages);
    } else {
      return Register(onTap: togglePages);
    }

  }
}