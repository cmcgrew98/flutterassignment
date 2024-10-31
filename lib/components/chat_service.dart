import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'message.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  User? currentUser = FirebaseAuth.instance.currentUser;
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  //Sending a message
  Future<void> sendMessage(String receiverID, text) async {
    final String currentUserID = currentUser!.uid;
    final String currentUserEmail = currentUser!.email!;
    final Timestamp date = Timestamp.now();

    //create new message
    Message newMessage = Message(
      text: text,
      sent_by: currentUserID,
      user1_id: currentUserID,
      user2_id: receiverID,
      date: date,
      read: false,
    );

    List<String> ids = [currentUserID, receiverID];
    ids.sort();
    String thread = ids.join('_');
    await _firestore
      .collection("threads")
      .doc(thread)
      .collection("messages")
      .add(newMessage.toMap());


  }

  //Msg get
  Stream<QuerySnapshot> getMessages(String user1ID, user2ID) {
    List<String> ids = [user1ID, user2ID];
    ids.sort();
    String thread = ids.join('_');
    return _firestore
        .collection("threads")
        .doc(thread)
        .collection("messages")
        .orderBy("date", descending: false)
        .snapshots();
  }

}