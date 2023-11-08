import 'dart:math';

import 'package:animated_icon/animated_icon.dart';
import 'package:chat_app/Getx/SendMessege.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ChatBody extends StatefulWidget {
  String recieverid;
  ChatBody({super.key, required this.recieverid});

  @override
  State<ChatBody> createState() => _ChatBodyState();
}

final store = FirebaseFirestore.instance.collection('room');

class _ChatBodyState extends State<ChatBody> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: MessegeController().getMesseges(
          FirebaseAuth.instance.currentUser!.uid, widget.recieverid),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: AnimateIcon(
              key: UniqueKey(),
              onTap: () {},
              iconType: IconType.continueAnimation,
              color: Color.fromRGBO(
                  Random.secure().nextInt(255),
                  Random.secure().nextInt(255),
                  Random.secure().nextInt(255),
                  1),
              animateIcon: AnimateIcons.chatMessage,
            ),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (BuildContext context, int index) {
              Alignment align = FirebaseAuth.instance.currentUser!.uid !=
                      snapshot.data?.docs[index]['ReceiverID']
                  ? Alignment.bottomRight
                  : Alignment.bottomLeft;

              var deco = FirebaseAuth.instance.currentUser!.uid ==
                      snapshot.data?.docs[index]['ReceiverID']
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(Get.width * .02),
                      color: Colors.blueAccent)
                  : BoxDecoration(
                      borderRadius: BorderRadius.circular(Get.width * .02),
                      color: Colors.grey);

              return SafeArea(
                child: Align(
                  alignment: align,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: Get.width * .02),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        vertical: Get.height * .004,
                        horizontal: Get.width * .02,
                      ),
                      width: Get.width * .4,
                      height: Get.height * .05,
                      decoration: deco,
                      child: Center(
                          child: Text(snapshot.data?.docs[index]['Messege'])),
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
