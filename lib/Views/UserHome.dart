import 'package:flutter/material.dart';
import '../components/posts.dart';
import '../components/stories.dart';

class UserHome extends StatelessWidget {
  UserHome({Key? key}) : super(key: key);

  final List people = ['John', 'Jane', 'Jack', 'Jill', 'James', 'Jenny', 'Jasper', 'Jade', 'Jared', 'Jocelyn'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 100,
            child: ListView.builder(
              itemCount: people.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Stories(user: people[index]);
              },
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: people.length,
              itemBuilder: (context, index) {
                return Posts(user: people[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}