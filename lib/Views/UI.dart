import 'package:flutter/material.dart';
import '../helper/helper_functions.dart';
import 'CreatePost.dart';
import 'UserHome.dart';
import 'UserProfile.dart';
import 'ChatSelect.dart';

class UI extends StatefulWidget {
  const UI({super.key});

  @override
  State createState() => _HomeState();
}

class _HomeState extends State<UI> {
  int indexSelected = 0;

  void navigateBar(int index) {
    setState(() {
      indexSelected = index;
    });
  }

  final List<Widget> _children = [
    UserHome(),
    Center(child: Text('Search')),
    profile(),
    ChatSelect(),
    CreatePost(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Row(
          children: [
            Text(
              'Social Media',
              style: TextStyle(color: Colors.white),
            ),
            Icon(Icons.favorite),
          ],
        ),
        actions: [
          IconButton(
            onPressed: logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: _children[indexSelected],
      bottomNavigationBar: BottomNavigationBar(
        onTap: navigateBar,
        currentIndex: indexSelected,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Create Post"),
        ],
      ),
    );
  }
}
