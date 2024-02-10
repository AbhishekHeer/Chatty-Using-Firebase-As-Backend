import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingHead extends StatefulWidget {
  const SettingHead({super.key});

  @override
  State<SettingHead> createState() => _SettingHeadState();
}

final stream = FirebaseFirestore.instance.collection('users');

class _SettingHeadState extends State<SettingHead> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: stream.doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return BigUserCard(
              backgroundColor: Colors.transparent,
              userName: snapshot.data?['name'],
              userProfilePic: NetworkImage(snapshot.data?['image']),
            );
          }
        });
  }
}
