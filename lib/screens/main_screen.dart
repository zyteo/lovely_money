import 'package:flutter/material.dart';
import 'package:lovely_money/constants.dart';

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
            Text('Main Screen', style: kTitleStyle),
            kSizedBoxLarge,
            ElevatedButton(
                onPressed: () {
                  // Navigator.pushNamed(context, AddTransactionScreen.id);
                },
                child: Text('Add Transaction')),
          ],
        ),
      ),
    );
  }
}
