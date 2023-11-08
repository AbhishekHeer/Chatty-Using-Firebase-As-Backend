import 'package:chat_app/Auth/authmethod.dart';
import 'package:chat_app/Pages/Homebody.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final image = FirebaseAuth.instance.currentUser!.photoURL.toString();

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
                            child: Image.network(image),
                          ),
                        );
                      }));
                }
              },
              child: CircleAvatar(
                backgroundImage: NetworkImage(image.isNotEmpty
                    ? 'https://drive.google.com/file/d/14Vtav-RmLHiwQbc1HXXJSDwelUEjcqB7/view?usp=drive_link'
                        .toString()
                    : image),
              ),
            ),
          ),
          title: Padding(
            padding: EdgeInsets.only(left: Get.width * .0001),
            child: const Text('Chats'),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: Get.width * .02),
              child: IconButton(
                onPressed: () {
                  method().signout();
                },
                icon: Icon(
                  FontAwesomeIcons.signOut,
                  size: Get.width * .048,
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(child: HomeBody()),
          ],
        ));
  }
}
