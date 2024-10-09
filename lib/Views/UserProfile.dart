import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});


  @override
  State<UserProfile> createState() => _profilePageState();
}

class _profilePageState extends State<UserProfile> {

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _username = 'User';
  String _description = 'Enter Description';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
       centerTitle: true,
        //Firebase Profile Edit
        title: Text("$_username's Profile",
          textAlign: TextAlign.center,
          style: TextStyle(color:Colors.white)
        ),

        backgroundColor: Colors.lightBlue,


      ),
      body: ListView(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height:10, width:40),
                Icon(Icons.person,
                    size: 100
                ),
                new Spacer(),
                GestureDetector(
                  onTap: () => _showMenu(context),
                  child: Icon(Icons.menu, color: Colors.black),
                ),


                const SizedBox(height:10, width:40),

              ]
          ),

          //User Name
          const SizedBox(height:5),
          Container(
            margin: const EdgeInsets.all(25.0),
            padding: const EdgeInsets.only(left:10.0),
            decoration: BoxDecoration(
            border: Border.all(color:Colors.lightBlue)
            ),
            child: Text(
              '$_username',
            style: TextStyle(color:Colors.black),
          ),
          ),

          //Description
          const SizedBox(height:5),
          Container(
            margin: const EdgeInsets.all(25.0),
            padding: const EdgeInsets.only(left:10.0),
            decoration: BoxDecoration(
                border: Border.all(color:Colors.lightBlue)
            ),
            child:
              Text(
                "$_description",
              style: TextStyle(color:Colors.black),

          ),
          ),


          //User Posts
          const SizedBox(height:5),
          Container(
            margin: const EdgeInsets.all(25.0),
            padding: const EdgeInsets.only(left:10.0),
            decoration: BoxDecoration(
                border: Border.all(color:Colors.lightBlue)
            ),
            child:
            Text(
              "Posts",
              style: TextStyle(color:Colors.black),
            ),
          ),

        ],
      )
    );
  }
  void _showMenu(BuildContext context) {
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
              child: Text('Save'),
              onPressed: (){
                setState(() {
                  _username = _usernameController.text;
                  _description = _descriptionController.text;
                });

                //Update in firebase
                Navigator.pop(context);
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

