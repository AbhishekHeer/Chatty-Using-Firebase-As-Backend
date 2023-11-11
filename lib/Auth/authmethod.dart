import 'package:chat_app/Pages/chatpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class method {
  final Auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool isLoading = false;

  //new user
  Future<UserCredential> signInWithEmailandPassword(
      String email, passsword) async {
    try {
      UserCredential user = await Auth.signInWithEmailAndPassword(
          email: email, password: passsword);

      if (auth.currentUser!.uid == email) {
        firestore.collection('users').doc(user.user!.uid).get();
      }

      return user;
    } on FirebaseAuthException catch (e) {
      return throw Exception(e);
    }
  }

  //new user
  Future<UserCredential> createUserWithEmailAndPassword(
      String email, passsword, name, String imageURL) async {
    try {
      UserCredential user = await Auth.createUserWithEmailAndPassword(
          email: email, password: passsword);

      final token = FirebaseMessaging.instance.getToken();

      firestore.collection('users').doc(user.user!.uid).set({
        'id': user.user?.uid,
        'image': imageURL,
        'email': email,
        "name": name,
        'token': token
      }).then((value) {
        // final detail = FirebaseAuth.instance.currentUser!.providerData;
        navigator!.pushReplacementNamed('/home');
      }).whenComplete(() {
        Get.snackbar('Done', 'Welcome To Chat World');
      });
      return user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

//google sign in

  Future<UserCredential> signInWithGoogle() async {
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
      FirebaseAuth.instance.signInWithCredential(credential).printInfo();

      if (auth.currentUser!.uid == email) {
        firestore.collection('users').doc(Auth.currentUser!.uid).get();
      }

      var re = await firestore.collection('users').doc(id).set({
        'id': id,
        'image': image,
        'email': email,
        "name": nme,
        'token': token
      }).then((value) {
        navigator!.pushReplacementNamed('/home');
      });
      return re;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

//sign out
  signout() {
    final user = Auth.signOut().then((value) {
      navigator!.pushReplacementNamed('/LoginScreen');
    });
    return user;
  }
}
