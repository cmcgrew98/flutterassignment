import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterassignment/helper/helper_functions.dart';
import '../components/login_textfield.dart';
import '../components/flutter_button.dart';
import 'UI.dart';

class Login extends StatefulWidget {
  final void Function()? onTap;

  const Login({
    super.key,
    required this.onTap,
  });
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() async {
    showDialog(context: context,
      builder: (context) => const Center(
          child: CircularProgressIndicator()
      ),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      if (context.mounted) Navigator.pop(context);
    }
    on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      displayMessageToUser((e.code), context);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 50),

            const Icon(Icons.add_box, size: 75,),

            LoginTextfield(
              controller: emailController,
              hintText: 'Enter your email',
              obscureText: false,
            ),
            const SizedBox(height: 10),

            LoginTextfield(
              controller: passwordController,
              hintText: 'Enter your password',
              obscureText: true,
            ),
            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.end,

                children: [
                  Text('Forgot password?',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            //sign in button
            FlutterButton(
              onTap: login,
              text: "Sign in",
            ),

            //Don't have an account? Register here
            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Dont have an account? "),
                GestureDetector(
                  onTap: widget.onTap,
                  child: const Text (
                    "Register here",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        )
      )
    );
  }
}
