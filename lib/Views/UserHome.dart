import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../components/posts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../helper/helper_functions.dart';
/*
This code was created with the help of https://stackoverflow.com/questions/73283547/how-to-retrieve-an-image-from-firestore-database-flutter,
and the code was modified using ChatGPT
Also used https://stackoverflow.com/questions/50877398/flutter-load-image-from-firebase-storage for help in retrieving an image from firebase storage
 */


class UserHome extends StatefulWidget {
  UserHome({Key? key}) : super(key: key);

  // final List people = ['John', 'Jane', 'Jack', 'Jill', 'James', 'Jenny', 'Jasper', 'Jade', 'Jared', 'Jocelyn'];
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {

  List<Map<String, dynamic>> userDataList = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getPosts();
  }

  void getPosts() async {
    var fireStoreInstance = FirebaseFirestore.instance;

    // Step 1: Fetch all users from the 'users' collection
    QuerySnapshot userSnapshot = await fireStoreInstance.collection("users").get();

    // Temporary list to store users, posts, and images
    List<Map<String, dynamic>> tempList = [];

    // Step 2: For each user, fetch their corresponding posts from the 'posts' collection
    for (var userDoc in userSnapshot.docs) {
      String userId = userDoc.id;
  // String userAvatar = userDoc["avatar_img_link"] as String;
      String userName = userDoc["username"] as String;

      // Step 3: Fetch all posts where 'userId' matches the current user
      QuerySnapshot postSnapshot = await fireStoreInstance
          .collection("posts")
          .where("author_id", isEqualTo: userId)
          .get();

      //Fetch the avatars where the userId matches the current user
      QuerySnapshot avatarSnapshot = await fireStoreInstance
          .collection("users").where("user_id", isEqualTo: userId).get();

      List<String> avatarUrls = avatarSnapshot.docs.map((userDoc) {
        return userDoc["avatar_img_link"] as String; // Assuming 'source' holds the image URL
      }).toList();

      List<String> avatarDownloads = [];

      for(var avatarDoc in avatarUrls){
        try {
          // Extract the relative path from the full URL
          String relativePath = extractRelativePath(avatarDoc);
          String downloadUrl = await FirebaseStorage.instance.ref(relativePath).getDownloadURL();
          avatarDownloads.add(downloadUrl);
        } on FirebaseException catch (e) {
          displayMessageToUser((e.code), context);
        }
      }

      // Step 4: For each post, fetch the photos associated with the post
      List<Map<String, dynamic>> userPosts = []; // List to hold posts and their photos for each user
      for (var postDoc in postSnapshot.docs) {
        String postId = postDoc.id;
        String postContent = postDoc["caption"] as String; // Assuming 'content' is the post data

        // Step 5: Fetch all photos where 'postId' matches the current post
        QuerySnapshot photoSnapshot = await fireStoreInstance
            .collection("photos")
            .where("post_id", isEqualTo: postId)
            .get();

        // Step 6: Create a list to store multiple photo URLs for the current post
        List<String> photoUrls = photoSnapshot.docs.map((photoDoc) {
          return photoDoc["photo_img_link"] as String; // Assuming 'source' holds the image URL
        }).toList();



        List<String> downloadUrls = [];
        for(var photoDoc in photoUrls){
          try {
            // Extract the relative path from the full URL
            String relativePath = extractRelativePath(photoDoc);
            String downloadUrl = await FirebaseStorage.instance.ref(relativePath).getDownloadURL();
            downloadUrls.add(downloadUrl);
          } on FirebaseException catch (e) {
            displayMessageToUser((e.code), context);
          }
        }

        // Add the post content and list of photos to the userPosts list
        userPosts.add({
          "avatars": avatarDownloads,
          "postContent": postContent,
          "photoUrls": downloadUrls, // List of photo URLs for this post
        });
      }

      // Step 7: Add the user, their posts, and the corresponding photos to the temporary list
      if (userPosts.isNotEmpty) {
        tempList.add({
          "name": userName,
          "posts": userPosts, // List of posts for this user
        });
      }
    }

    // Step 8: Update the UI once all data is fetched
    setState(() {
      userDataList =
          tempList; // Assign the temporary list to the state variable
      loading =
      false; // Data has been loaded, stop showing the loading indicator
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? const Center(
          child: CircularProgressIndicator()) // Show a loading indicator while data is being fetched
          : ListView.builder(
        itemCount: userDataList.length,
        itemBuilder: (context, index) {
          // Get the current user and their posts
          String userName = userDataList[index]["name"]!;
          List<Map<String, dynamic>> userPosts = userDataList[index]["posts"];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8.0),
                // Display all posts and their corresponding photos for the current user
                Column(
                  children: userPosts.map((post) {
                    String postContent = post["postContent"];
                    List<String> photoUrls = post["photoUrls"];
                    List<String> avatarUrls = post["avatars"];

                    return Posts(
                      avatarUrls: avatarUrls,
                      user: userName,
                      postContent: postContent,
                      photoUrls: photoUrls,
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

String extractRelativePath(String gsUrl) {
  // Remove the "gs://<bucket-name>/" part to get the relative path
  final RegExp gsUrlPattern = RegExp(r'gs://[^/]+/');
  return gsUrl.replaceFirst(gsUrlPattern, '');
}