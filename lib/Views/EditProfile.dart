import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  User? currentUser = FirebaseAuth.instance.currentUser;

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser!.email)
        .get();
  }

  void saveChangesAndReturn() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Row(
          children: [
            Text(
              'Edit Profile ',
              style: TextStyle(color: Colors.white),
            ),
            Icon(Icons.settings),
          ],
        ),
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getUserDetails(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.hasData) {
            final Map<String, dynamic>? user = snapshot.data?.data();

            if (user == null) {
              return const Text("No user data found");
            }

            return Column(
              children: [
                Text(user['email'] ?? 'No email available'),
                Text(user['username'] ?? 'No username available'),
                ElevatedButton(
                  onPressed: () {
                      saveChangesAndReturn();
                    },
                    child: const Text('Save changes'),
                ),
              ],
            );
          }
          else {
            return const Text("No data");
          }
        },
      ),
    );
  }
}
