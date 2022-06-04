import 'package:flutter/material.dart';
import 'package:lovely_money/constants.dart';
import 'package:lovely_money/models/dashboard.dart';
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
  String itemTransaction = '';

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

            Text('Main Screen', style: kTitleStyle),
            kSizedBoxLarge,
            ElevatedButton(
                onPressed: () {
                  // create a popup with 3 input text and a button for selecting date, along with a ok and cancel button

                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('New Transaction'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Amount',
                              ),
                            ),
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Description',
                              ),
                            ),
                            // add a dropdown list for the item picker using items from the dashboard model
                            DropdownButton<String>(
                              value: itemTransaction,
                              items:
                                  Provider.of<Dashboard>(context, listen: false)
                                      .items!
                                      .map((item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  itemTransaction = value!;
                                });
                              },
                            ),
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
                                    userSelectdate = DateFormat('dd-MMM-yyyy')
                                        .format(userSelectdate);
                                    print(userSelectdate);
                                  });
                                });
                              },
                            ),
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Date',
                              ),
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Add'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
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
                  Dashboard().retrieveItems(
                      Provider.of<Login>(context, listen: false).email);
                },
                child: Text('Settings')),
            // elevated button
          ],
        ),
      ),
    );
  }
}
