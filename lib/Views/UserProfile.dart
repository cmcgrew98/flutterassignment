import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../helper/helper_functions.dart';


class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<profile> {
  User? currentUser = FirebaseAuth.instance.currentUser;
  String _username = 'User';
  String _description = 'Enter Description';

  //Code to edit fields
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();


   void logout() {
     FirebaseAuth.instance.signOut();
   }


  //Used Chat GPT to debug when combining code from orignal file and Renee's file
  Future<void> getUserDetails() async {
    if (currentUser != null) {
      DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
          .instance
          .collection("users")
          .doc(currentUser!.email)
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
  }

  Future<void> _updateUserDetails() async {
    if (currentUser != null) {
      await FirebaseFirestore.instance.collection("users")
          .doc(currentUser!.email)
          .update({
        'username': _username,
        'description': _description,
      });
    }
  }


  @override
  void initState() {
    super.initState();
    getUserDetails(); // Fetch user details when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 10, width: 40),
              Icon(Icons.person,
                  size: 100
              ),
              new Spacer(),
              GestureDetector(
                onTap:() => showMenu(context),
                child: Icon(Icons.menu, color:Colors.black),
              ),

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
  void showMenu(BuildContext context) {
    _usernameController.text = _username;
    _descriptionController.text = _description;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Profile'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(labelText: 'Username'),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
              ],
            ),
          ),
          actions:[
            TextButton(
              child: Text('Logout'),
              onPressed: (){
                logout();
                Navigator.pop(context);
              },

            ),
            TextButton(
                child: Text('Save'),
                onPressed: () async {
                  String newUsername = _usernameController.text;

                  if (newUsername.isNotEmpty && !newUsername.contains(' ')) {
                    setState(() {
                      _username = newUsername;
                      _description = _descriptionController.text;
                    });
                    await _updateUserDetails();
                    Navigator.pop(context);
                  } else {
                    // Show error message if username is empty or contains spaces
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Username cannot be empty or contain spaces.'),
                      ),
                    );
                  }
                },

            ),
            TextButton(
              child: Text('Cancel'),
              onPressed:(){
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}


