import 'dart:async';
import 'package:chat_app/Routes/approutes.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
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
      themeMode: ThemeMode.light,
      getPages: appRoutes(),
      initialRoute: '/',
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
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      if (auth.currentUser != null) {
        navigator!.pushReplacementNamed('/home');
      } else {
        navigator!.pushReplacementNamed('/LoginScreen');
      }
    });
  }

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
          )
        ],
      ),
    );
  }
}
