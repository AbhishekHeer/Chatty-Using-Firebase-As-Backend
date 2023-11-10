import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  FirebaseMessaging messege = FirebaseMessaging.instance;
  FirebaseFirestore store = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

// reqpermission

  void reqPermisson() async {
    NotificationSettings setting = await messege.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (setting.authorizationStatus == AuthorizationStatus.authorized) {
      print('aage jaoo');
    } else {
      print('denied');
    }
  }

// token

  Future<void> token() async {
    String? toke = await messege.getToken();
    if (toke!.isNotEmpty) {
      final storedata = await store
          .collection('usertoken')
          .doc('token')
          .collection(auth.currentUser!.uid)
          .doc('_')
          .set({'token': toke});
      return storedata;
    } else {
      return;
    }
  }

  void refresh() async {
    messege.onTokenRefresh.listen((event) {
      store
          .collection('usertoken')
          .doc('token')
          .collection(auth.currentUser!.uid)
          .doc('_')
          .update({'token': event});
    });
  }
}
