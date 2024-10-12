import 'package:flutter/material.dart';
import '../components/login_text.dart';
import '../components/login_textfield.dart';
import '../components/flutter_button.dart';
import 'UI.dart';
import 'Register.dart';
class Login extends StatelessWidget {
  final void Function()? onTap;

  Login({
    super.key,
    required this.onTap,
  });
  final userController = TextEditingController();
  final passwordController = TextEditingController();

  void login() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 50),

            const Icon(Icons.add_box, size: 75,),

            LoginTextfield(
              controller: userController,
              hintText: 'Enter your username or email',
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
                  onTap: onTap,
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
