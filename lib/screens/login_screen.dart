import 'package:flutter/material.dart';
import 'package:lovely_money/constants.dart';
import 'package:lovely_money/models/login.dart';
import 'package:lovely_money/screens/main_screen.dart';
import 'package:lovely_money/screens/register_screen.dart';
import 'package:provider/provider.dart';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Login', style: kTitleStyle),
            kSizedBoxLarge,
            // textform field for the email
            Padding(
              padding: kPadding,
              child: TextFormField(
                decoration: kInputDecoration('Email'),
                onChanged: (value) {
                  Provider.of<Login>(context, listen: false).email =
                      value.toLowerCase();
                },
              ),
            ),
            kSizedBoxSmall,
            Padding(
              padding: kPadding,
              child: TextFormField(
                obscureText: true,
                decoration: kInputDecoration('Password'),
                onChanged: (value) {
                  Provider.of<Login>(context, listen: false).password = value;
                },
              ),
            ),
            kSizedBoxMedium,
            ElevatedButton(
                onPressed: () {
                  Login().login(
                      context,
                      Provider.of<Login>(context, listen: false).email,
                      Provider.of<Login>(context, listen: false).password);
                },
                child: Text('Login')),
            kSizedBoxSmall,
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, RegisterScreen.id);
                },
                child: Text('Register')),
          ],
        ),
      ),
    );
  }
}
