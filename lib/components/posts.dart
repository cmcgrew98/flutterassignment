import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import '../Views/profile.dart';
import 'ReactionWidget.dart';
import 'CommentBox.dart';

class Posts extends StatefulWidget {
  final List<String> avatarUrls;
  final String user;
  final String postContent;
  final List<String> photoUrls;
  final DateTime date;
  final String postId;

  const Posts({
    required this.avatarUrls,
    required this.user,
    required this.postContent,
    required this.photoUrls,
    required this.date,
    required this.postId,
    Key? key,
  }) : super(key: key);

  @override
  _PostsState createState() => _PostsState();
}


class _PostsState extends State<Posts> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  List<Map<String, String>> comments = [];

  void _addComment(String comment) {
    setState(() {
      comments.insert(0, {
        'name': 'New User',
        'pic': 'https://picsum.photos/200/300',
        'message': comment,
      });
    });
  }

  // Define the comment stream directly without async function
  Stream<QuerySnapshot<Object?>> get commentStream {
    return FirebaseFirestore.instance
        .collection("posts")
        .doc(widget.postId)
        .collection("comments")
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(widget.date);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ...widget.avatarUrls.map((avatarUrl) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(avatarUrl),
                ),
              );
            }).toList(),
            const SizedBox(width: 10),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => profile(),
                  ),
                );
              },
              child: Text(
                widget.user,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Column(
          children: widget.photoUrls.map((photoUrl) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Image.network(photoUrl),
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                ReactionWidget(),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.chat_bubble_outline),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            constraints: BoxConstraints(
                              maxHeight: 400,
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CommentBox(
                                    postId: widget.postId,
                                    commentStream: commentStream,
                                    controller: commentController,
                                    inputRadius: BorderRadius.circular(32),
                                    onSend: () {
                                      if (commentController.text.isNotEmpty) {
                                        _addComment(commentController.text);
                                        commentController.clear();
                                        FocusScope.of(context).unfocus();
                                      } else {
                                        print("Comment cannot be blank");
                                      }
                                    },
                                    onImageRemoved: () {},
                                  ),
                                  const SizedBox(height: 10),
                                  // Display comments below the CommentBox
                                  ...comments.map((comment) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundImage: NetworkImage(comment['pic'] ?? ''),
                                        ),
                                        title: Text(
                                          comment['name'] ?? 'Unknown User',
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                          comment['message'] ?? '',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () {
                Share.share('Check out this post by ${widget.user} on FlutterShare! ${widget.postContent}');
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${widget.user} ',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                formattedDate,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: widget.postContent,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
