import 'dart:async';

import 'package:chat_app/Cloud_Messaging/NotificaitonService.dart';
import 'package:chat_app/Routes/approutes.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(backgroundmessege);
  runApp(const MyApp());
}

@pragma('vm:entry-point')
Future<void> backgroundmessege(RemoteMessage messege) async {
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white70,
        useMaterial3: true,
        primarySwatch: Colors.red,
      ),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.system,
      getPages: appRoutes(),
      initialRoute: '/LoginScreen',
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final auth = FirebaseAuth.instance;

  NotificationService noti = NotificationService();

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      if (auth.currentUser != null) {
        navigator?.pushReplacementNamed('/home');
      } else {
        navigator?.pushReplacementNamed('/LoginScreen');
      }
    });
    noti.reqPermisson();
    noti.token().then((value) {}).onError((error, stackTrace) {});
    noti.Firebaseinit(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Icon(
              CupertinoIcons.chat_bubble,
              size: Get.width * .4,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              'chatty',
              style: GoogleFonts.fahkwang(
                  fontSize: Get.width * .04, fontWeight: FontWeight.w300),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: Get.height * .04),
            child: const Align(
              alignment: Alignment.bottomCenter,
              child: Text('Version 1.2.0'),
            ),
          )
        ],
      ),
    );
  }
}
