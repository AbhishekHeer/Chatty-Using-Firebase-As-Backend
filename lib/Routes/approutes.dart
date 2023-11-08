import 'package:chat_app/Auth/SignUp.dart';
import 'package:chat_app/Auth/login.dart';
import 'package:chat_app/Pages/homepage.dart';
import 'package:chat_app/main.dart';
import 'package:get/get.dart';

appRoutes() => [
      GetPage(
        name: '/home',
        page: () => HomePage(),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/',
        page: () => const SplashScreen(),
        transition: Transition.circularReveal,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/LoginScreen',
        page: () => LoginPage(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/signup',
        page: () => const Signup(),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/splash',
        page: () => const SplashScreen(),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
    ];
