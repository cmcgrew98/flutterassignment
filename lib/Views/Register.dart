import 'package:flutter/material.dart';
import '../components/flutter_button.dart';
import '../components/login_textfield.dart';
import '../components/sign_up.dart';
import 'UI.dart';

class Register extends StatelessWidget {
  Register({super.key});
  final userController = TextEditingController();
  final passwordController = TextEditingController();
  final retypePasswordController = TextEditingController();

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
    hintText: 'Enter your username',
    obscureText: false,
    ),
    const SizedBox(height: 10),
          //username textfield
          LoginTextfield(
            controller: userController,
            hintText: 'Enter your email',
            obscureText: false,
          ),
          const SizedBox(height: 10),

    //password textfield
    LoginTextfield(
    controller: passwordController,
    hintText: 'Enter your password',
    obscureText: true,
    ),
    const SizedBox(height:10),
          //password textfield
          LoginTextfield(
            controller: retypePasswordController,
            hintText: 'Re-type your password',
            obscureText: true,
          ),
          const SizedBox(height:10),
          SignUp(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => UI()));
              }
          ),

]
    ),
        ),
    ),
    );
  }

}
