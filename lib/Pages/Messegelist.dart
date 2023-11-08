import 'package:chat_app/Getx/SendMessege.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Widget buildmessegeitem(DocumentSnapshot document) {
  Map<String, dynamic> data = document.data() as Map<String, dynamic>;
  final alignn = (data['SenderID'] == FirebaseAuth.instance.currentUser!.uid)
      ? Alignment.centerRight
      : Alignment.centerLeft;

  return Container(
    alignment: alignn,
    child: Column(
      children: [
        Text(data['SenderEmail']),
        Text(data['messege']),
      ],
    ),
  );
}

Widget buildmessegelist(String receiverid) {
  return StreamBuilder(
    stream: MessegeController()
        .getMesseges(receiverid, FirebaseAuth.instance.currentUser!.uid),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        // Cast the list of dynamic objects to a list of widgets
        List<Widget> widgets = snapshot.data!.docs
            .where((document) => document['SenderID'] == receiverid)
            .map((document) => buildmessegeitem(document))
            .toList();

        return ListView(
          children: widgets,
        );
      }
    },
  );
}
