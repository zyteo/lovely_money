import 'package:flutter/material.dart';
import 'package:lovely_money/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = 'register_screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? _username;
  String? _password;
  String? _email;
  String? _confirmPassword;

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    //return scaffold with a text of "register" and 4 textform fields, with text buttons of register and back
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Register', style: kTitleStyle),
            kSizedBoxLarge,
            // textform field for the username
            Padding(
              padding: kPadding,
              child: TextFormField(
                decoration: kInputDecoration('Username'),
                onChanged: (value) {
                  _username = value;
                },
              ),
            ),
            kSizedBoxSmall,
            // textform field for the email
            Padding(
              padding: kPadding,
              child: TextFormField(
                decoration: kInputDecoration('Email'),
                onChanged: (value) {
                  _email = value.toLowerCase();
                },
              ),
            ),
            kSizedBoxSmall,
            // textform field for the password
            Padding(
              padding: kPadding,
              child: TextFormField(
                obscureText: true,
                decoration: kInputDecoration('Password (min 6 characters)'),
                onChanged: (value) {
                  _password = value;
                },
              ),
            ),
            kSizedBoxSmall,
            // textform field for the confirm password
            Padding(
              padding: kPadding,
              child: TextFormField(
                obscureText: true,
                decoration: kInputDecoration('Confirm Password'),
                onChanged: (value) {
                  _confirmPassword = value;
                },
              ),
            ),
            kSizedBoxMedium,
            ElevatedButton(
                onPressed: () {
                  //check if any of the 4 variables is null
                  if (_username == null ||
                      _email == null ||
                      _password == null ||
                      _confirmPassword == null) {
                    //if so, show a dialogue box with a message of "please fill in all fields"
                    showDialogue(context, 'Please fill in all fields', 'OK');
                  } else {
                    //if not, check if the password and confirm password are the same
                    if (_confirmPassword == _password) {
                      //if so, create a new user with the email and password
                      _auth
                          .createUserWithEmailAndPassword(
                              email: _email.toString(),
                              password: _password.toString())
                          .then((value) {
                        //connect to firebase data and add a new collection, with the email as the key and the username as the value
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(_email.toString())
                            .set({
                          'username': _username.toString(),
                          'email': _email.toString(),
                          'items': [
                            'FOOD',
                            'TRAVEL',
                            'GROCERIES',
                            'HEALTH',
                            'GIFT',
                            'TAXI',
                            'TRANSPORT',
                            'SALARY',
                            'INTEREST'
                          ],
                          'default': {
                            'item': 'FOOD',
                            'currency': 'SGD',
                          },
                        });
                        //if successful, show a dialogue box with a message of "user created"
                        showDialogue(
                            context, 'User created successfully', 'OK');
                      }).catchError((error) {
                        //account for diferent error cases
                        if (error.code.toString() == 'invalid-email') {
                          showDialogue(
                              context, 'Please use a valid email', 'OK');
                        } else if (error.code.toString() ==
                            'email-already-in-use') {
                          showDialogue(context, 'Email already in use', 'OK');
                        } else if (error.code.toString() == 'weak-password') {
                          showDialogue(
                              context,
                              'Password is too weak. Minimum of 6 characters.',
                              'OK');
                        } else {
                          showDialogue(context,
                              'Sorry, there was an error creating user', 'OK');
                        }
                      });
                    } else {
                      showDialogue(context, 'Passwords does not match', 'OK');
                    }
                  }
                },
                child: Text('Register')),
            kSizedBoxSmall,
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Back')),
          ],
        ),
      ),
    );
  }
}
