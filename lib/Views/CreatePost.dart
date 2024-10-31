import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterassignment/Views/UI.dart';
import 'package:flutterassignment/components/pick_image_button.dart';
import 'package:flutterassignment/components/post_textfield.dart';
import '../components/post_button.dart';
import '../components/uploadPic.dart';
import 'package:image_picker/image_picker.dart';

class CreatePost extends StatefulWidget {
  CreatePost({super.key});

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final postController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  File? _selectedImage;
  String? postText;
  bool _isUploading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50),

                // Logo
                const Icon(
                  Icons.add_box,
                  size: 75,
                ),
                const SizedBox(height: 10),

               // Button to pick image (gallery or camera)
                PickImageButton(
                    onTap: () async {
                      await showImageSourceActionSheet(context);
                    }),
                const SizedBox(height: 10),

                // Display selected image or prompt to select an image
                if (_selectedImage != null)

                 Container(
                    child: Image.file(
                      _selectedImage!,
                    ),
                  ),
                const SizedBox(height: 10),

                // Text field for post content
                PostTextfield(
                  controller: postController,
                  hintText: "Post text...",
                ),
                const SizedBox(height: 10),

                // Show progress indicator when uploading
                if (_isUploading) const CircularProgressIndicator(),

                // Post button
                PostButton(onTap: () async {
                  setState(() {
                    postText = postController.text;
                    _isUploading = true;
                  });

                  // Upload image and post text to Firebase
                  await _uploadPost();

                  setState(() {
                    _isUploading = false;
                  });

                 Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (BuildContext context) => UI()));
                }),
             ],
            ),
          ),
        ),
      ),
    );
  }

  // Show a dialog to let the user choose between the camera or gallery
  Future<void> showImageSourceActionSheet(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Camera'),
                  onTap: () async {
                    Navigator.of(context).pop(); // Close the bottom sheet
                    await pickImage(ImageSource.camera); // Pick from camera
                  }),
              ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Gallery'),
                  onTap: () async {
                    Navigator.of(context).pop(); // Close the bottom sheet
                    await pickImage(ImageSource.gallery); // Pick from gallery
                  }),
            ],
          ),
        );
      },
    );
  }

  // Method to pick image from the selected source (camera or gallery)
  pickImage(ImageSource source) async {
    final returnedImage = await ImagePicker().pickImage(source: source);
    if (returnedImage != null) {
      setState(() {
        _selectedImage = File(returnedImage.path);
      });
    }
  }

  // The framework for following method was generated using ChatGPT before being modified.
  // Method to upload the image to Firebase Storage and the post text to Firestore
  Future<void> _uploadPost() async {
    if (_selectedImage != null && postText != null && postText!.isNotEmpty) {
      try {
        // Upload image to Firebase Storage
        String imageUrl = await uploadPic('post_photos/', _selectedImage!);

        // Got from dshukertjr on stack overflow.
        // https://stackoverflow.com/questions/54000825/how-to-get-the-current-user-id-from-firebase-in-flutter
        final User user = auth.currentUser!;

        // Upload post data to Firestore
        final newPost =  FirebaseFirestore.instance.collection('posts').doc();
        newPost.set({
          'author_id': user.email,
          'caption': postText,
          'date': FieldValue.serverTimestamp(),
          'post_id': newPost.id,
        });

        //Upload photo data to Firestore
        await FirebaseFirestore.instance.collection('photos').add({
          'caption': postText,
          'photo_img_link': imageUrl,
          'post_id': newPost.id,
        });

        print("Post uploaded successfully!");

      } catch (e) {
        print("Error uploading post: $e");
      }
    } else {
      print("No image or text to upload.");
    }
  }
}
