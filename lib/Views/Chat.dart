import 'package:flutter/material.dart';
import 'package:flutterassignment/components/chat_bubble.dart';
import 'package:flutterassignment/components/chat_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterassignment/components/chat_text_field.dart';

class Chat extends StatelessWidget {
  final String receiverName;
  final String receiverID;
  Chat({
    super.key,
    required this.receiverName,
    required this.receiverID,
  });

  User? currentUser = FirebaseAuth.instance.currentUser;

  //textbox
  final TextEditingController _messageController = TextEditingController();

  //chat service
  final ChatService _chatService = ChatService();

  //Message sending
  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(receiverID, _messageController.text);

      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text(receiverName)),
      body: Column(
        children: [
          //displaying all the messages
          Expanded(child: _buildMessageList(),
          ),

          //user input
          _getUserInput(),
        ],
      ),
    );
  }
  Widget _buildMessageList() {
    String senderID = currentUser!.uid;
    return StreamBuilder(
        stream: _chatService.getMessages(receiverID, senderID),
        builder: (context, snapshot) {
          //error handling
          if (snapshot.hasError) {
            return const Text("Error");
          }
          // fetching info
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading...");
          }

          //List of messages
          return ListView(
            children: snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
          );
    });
  }
  //Singular message construciton
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurrentUser = data['sent_by'] == currentUser!.uid;
    var align =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;


    return Container(
      alignment: align,
      child: Column(
        crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
        ChatBubble(
            text: data['text'],
            isCurrentUser: isCurrentUser,
        )
        ],
      ),
    );
  }

  Widget _getUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom:40),
      child: Row(
        children: [
          Expanded(
            child: ChatTextField(
              controller: _messageController,
              hintText: "Type a message",
            ),
          ),

          Container(
            decoration:BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            margin: EdgeInsets.only(right:25),
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(Icons.chevron_right),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

}
