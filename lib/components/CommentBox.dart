import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; // Import this for date formatting

import '../helper/helper_functions.dart';

/*
This was created with the help of ChatGPT and the following StackOverflow link.
https://stackoverflow.com/questions/65746171/comment-box-as-facebook-in-flutter
 */

class CommentBox extends StatefulWidget {
  final TextEditingController controller;
  final BorderRadius inputRadius;
  final VoidCallback onSend;
  final VoidCallback onImageRemoved;
  final Stream<QuerySnapshot> commentStream;
  final String postId;

  const CommentBox({
    required this.postId,
    required this.commentStream,
    required this.controller,
    required this.inputRadius,
    required this.onSend,
    required this.onImageRemoved,
    Key? key,
  }) : super(key: key);

  @override
  _CommentBoxState createState() => _CommentBoxState();
}

class _CommentBoxState extends State<CommentBox> {
  void addComment() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser!;

    try {
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.postId)
          .collection('comments')
          .add({
        'author_id': user.email,
        'date': FieldValue.serverTimestamp(),
        'text': widget.controller.text,
      });

      widget.controller.clear();
      widget.onSend();
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      displayMessageToUser(e.code, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: widget.commentStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Text('No comments yet');
            }

            final comments = snapshot.data!.docs;

            return FutureBuilder<List<Map<String, dynamic>>>(
              future: _fetchUserData(comments),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (!userSnapshot.hasData) {
                  return const Text('Error fetching user data');
                }

                final userDataMap = userSnapshot.data!;

                return Column(
                  children: comments.map((doc) {
                    Map<String, dynamic> comment = doc.data() as Map<String, dynamic>;

                    final userData = userDataMap.firstWhere(
                          (user) {
                        return user['user_id'] == comment['author_id'];
                      },
                      orElse: () {
                        return {'username': 'Unknown User', 'avatarUrl': ''};
                      },
                    );

                    // Format the date
                    Timestamp timestamp = comment['date'];
                    String date = timestamp != null
                        ? DateFormat('yyyy-MM-dd HH:mm').format(timestamp.toDate())
                        : 'Unknown date';

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: ListTile(
                        leading: FutureBuilder<String>(
                          future: getDownloadUrl(userData['avatarUrl']),
                          builder: (context, imageSnapshot) {
                            if (imageSnapshot.connectionState == ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            }
                            if (imageSnapshot.hasError || !imageSnapshot.hasData || imageSnapshot.data!.isEmpty) {
                              return const CircleAvatar(
                                backgroundColor: Colors.grey,
                                child: Icon(Icons.person), // Placeholder icon
                              );
                            }
                            return CircleAvatar(
                              backgroundImage: NetworkImage(imageSnapshot.data!),
                            );
                          },
                        ),
                        title: Text(
                          userData['username'] ?? 'Unknown User',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              comment['text'] ?? '',
                              style: const TextStyle(color: Colors.black),
                            ),
                            Text(
                              date,
                              style: const TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            );
          },
        ),
        const SizedBox(height: 10),
        TextField(
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: 'Add a comment...',
            border: OutlineInputBorder(
              borderRadius: widget.inputRadius,
            ),
            suffixIcon: IconButton(
              icon: Icon(Icons.send),
              onPressed: addComment,
            ),
          ),
        ),
      ],
    );
  }

  Future<List<Map<String, dynamic>>> _fetchUserData(List<QueryDocumentSnapshot> comments) async {
    var userIds = comments.map((doc) => doc['author_id']).toSet().toList();

    List<Map<String, dynamic>> allUserData = [];

    for (var i = 0; i < userIds.length; i += 10) {
      var batchIds = userIds.sublist(i, i + 10 > userIds.length ? userIds.length : i + 10);

      QuerySnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where(FieldPath.documentId, whereIn: batchIds)
          .get();

      var batchUserData = userSnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return {
          'user_id': doc.id,
          'username': data['username'],
          'avatarUrl': data['avatar_img_link'],
        };
      }).toList();

      allUserData.addAll(batchUserData);
    }

    return allUserData;
  }

  Future<String> getDownloadUrl(String path) async {
    try {
      final ref = FirebaseStorage.instance.ref(path);
      return await ref.getDownloadURL();
    } catch (e) {
      print('Error getting download URL for path $path: $e');
      return '';
    }
  }
}
