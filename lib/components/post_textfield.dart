import 'package:flutter/material.dart';

class PostTextfield extends StatelessWidget {
  final controller;
  final String hintText;

  const PostTextfield({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: TextField(
          controller: controller,
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
          maxLines: 5,
          minLines: 3,
        )    //post textfield
    );
  }

}