import 'package:chat_app/Auth/authmethod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class byeScreen extends StatefulWidget {
  const byeScreen({super.key});

  @override
  State<byeScreen> createState() => _byeScreenState();
}

class _byeScreenState extends State<byeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            method().delete(context);
          },
          child: const Text(
            'Delete My Account',
          ),
        ),
      ),
    );
  }
}
