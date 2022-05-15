import 'package:flutter/material.dart';
import 'package:lovely_money/screens/login.dart';
import 'package:lovely_money/screens/register.dart';

void main() {
  runApp(LovelyMoney());
}

class LovelyMoney extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lovely Money',
      //theme default dark mode
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
      //route
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
      },
    );
  }
  // This widget is the root of your application.

}
