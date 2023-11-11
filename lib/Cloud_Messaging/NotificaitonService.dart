import 'dart:io';
import 'dart:math';

import 'package:chat_app/Pages/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class NotificationService {
  FirebaseMessaging messege = FirebaseMessaging.instance;
  FirebaseFirestore store = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  final plugin = FlutterLocalNotificationsPlugin();

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

//init local

  void intlocal(BuildContext context, RemoteMessage event) async {
    var androidinit =
        const AndroidInitializationSettings("@mipmap/ic_launcher");

    var initc = InitializationSettings(android: androidinit);
    await plugin.initialize(
      initc,
      onDidReceiveBackgroundNotificationResponse: (details) {
        handleMessege(context, event);
      },
    );
  }

  // handle messege

  void handleMessege(BuildContext context, RemoteMessage messege) async {
    if (messege.data['type'] == 'ashh') {
      Get.to(HomePage());
    }
  }

// when app is not running

  Future<void> notrun(BuildContext context) async {
    var messege = await FirebaseMessaging.instance.getInitialMessage();

    if (messege != null) {
      handleMessege(context, messege);
    }

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessege(context, event);
    });
  }

  //init

  void Firebaseinit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((event) {
      if (Platform.isAndroid) {
        intlocal(context, event);
      }
      showmessege(event);
    });
  }

// show noti

  Future<void> showmessege(RemoteMessage event) async {
//detail

    final detail = AndroidNotificationDetails(
        Random.secure().nextInt(1020).toString(), 'Chatty !!',
        importance: Importance.high,
        priority: Priority.high,
        channelDescription: 'Messgege');

    NotificationDetails newdetail = NotificationDetails(android: detail);

    Future.delayed(Duration.zero, () {
      plugin.show(1, event.notification!.title.toString(),
          event.notification!.body.toString(), newdetail);
    });
  }

// token

  Future<String?> token() async {
    String? toke = await messege.getToken();
    return toke!;
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
