import 'package:flutter/material.dart';

class LoginTextfield extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;

  const LoginTextfield({
    super.key,
  required this.controller,
    required this.hintText,
    required this.obscureText
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return  Padding(
       padding: const EdgeInsets.symmetric(horizontal: 25),
       child: TextField(
         controller: controller,
         obscureText: obscureText,
         decoration: InputDecoration(
           enabledBorder: const OutlineInputBorder(
             borderSide: BorderSide(color: Colors.black),
           ),
           focusedBorder: const OutlineInputBorder(
               borderSide: BorderSide(color: Colors.black)
           ),
           fillColor: Colors.white12,
           filled: true,
           hintText: hintText,
           hintStyle: const TextStyle(color: Colors.grey),
         ),
       )    //password textfield
   );
  }

}