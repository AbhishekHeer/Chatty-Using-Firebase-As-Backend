// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final store = FirebaseFirestore.instance;
final auth = FirebaseAuth.instance;

class MessegeController {
  // get messages

  Stream<QuerySnapshot> getMesseges(String userID, String otheruserID) {
    // get chatroom ID
    List<dynamic> ids = [userID, otheruserID];
    ids.sort();
    String chatroom = ids.join("_");

    // return messages from chatroom
    return store
        .collection('room')
        .doc(chatroom)
        .collection('data')
        .orderBy('timerStap', descending: false)
        .snapshots();
  }
}
