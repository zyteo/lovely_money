import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:lovely_money/constants.dart';
import 'package:lovely_money/screens/dashboard_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Login extends ChangeNotifier {
  String? _password;
  String? _email;

  String? get password => _password;
  String? get email => _email;

  set password(String? value) {
    _password = value;
    notifyListeners();
  }

  set email(String? value) {
    _email = value;
    notifyListeners();
  }

  // login function that takes context, email and password and connect to firebase
  Future login(context, email, password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Navigator.pushNamed(context, DashboardScreen.id);
      }).catchError((error) {
        //account for diferent error cases
        if (error.code.toString() == 'wrong-password') {
          showDialogue(context, 'Wrong Password. Please try again', 'Ok');
        } else if (error.code.toString() == 'invalid-email') {
          showDialogue(context, 'Please use a valid email ', 'OK');
        } else if (error.code.toString() == 'user-not-found') {
          showDialogue(
              context,
              'User not found. If you do not have an account, please register',
              'Please try again');
        } else if (error.code.toString() == 'too-many-requests') {
          showDialogue(
              context,
              'Sorry, there was too many requests. Please try again later.',
              'OK');
        } else {
          showDialogue(context, 'Sorry, there was an error logging in', 'OK');
        }
      });
    } catch (error) {
      print(error);
    }
  }
}
