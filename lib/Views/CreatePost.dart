import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutterassignment/components/pick_image_button.dart';
import 'package:flutterassignment/components/post_textfield.dart';
import '../components/post_button.dart';
import 'UI.dart';

class CreatePost extends StatefulWidget {
  CreatePost({super.key});

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final postController = TextEditingController();
  File? _selectedImage;
  String? postText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
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
              // Wrapping the image in a flexible container to avoid overflow
                Container(
                  height: 400,  // You can adjust this value to fit your layout
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  child: Image.file(
                    _selectedImage!,
                    fit: BoxFit.cover,  // Ensures the image is resized to fit the container
                  ),
                ),

              // Text field for post content
              PostTextfield(
                controller: postController,
                hintText: "Post text...",
              ),
              const SizedBox(height: 10),

              // Post button
              PostButton(onTap: () {
                setState(() {
                  postText = postController.text;
                });

                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (BuildContext context) => UI()));

                print('Post Text: $postText');
              }),
            ],
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
                  }),
              ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Gallery'),
                  onTap: () async {
                    Navigator.of(context).pop(); // Close the bottom sheet
                  }),
            ],
          ),
        );
      },
    );
  }

}

