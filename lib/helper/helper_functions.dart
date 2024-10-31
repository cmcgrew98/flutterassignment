import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void displayMessageToUser(String message, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(message),
    ),
  );
}

void logout() {
  FirebaseAuth.instance.signOut();
}

//Code created with the help of ChatGPT
String extractRelativePath(String gsUrl) {
  // Remove the "gs://<bucket-name>/" part to get the relative path
  final RegExp gsUrlPattern = RegExp(r'gs://[^/]+/');
  return gsUrl.replaceFirst(gsUrlPattern, '');
}
