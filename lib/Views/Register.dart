import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/login_textfield.dart';
import '../components/flutter_button.dart';
import '../helper/helper_functions.dart';

class Register extends StatefulWidget {
  final void Function()? onTap;

  const Register({
    super.key,
    required this.onTap,
  });

  @override
  State<Register> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<Register> {
  final userController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPwController = TextEditingController();

  void register() async {
    showDialog(context: context,
        builder: (context) => const Center(
            child: CircularProgressIndicator()
        ),
    );

    if (passwordController.text != confirmPwController.text) {
      Navigator.pop(context);
      displayMessageToUser("Passwords don't match", context);
    }
    else {
      try {
        UserCredential? userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        createUserDocument(userCredential);
        if(context.mounted) Navigator.pop(context);

      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        displayMessageToUser(e.code, context);
      }
    }
  }

  Future<void> createUserDocument(UserCredential? userCredential) async {
    if(userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
        .collection("users")
        .doc(userCredential.user!.email)
          .set({
            'email': userCredential.user!.email,
            'username': userController.text,
            'bio': "default bio",
            'avatar_img_link': "gs://flutterproject-5cb92.appspot.com/user_avatars/blank_profile.jpg",
            'uid': userCredential.user!.uid,
            'date': FieldValue.serverTimestamp(),
        });
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
                  controller: userController,
                  hintText: 'Enter your username',
                  obscureText: false,
                ),
                const SizedBox(height: 10),

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

                LoginTextfield(
                  controller: confirmPwController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),
                const SizedBox(height: 10),

                FlutterButton(
                  onTap: register,
                  text: "Register",
                ),

                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? "),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text (
                        "Sign in",
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
