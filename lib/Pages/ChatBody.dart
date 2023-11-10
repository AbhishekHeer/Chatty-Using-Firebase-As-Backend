import 'dart:math';

import 'package:animated_icon/animated_icon.dart';
import 'package:chat_app/Getx/SendMessege.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ChatBody extends StatefulWidget {
  String recieverid;
  String image;
  ChatBody({super.key, required this.recieverid, required this.image});

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

              var photo = FirebaseAuth.instance.currentUser!.uid !=
                      snapshot.data?.docs[index]['ReceiverID']
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(FirebaseAuth
                          .instance.currentUser!.photoURL
                          .toString()),
                    )
                  : CircleAvatar(
                      radius: Get.height * .02,
                      backgroundImage: NetworkImage(widget.image),
                    );

              var deco = FirebaseAuth.instance.currentUser!.uid ==
                      snapshot.data?.docs[index]['ReceiverID']
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(Get.width / 2),
                      color: const Color.fromARGB(255, 115, 149, 209))
                  : BoxDecoration(
                      borderRadius: BorderRadius.circular(Get.width / 2),
                      color: Colors.grey);

              return Align(
                alignment: align,
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(top: Get.width * .004),
                    child: IntrinsicWidth(
                        child: FirebaseAuth.instance.currentUser!.uid !=
                                snapshot.data?.docs[index]['ReceiverID']
                            ? Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: Get.height * .002,
                                        horizontal: Get.width * .005),
                                    height: Get.height * .06,
                                    decoration: deco,
                                    child: SizedBox(
                                      height: double.infinity,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Get.width * .04),
                                        child: Center(
                                          child: Text(
                                            snapshot.data?.docs[index]
                                                ['Messege'],
                                            softWrap: true,
                                            style: GoogleFonts.niramit(
                                                fontSize: Get.width * .04),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width * .01,
                                  ),
                                  photo,
                                  SizedBox(
                                    width: Get.width * .03,
                                  )
                                ],
                              )
                            : Row(
                                children: [
                                  SizedBox(
                                    width: Get.width * .03,
                                  ),
                                  photo,
                                  SizedBox(
                                    width: Get.width * .01,
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: Get.height * .002,
                                        horizontal: Get.width * .005),
                                    height: Get.height * .06,
                                    decoration: deco,
                                    child: SizedBox(
                                      height: double.infinity,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Get.width * .04),
                                        child: Center(
                                          child: Text(
                                            snapshot.data?.docs[index]
                                                ['Messege'],
                                            softWrap: true,
                                            style: GoogleFonts.niramit(
                                                fontSize: Get.width * .04),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
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
