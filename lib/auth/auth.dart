import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterassignment/auth/login_or_register.dart';

import '../Views/UI.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: StreamBuilder(
         stream: FirebaseAuth.instance.authStateChanges(),
         builder: (context, snapshot) {
           if (snapshot.hasData) {
             return UI();
           }

           else {
             return const LoginOrRegister();
           }
         }
       )
    );
  }
}
