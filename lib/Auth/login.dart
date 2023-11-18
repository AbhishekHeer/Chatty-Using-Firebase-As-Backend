import 'package:chat_app/Auth/authmethod.dart';
import 'package:chat_app/Getx/password.dart';
import 'package:chat_app/Messege/Buttom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _email = TextEditingController();
  final _password = TextEditingController();
  final auth = FirebaseAuth.instance;

  PasswordController show = Get.put(PasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: Get.height * .1,
            ),
            SafeArea(
              child: SizedBox(
                height: Get.height * .07,
                child: Center(
                  child: Text(
                    'Login',
                    style: GoogleFonts.niconne(fontSize: Get.width * 0.07),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: Get.height * .01,
                horizontal: Get.width * .05,
              ),
              child: TextField(
                controller: _email,
                decoration: InputDecoration(
                    hintText: 'Email',
                    label: const Text('Enter Email'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Get.width * .04))),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: Get.height * .02,
                horizontal: Get.width * .05,
              ),
              child: TextField(
                  obscureText: true,
                  controller: _password,
                  decoration: InputDecoration(
                      suffix: const Icon(CupertinoIcons.bolt_horizontal),
                      hintText: 'Password',
                      label: const Text('Enter Password'),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(Get.width * .04)))),
            ),

            //name
            SizedBox(
              height: Get.height * .06,
            ),
            Boouttom.buttom('Login', () {
              try {
                method()
                    .signInWithEmailandPassword(_email.text, _password.text)
                    .then((value) {
                  navigator!.pushReplacementNamed('/home');
                });
              } on FirebaseAuthException {
                Get.snackbar(
                    'Error', 'Email Is Already Used By Another Account');
              } catch (e) {
                Get.snackbar('Error', e.toString());
              }
            }),
            SizedBox(
              height: Get.height * .15,
            ),
            IconButton(
              onPressed: () {
                method().signInWithGoogle(context).then((value) async {
                  navigator!.pushReplacementNamed('/home');
                });
              },
              icon: const Icon(FontAwesomeIcons.google),
            ),
            SizedBox(
              height: Get.height * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Dont Have An Account'),
                TextButton(
                  onPressed: () {
                    Get.toNamed('signup');
                  },
                  child: const Text(
                    "Sign-Up",
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
