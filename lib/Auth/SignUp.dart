import 'dart:io';

import 'package:chat_app/Auth/authmethod.dart';
import 'package:chat_app/Messege/Buttom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

final _email = TextEditingController();
final _password = TextEditingController();
final _name = TextEditingController();

class _SignupState extends State<Signup> {
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
                    'Sign Up',
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
                keyboardType: TextInputType.emailAddress,
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
                  keyboardType: TextInputType.multiline,
                  controller: _password,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      label: const Text('Enter Password'),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(Get.width * .04)))),
            ),
            SizedBox(
              height: Get.height * .06,
            ),
            Boouttom.buttom('Sign-Up', () {
              Get.bottomSheet(BottomSheet(
                  onClosing: () {},
                  builder: ((context) {
                    return SingleChildScrollView(
                      child: SizedBox(
                        height: Get.height * .6,
                        child: Column(
                          children: [
                            SizedBox(
                              height: Get.height * .03,
                            ),
                            Text(
                              'Welcome To Chattty ',
                              style: GoogleFonts.hindMadurai(),
                            ),

                            SizedBox(
                              height: Get.height * .04,
                            ),
                            Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Get.width * .04),
                                child: SearchBar(
                                  controller: _name,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Get.height * .04,
                            ),

                            //image

                            CircleAvatar(
                              radius: Get.width * .2,
                              child: InkWell(
                                onTap: () {
                                  getFile();
                                },
                                child: ClipOval(
                                  child: imagee?.absolute == null
                                      ? const Icon(CupertinoIcons.add)
                                      : Image(
                                          image: FileImage(imagee!.absolute),
                                        ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Get.height * .03,
                            ),
                            Boouttom.buttom('Enter Chattt y', () async {
                              if (imagee!.path.isEmpty ||
                                  _email.text.isEmpty ||
                                  _name.text.isEmpty ||
                                  _password.text.isEmpty) {
                                Get.snackbar('opps !!', "SomeThing Is Missing");
                              } else if (_password.text.length < 6) {
                                Get.snackbar('Password',
                                    'Password Must Be AtLeast 6 Digit');
                              } else {
                                try {
                                  final url = await uploadImage(imagee);

                                  await method()
                                      .createUserWithEmailAndPassword(
                                          _email.text,
                                          _password.text,
                                          _name.text,
                                          url)
                                      .then((value) {
                                    Get.toNamed('/home');
                                    Get.snackbar('Done', 'Login Successfully');
                                    _email.clear();
                                    _name.clear();
                                    _password.clear();
                                    imagee!.delete();
                                  });
                                } on FirebaseAuthException {
                                  Get.snackbar('Error',
                                      'Email Is Already Used By Another Account');
                                } catch (e) {}
                              }
                            }),
                          ],
                        ),
                      ),
                    );
                  })));
            }),
            SizedBox(
              height: Get.height * .2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Have An Account'),
                TextButton(
                  onPressed: () {
                    Get.offAndToNamed('LoginScreen');
                  },
                  child: Text(
                    "Login",
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  File? imagee;

  Future<void> getFile() async {
    final choose = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (choose != null) {
        imagee = File(choose.path);

        // print(imagee);
      } else {
        Get.snackbar('error', 'No Pic Slected !!');
      }
    });
  }

  Future<String> uploadImage(var imageFile) async {
    String id = DateTime.now().microsecondsSinceEpoch.toString();
    final ref = FirebaseStorage.instance.ref().child("/photo/$id.jpg");
    final uploadTask = await ref.putFile(imageFile);

    var dowurl = await (uploadTask).ref.getDownloadURL();
    final url = dowurl.toString();

    return url;
  }
}
