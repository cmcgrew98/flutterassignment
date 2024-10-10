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
    return Scaffold(
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

