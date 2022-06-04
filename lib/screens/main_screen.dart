import 'package:flutter/material.dart';
import 'package:lovely_money/constants.dart';
import 'package:lovely_money/models/login.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  static const String id = 'main_screen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Hello, ${Provider.of<Login>(context, listen: false).email} ',
                style: kTitleStyle),
            Text('Main Screen', style: kTitleStyle),
            kSizedBoxLarge,
            ElevatedButton(
                onPressed: () {
                  // Navigator.pushNamed(context, AddTransactionScreen.id);
                },
                child: Text('Add Transaction')),
            ElevatedButton(
                onPressed: () {
                  // go back to login screen
                  Navigator.pop(context);
                },
                child: Text('Logout')),
            // elevated button
          ],
        ),
      ),
    );
  }
}
