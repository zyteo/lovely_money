import 'package:flutter/material.dart';
import 'package:lovely_money/constants.dart';

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
                  _email = value;
                },
              ),
            ),
            kSizedBoxSmall,
            // textform field for the password
            Padding(
              padding: kPadding,
              child: TextFormField(
                obscureText: true,
                decoration: kInputDecoration('Password'),
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
                  
                  // showDialog(
                  //   context: context,
                  //   builder: (BuildContext context) {
                  //     return AlertDialog(
                  //       title: Text('Password does not match'),
                  //       content: Text('Please try again'),
                  //       actions: <Widget>[
                  //         ElevatedButton(
                  //           child: Text('Ok'),
                  //           onPressed: () {
                  //             Navigator.pop(context);
                  //           },
                  //         ),
                  //       ],
                  //     );
                  //   },
                  // );
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
