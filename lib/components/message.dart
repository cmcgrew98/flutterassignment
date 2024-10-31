import 'package:cloud_firestore/cloud_firestore.dart';

class Message{
  final String text;
  final String sent_by;
  final String user1_id;
  final String user2_id;
  final Timestamp date;
  final bool read;

  Message({
    required this.text,
    required this.sent_by,
    required this.user1_id,
    required this.user2_id,
    required this.date,
    required this.read,
  });

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'sent_by': sent_by,
      'user1_id': user1_id,
      'user2_id': user2_id,
      'date': date,
      'read': read,
    };
  }
}