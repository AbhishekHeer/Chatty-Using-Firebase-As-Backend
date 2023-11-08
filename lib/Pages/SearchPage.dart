import 'dart:math';

import 'package:animated_icon/animated_icon.dart';
import 'package:chat_app/Pages/chatpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearcchUser extends StatefulWidget {
  const SearcchUser({super.key});

  @override
  State<SearcchUser> createState() => _SearcchUserState();
}

final search = TextEditingController();
final store = FirebaseFirestore.instance.collection('users');

class _SearcchUserState extends State<SearcchUser> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: Get.height * .04,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * .05),
            child: SearchBar(
              controller: search,
              hintText: 'Search User',
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          SizedBox(
            height: Get.height * .04,
          ),
          SizedBox(
            width: Get.width,
            height: Get.height,
            child: StreamBuilder(
                stream: store.snapshots(),
                builder: ((context, snapshot) {
                  return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (BuildContext context, int index) {
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
                        ));
                      } else {
                        if (snapshot.data?.docs[index]['name']
                            .toLowerCase()
                            .contains(search.text.toLowerCase())) {
                          return ListTile(
                            onTap: () async {
                              await Get.to(
                                ChatPage(
                                  RecieverID: snapshot.data?.docs[index]['id'],
                                  name: snapshot.data?.docs[index]['name'],
                                  photo: snapshot.data?.docs[index]['image'],
                                ),
                              );
                            },
                            leading: CircleAvatar(
                              radius: Get.width * .04,
                              backgroundColor: Colors.amberAccent,
                              backgroundImage: NetworkImage(
                                  snapshot.data?.docs[index]['image']),
                            ),
                            title: Center(
                              child: Text(
                                snapshot.data?.docs[index]['name'],
                              ),
                            ),
                            trailing: const Icon(
                                CupertinoIcons.chat_bubble_text_fill),
                          );
                        } else {
                          return null;
                        }
                      }
                    },
                  );
                })),
          )
        ],
      ),
    );
  }
}
