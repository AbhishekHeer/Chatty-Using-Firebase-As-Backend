import 'dart:math';

import 'package:animated_icon/animated_icon.dart';
import 'package:chat_app/Pages/SearchPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

final Auth = FirebaseAuth.instance;
final _dbstore = FirebaseFirestore.instance;

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _dbstore.collection('users').snapshots(),
        builder: ((context, snapshot) {
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
            return const SearcchUser();
          }
        }));
  }
}
