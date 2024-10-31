import 'package:flutter/material.dart';
import 'package:flutterassignment/components/chat_service.dart';
import 'package:flutterassignment/components/user_chat_tile.dart';
import 'package:flutterassignment/Views/Chat.dart';

class ChatSelect extends StatelessWidget {
  ChatSelect({super.key});


  final ChatService _chatService = ChatService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUserList(),
    );
  }


  //Make a list of chats to open
  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError){
          return const Text("Error");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }

        return ListView(
          children: snapshot.data!.map<Widget>((userData) => _buildUserListItem(userData, context)).toList(),
        );
      },
    );
  }

  //Build each user displayed in the list
  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
    return UserChatTile(
      text: userData["username"],
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Chat(
                receiverName: userData["username"],
                receiverID: userData["uid"],
              ),
            ),
        );
      },
    );
  }
}