import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../helper/helper_functions.dart';
import 'ReactionWidget.dart';
import '../views/profile2.dart';

class Posts extends StatelessWidget {
  final List<String> avatarUrls; // List of avatar URLs
  final String user;              // User's name
  final String postContent;       // Content of the post
  final List<String> photoUrls;   // List of photo URLs for the post

  const Posts({
    required this.avatarUrls,
    required this.user,
    required this.postContent,
    required this.photoUrls,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // Display avatars
            ...avatarUrls.map((avatarUrl) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0), // Adjust horizontal padding as needed
                child: CircleAvatar(
                  backgroundImage: NetworkImage(avatarUrl), // Display avatar image from URL
                ),
              );
            }).toList(),
            const SizedBox(width: 10), // Space between avatars and username
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => Profile(username: user),
                ),
                );
              },
              child: Text(
                user,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        // Display each photo for the post
        Column(
          children: photoUrls.map((photoUrl) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Image.network(photoUrl), // Display image from Firebase Storage
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ReactionWidget(),
            const SizedBox(width: 8), // Small space between icons
            const Icon(Icons.chat_bubble_outline),
            const SizedBox(width: 8), // Small space between icons
            const Icon(Icons.share),
            const SizedBox(width: 10),
          ],
        ),
        const SizedBox(height: 10), // Added space after the icons
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$user ', // User's name with a space
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: postContent, // Display post content
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
