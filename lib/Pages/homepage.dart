import 'package:chat_app/Pages/Homebody.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final image = FirebaseAuth.instance.currentUser?.photoURL.toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          // leadingWidth: Get.width * .11,
          leading: Padding(
            padding: EdgeInsets.only(left: Get.width * .04),
            child: InkWell(
              onTap: () {
                if (FirebaseAuth.instance.currentUser?.photoURL == null) {
                  return;
                } else {
                  showAdaptiveDialog(
                      context: context,
                      builder: ((context) {
                        return AlertDialog(
                          backgroundColor: Colors.transparent,
                          title: PinchZoom(
                            maxScale: 2.5,
                            child: Image.network(image.toString()),
                          ),
                        );
                      }));
                }
              },
              child: CircleAvatar(
                backgroundImage: NetworkImage(image!.isNotEmpty
                    ? 'Assets/images/logo.jpg'
                    : image.toString()),
              ),
            ),
          ),
          title: Padding(
            padding: EdgeInsets.only(left: Get.width * .0001),
            child: const Text('Chats'),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: Get.width * .04),
              child: IconButton(
                onPressed: () {
                  Get.toNamed('/setting');
                },
                icon: Icon(
                  CupertinoIcons.settings_solid,
                  size: Get.width * .06,
                ),
              ),
            )
          ],
        ),
        body: const Column(
          children: [
            Expanded(child: HomeBody()),
          ],
        ));
  }
}
