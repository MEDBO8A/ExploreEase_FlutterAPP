// ignore_for_file: deprecated_member_use, avoid_web_libraries_in_flutter, await_only_futures, use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project/screens/email_verification_screen.dart';

import '../model/user.dart';
import '../screens/home_screen.dart';
import 'alert_dialog.dart';
import 'dataBaseServices.dart';

class AuthServices {
  FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? getUser() {
    return FirebaseAuth.instance.currentUser;
  }

  Future signOut() async {
    await auth.signOut();
    await _googleSignIn.signOut();
    return;
  }

  Future<bool> logInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      if (gUser == null) {
        return false;
      }

      final GoogleSignInAuthentication gAuth = await gUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      final UserCredential authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final User? user = authResult.user;

      if (user != null) {
        UserModel userr = UserModel(
          id: user.uid,
          username: user.displayName ?? "",
          mail: user.email ?? "",
          password: user.displayName ?? "",
          profPic: user.photoURL ?? "",
          bio: "bio...",
          favorite: [""],
          booked: [""],
        );

        await DBServices().saveUser(userr);

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MyHomeScreen(),
          ),
        );
      }

      return user != null;
    } on PlatformException catch (e) {
      if (e.code.contains("network_error")) {
        showErrorAlert(context, "Check your Network Connection");
      } else {
        showErrorAlert(context, "An error occurred: ${e.message}");
      }
      return false;
    }
  }

  Future signIn(BuildContext context, String mail, String pass) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: mail,
        password: pass,
      );
      if (credential.user!.emailVerified) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MyHomeScreen(),
          ),
        );
      } else {
        showErrorAlert(context,
            "Please check your mail inbox and verify your Email address");
      }
    } on FirebaseAuthException catch (e) {
      if (e.message ==
          "The supplied auth credential is incorrect, malformed or has expired.") {
        showErrorAlert(
            context, "Invalid Email or password / Not Registered! Try again");
      } else {
        showErrorAlert(context, e.message);
      }
    }
  }

  Future signUp(
      BuildContext context, String name, String mail, String pass) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: mail,
        password: pass,
      );

      if (userCredential.user != null) {
        try {
          await userCredential.user?.updateDisplayName(name);
          await userCredential.user?.sendEmailVerification();

          UserModel user = UserModel(
            id: userCredential.user!.uid,
            username: name,
            mail: mail,
            password: pass,
            profPic: "https://shorturl.at/bdNO2",
            bio: "bio...",
            favorite: [""],
            booked: [""],
          );

          await DBServices().saveUser(user);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EmailVerificationScreen(),
            ),
          );
        } catch (e) {
          print("rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr $e");
        }

        return true;
      }
    } on FirebaseAuthException catch (e) {
      showErrorAlert(context, e.message);
      return false;
    }
  }
}
