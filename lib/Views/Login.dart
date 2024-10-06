import 'package:flutter/material.dart';
import '../components/login_text.dart';
import '../components/login_textfield.dart';
import '../components/flutter_button.dart';
import 'Home.dart';
import 'Register.dart';
class Login extends StatelessWidget {
  Login({super.key});

  final userController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
                child: Column(children: [
                  const SizedBox(height: 50),
                  //Logo
                  const Icon(Icons.add_box, size: 75,),

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
                  const SizedBox(height: 10),

                  //forgot password?
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
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => Home()));
                      }
                  ),

                  //Don't have an account? Register here
                  const SizedBox(height: 10),
                  LoginText(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => Register()));
                    },
                  )


                ],)

            )
        ));
  }

}
