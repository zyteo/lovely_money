import 'package:flutter/material.dart';
import 'package:lovely_money/constants.dart';
import 'package:lovely_money/models/login.dart';
import 'package:lovely_money/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatefulWidget {
  static const String id = 'dashboard_screen';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String date = DateFormat('dd-MMM-yyyy').format(DateTime.now());
  late var userSelectdate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Hello, ${Provider.of<Login>(context, listen: false).email} ',
                style: kTitleStyle),
            Text('Today is ${date} ', style: kTitleStyle),
            // button for date picker from 2022 to 2025, default is current date
            ElevatedButton(
              child: Text('Change Date'),
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2022),
                  lastDate: DateTime(2025),
                ).then((date) {
                  setState(() {
                    userSelectdate = date;
                    userSelectdate =
                        DateFormat('dd-MMM-yyyy').format(userSelectdate);
                    print(userSelectdate);
                  });
                });
              },
            ),

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
                  Navigator.pushNamed(context, LoginScreen.id);
                },
                child: Text('Logout')),
            ElevatedButton(
                onPressed: () {
                  // go back to login screen
                },
                child: Text('Settings')),
            // elevated button
          ],
        ),
      ),
    );
  }
}
