import 'package:flutter/material.dart';
import 'package:lovely_money/models/login.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return //scaffold with a text of "login" and 2 textform fields, with 2 text buttons of login and register
        Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Login'),
            // textform field for the email
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email',
              ),
              onChanged: (value) {
                // do something with the email
                // use provider to update the email
              },
            ),

            TextFormField(),
            TextButton(
                onPressed: () {
                  print('object');
                },
                child: Text('Login')),
            //text button of register with decoration
            TextButton(
                onPressed: () {
                  print('object2');
                },
                child: Text('Register')),
          ],
        ),
      ),
    );
  }
}
