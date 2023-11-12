import 'package:chat_app/Cloud_Messaging/NotificaitonService.dart';
import 'package:chat_app/Getx/chatroom.dart';
import 'package:chat_app/Pages/ChatBody.dart';
import 'package:chat_app/post/postmessege.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatPage extends StatefulWidget {
  final String RecieverID;
  final String name;
  final String photo;
  final String receiverDeviceToken;

  const ChatPage(
      {super.key,
      required this.RecieverID,
      required this.name,
      required this.photo,
      required this.receiverDeviceToken});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

final _mesege = TextEditingController();
final auth = FirebaseAuth.instance;
final store = FirebaseFirestore.instance.collection('room');

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 190, 188, 188),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.blueAccent,
              backgroundImage: NetworkImage(widget.photo),
            ),
            SizedBox(
              width: Get.width * .02,
            ),
            Text(widget.name)
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              showAdaptiveDialog(
                  context: context,
                  builder: ((context) {
                    return AlertDialog.adaptive(
                      title: const Text('Opps !!'),
                      content:
                          const Text('This Will Come in Future Stay With Us'),
                      actions: [
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Text Button",
                          ),
                        ),
                      ],
                    );
                  }));
            },
            icon: const Icon(CupertinoIcons.doc_on_clipboard),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: Get.height * .08),
        child: ChatBody(recieverid: widget.RecieverID, image: widget.photo),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * .04),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _mesege,
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: 'Messege'),
              ),
            ),
            IconButton(
              onPressed: () async {
                if (_mesege.text.isNotEmpty) {
                  sendMessege(widget.RecieverID, _mesege.text,
                      widget.receiverDeviceToken);
                  _mesege.clear();

                  NotificationService().token().then((value) {
                    sendNotificaiton(
                        FirebaseAuth.instance.currentUser!.displayName
                            .toString(),
                        _mesege.text.toString(),
                        widget.receiverDeviceToken);
                  });
                } else {
                  Get.snackbar('Empty', 'Please Enter Messege');
                }
              },
              icon: const Icon(
                Icons.send,
                color: Colors.blueAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
