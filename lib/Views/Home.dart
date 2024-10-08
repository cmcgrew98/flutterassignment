import 'package:flutter/material.dart';
import 'UserHome.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();

}
class _HomeState extends State<Home> {
  int indexSelected = 0;
   void navigateBar(int index){
   setState((){
indexSelected = index;
   });
   }
   final List<Widget> _children = [
   UserHome(),
     Center(child:Text('Search')),
     Center(child:Text('Profile')),
     Center(child:Text('Chat')),
     Center(child:Text('Create Post')),
   ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title:Row(
          children: [
            Text(
                'Social Media',
            style: TextStyle(color: Colors.white),
            ),
            Icon(Icons.favorite),
          ],
        ),
      ),
      body: _children[indexSelected],
      bottomNavigationBar: BottomNavigationBar(
        onTap: navigateBar,
        currentIndex: indexSelected,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "home"),
          BottomNavigationBarItem(icon: Icon(Icons.search),label: "search"),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: "profile"),
          BottomNavigationBarItem(icon: Icon(Icons.chat),label: "Chat"),
          BottomNavigationBarItem(icon: Icon(Icons.add),label: "Create Post"),
        ],
      ),
    );
  }

}
