import 'package:flutter/material.dart';

class profile extends StatefulWidget {
  const profile({super.key});


  @override
  State<profile> createState() => _profilePageState();
}

class _profilePageState extends State<profile> {

  String _username = 'User';
  String _description = 'Enter Description';


  @override
  Widget build(BuildContext context) {
    return Scaffold(import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Profile extends StatefulWidget {
  final String username;
  const Profile({super.key, required this.username});

  @override
  State<Profile> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<Profile> {

  String _username = 'User';
  String _description = 'Enter Description';
  bool _isFollowing = false;


  //Used Chat GPT to debug when combining code from orignal file and Renee's file
  Future<void> getUserDetails() async {
      DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
          .instance
          .collection("users")
          .doc(widget.username)
          .get();
      if (userDoc.exists) {
        setState(() {
          _username = userDoc.data()?['username'] ?? 'No username available';
          _description = userDoc.data()?['description'] ?? 'No description available';
        });
      } else {
        setState(() {
          _username = 'No user data found';
          _description = '';
        });
      }
    }
  void _toggleFollow() {
    setState(() {
      _isFollowing = !_isFollowing; // Toggle follow state
    });
  }

    @override
  void initState() {
    super.initState();
    getUserDetails(); // Fetch user details when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        //Firebase Profile Edit
        title: Text("$_username's Profile",
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white)
        ),
        backgroundColor: Colors.lightBlue,
      ),

      body: ListView(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 10, width: 40),
              Icon(Icons.person,
                  size: 100),
              SizedBox(height: 10, width: 40),
            ],
          ),

          //User Name
          const SizedBox(height: 5),
          Container(
            margin: const EdgeInsets.all(25.0),
            padding: const EdgeInsets.only(left: 10.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.lightBlue)
            ),
            child: Text(
              _username,
              style: const TextStyle(color: Colors.black),
            ),
          ),

          //Description
          const SizedBox(height: 5),
          Container(
            margin: const EdgeInsets.all(25.0),
            padding: const EdgeInsets.only(left: 10.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.lightBlue)
            ),
            child:
            Text(
              _description,
              style: const TextStyle(color: Colors.black),

            ),
          ),

          Container(
            margin: const EdgeInsets.all(25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _toggleFollow,
                  child: Text(_isFollowing ? 'Unfollow' : 'Follow'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isFollowing ? Colors.red : Colors.blue, // Change color based on state
                  ),
                ),
              ],
            ),
          ),





          //User Posts
          const SizedBox(height: 5),
          Container(
            margin: const EdgeInsets.all(25.0),
            padding: const EdgeInsets.only(left: 10.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.lightBlue)
            ),
            child:
            const Text(
              "Posts",
              style: TextStyle(color: Colors.black),
            ),
          ),
  ],
      ),
    );

  }
}





        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          //Firebase Profile Edit
          title: Text("$_username's Profile",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white)
          ),

          backgroundColor: Colors.lightBlue,


        ),
        body: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 10, width: 40),
                Icon(Icons.person,
                    size: 100
                ),
                const SizedBox(height: 10, width: 40),

              ],
            ),

            //User Name
            const SizedBox(height: 5),
            Container(
              margin: const EdgeInsets.all(25.0),
              padding: const EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.lightBlue)
              ),
              child: Text(
                '$_username',
                style: TextStyle(color: Colors.black),
              ),
            ),

            //Description
            const SizedBox(height: 5),
            Container(
              margin: const EdgeInsets.all(25.0),
              padding: const EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.lightBlue)
              ),
              child:
              Text(
                "$_description",
                style: TextStyle(color: Colors.black),

              ),
            ),


            //User Posts
            const SizedBox(height: 5),
            Container(
              margin: const EdgeInsets.all(25.0),
              padding: const EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.lightBlue)
              ),
              child:
              Text(
                "Posts",
                style: TextStyle(color: Colors.black),
              ),
            ),

          ],
        )
    );
  }
}

