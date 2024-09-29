import 'package:flutter/material.dart';

import '../components/login_textfield.dart';
class Login extends StatelessWidget {
  Login({super.key});
final userController = TextEditingController();
final passwordController = TextEditingController();

  @override
Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
          child: Column(children:  [
            const SizedBox(height: 50),
        //Logo
        const Icon(Icons.add_box, size:75,),

        //username textfield
      LoginTextfield(
        controller: userController,
        hintText: 'Enter your username or email',
        obscureText: false,
      ),
const SizedBox(height: 10),
        //password textfield
            LoginTextfield(
              controller: passwordController,
            hintText: 'Enter your password',
              obscureText: true,
            ),
        //forgot password?
        //sign in button

        //or continue with Google

        //register here


      ],)

    )
    ));
}


}