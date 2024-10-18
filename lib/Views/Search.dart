import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  Search({super.key});

  User? currentUser = FirebaseAuth.instance.currentUser;

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser!.email)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
