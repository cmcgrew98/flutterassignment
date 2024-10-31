import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

// Method uploads an image to firebase storage and returns the url in the correct format
Future<String> uploadPic(String location, File image) async {
  Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('$location${basename(image.path)}');
  await firebaseStorageRef.putFile(image);
  return "gs://flutterproject-5cb92.appspot.com/$location${basename(image.path)}";
}