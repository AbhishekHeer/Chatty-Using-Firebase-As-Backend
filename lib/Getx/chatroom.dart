import 'package:chat_app/Model/messegemodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<Object?> sendMessege(String id, text, receiverDeviceToken) async {
  QuerySnapshot snap = await FirebaseFirestore.instance
      .collection('room')
      .where('participants.${FirebaseAuth.instance.currentUser!.uid}',
          isEqualTo: true)
      .where('participants.$id')
      .get();

  if (snap.docs.isNotEmpty) {
    List<dynamic> roomid = [FirebaseAuth.instance.currentUser!.uid, id];
    roomid.sort();
    String room = roomid.join('_');
    return FirebaseFirestore.instance.collection('room').doc(room).get();
  } else {
    final currentid = FirebaseAuth.instance.currentUser!.uid;
    final Auth = FirebaseAuth.instance;
    final String currentID = Auth.currentUser!.uid;
    // ignore: non_constant_identifier_names
    final String currentEmail = Auth.currentUser!.email.toString();
    final time = Timestamp.now().toString();
    final token = await FirebaseMessaging.instance.getToken();

    messege newMessege = messege(currentID, currentEmail, id, text, time,
        token.toString(), receiverDeviceToken);

    List<dynamic> roomid = [currentid, id];
    roomid.sort();
    String room = roomid.join('_');

    return await FirebaseFirestore.instance
        .collection('room')
        .doc(room)
        .collection('data')
        .add(newMessege.toMap());
  }
}
