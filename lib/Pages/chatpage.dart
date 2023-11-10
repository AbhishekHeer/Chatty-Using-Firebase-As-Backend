import 'package:chat_app/Cloud_Messaging/NotificaitonService.dart';
import 'package:chat_app/Getx/chatroom.dart';
import 'package:chat_app/Pages/ChatBody.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class ChatPage extends StatefulWidget {
  final String RecieverID;
  final String name;
  final String photo;

  const ChatPage({
    super.key,
    required this.RecieverID,
    required this.name,
    required this.photo,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

final Noti = NotificationService();

@override
void initState() {}

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
              var status = await Permission.photos.request();
              if (status.isGranted) {
                print('odpow');
              } else if (status.isPermanentlyDenied) {
                openAppSettings();
              }
            },
            icon: const Icon(CupertinoIcons.doc_on_clipboard),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: Get.height * .05),
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
              onPressed: () {
                if (_mesege.text.isNotEmpty) {
                  sendMessege(widget.RecieverID, _mesege.text);
                  _mesege.clear();
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
