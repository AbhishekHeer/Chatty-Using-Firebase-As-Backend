import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

// ignore: camel_case_types
class method {
  final auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool isLoading = false;

//circuler indicator

  //new user
  Future<UserCredential> signInWithEmailandPassword(
      String email, passsword) async {
    try {
      UserCredential user = await auth.signInWithEmailAndPassword(
          email: email, password: passsword);

      if (auth.currentUser?.email == email) {
        firestore.collection('users').doc(user.user!.uid).get();
      }

      return user;
    } on FirebaseAuthException catch (e) {
      return throw Exception(e);
    }
  }

  //new user
  Future<UserCredential> createUserWithEmailAndPassword(String email, passsword,
      name, String imageURL, BuildContext context) async {
    try {
      UserCredential user = await auth.createUserWithEmailAndPassword(
          email: email, password: passsword);

      final token = await FirebaseMessaging.instance.getToken();

      showAdaptiveDialog(
          context: context,
          builder: ((context) {
            return AlertDialog.adaptive(
              backgroundColor: Colors.transparent,
              content: SizedBox(
                width: Get.width * .2,
                height: Get.height * .1,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }));

      firestore.collection('users').doc(user.user!.uid).set({
        'id': user.user?.uid,
        'image': imageURL,
        'email': email,
        "name": name,
        'token': token
      }).then((value) {
        const AlertDialog.adaptive(
          backgroundColor: Colors.transparent,
          title: Center(
            child: CircularProgressIndicator(),
          ),
        );
        navigator?.pushReplacementNamed('/home');
      }).whenComplete(() {
        Get.snackbar('Done', 'Welcome To Chat World');
      });
      return user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

//google sign in

  Future<UserCredential> signInWithGoogle(BuildContext context) async {
    // Trigger the authentication flow
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final image = FirebaseAuth.instance.currentUser?.photoURL;
      final nme = FirebaseAuth.instance.currentUser?.displayName;
      final email = FirebaseAuth.instance.currentUser?.email;
      final id = FirebaseAuth.instance.currentUser?.uid;
      final token = await FirebaseMessaging.instance.getToken();

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      FirebaseAuth.instance.signInWithCredential(credential);

      if (auth.currentUser!.uid == email) {
        firestore.collection('users').doc(auth.currentUser?.uid).get();
      }
      showAdaptiveDialog(
          context: context,
          builder: ((context) {
            return AlertDialog.adaptive(
              backgroundColor: Colors.transparent,
              content: SizedBox(
                width: Get.width * .2,
                height: Get.height * .1,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }));
      var re = await firestore
          .collection('users')
          .doc(id)
          .set({
            'id': id,
            'image': image,
            'email': email,
            "name": nme,
            'token': token
          })
          .then((value) {})
          .whenComplete(() {
            navigator?.pushReplacementNamed('/home');
            Get.snackbar('Welcome', 'Welcome To Chatty');
          });
      return re;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

//sign out
  signout() {
    final user = auth.signOut().then((value) {
      navigator?.pushReplacementNamed('/LoginScreen');
    });
    return user;
  }

  // delete account

  delete(BuildContext context) async {
    showAdaptiveDialog(
        context: context,
        builder: ((context) {
          return AlertDialog.adaptive(
            backgroundColor: Colors.transparent,
            content: SizedBox(
              width: Get.width * .2,
              height: Get.height * .1,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }));
    final id = FirebaseAuth.instance.currentUser?.uid;
    final store = await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .delete()
        .then((value) {
      Get.toNamed('/LoginScreen');
      FirebaseAuth.instance.currentUser?.delete();
    }).whenComplete(() {
      Get.snackbar('Done', 'Your Account Have Been Deleted');
    });
    return store;
  }
}
