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
  String time = DateFormat('HH:mm').format(DateTime.now());
  var userSelectdate;
  var userSelectTime;
  String itemTransaction = "FOOD";
  String amountTransaction = '';
  String commentTransaction = '';
  String userCurrency = "SGD";
  String userEntry = "DEBIT";

  @override
  Widget build(BuildContext context) {
    Provider.of<Dashboard>(context, listen: false).email =
        Provider.of<Login>(context, listen: false).email;

    // retrieveItems function
    Provider.of<Dashboard>(context, listen: false)
        .retrieveItems(Provider.of<Login>(context, listen: false).email);
    // retrieveUsername function
    Provider.of<Dashboard>(context, listen: false)
        .retrieveUsername(Provider.of<Login>(context, listen: false).email);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
                'Hello, ${Provider.of<Dashboard>(context, listen: false).username} ',
                style: kTitleStyle),
            Text('Today is ${date} ', style: kTitleStyle),

            Text('Main Screen', style: kTitleStyle),
            kSizedBoxLarge,
            // button for date picker from 2022 to 2025, default is current date
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
                            // label showing the userSelectdate
                            Text(
                              // the text will be date if userselectdate is null, othertwise it will be userseelectdate
                              userSelectdate == null
                                  ? 'Date: $date'
                                  : 'Date: $userSelectdate',
                              style: kTitleStyle,
                            ),
                            // for user to change date
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
                            // label for current time, use setstate to update if time or suerselecttime
                            Text(
                              // text is usertime if its not null
                              userSelectTime == null
                                  ? 'Time: $time'
                                  : 'Time: $userSelectTime',
                              style: kTitleStyle,
                            ),
                            // button to change the time for userselecttime, note difference in timeofday and datetime
                            ElevatedButton(
                              child: Text('Change Time'),
                              onPressed: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((time) {
                                  setState(() {
                                    userSelectTime = time;
                                    print(userSelectTime);
                                  });
                                });
                              },
                            ),
                            DropdownButton(
                              value: userCurrency,
                              items: currenciesCode
                                  .map((currency) => DropdownMenuItem(
                                        child: Text(currency),
                                        value: currency,
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  userCurrency = value.toString();
                                });
                              },
                            ),

                            // Text field for amount, amount is to be numbers only, can be integers or float
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Amount',
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  amountTransaction = value;
                                });
                              },
                            ),
                            // Text field for comment, to be in string
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Comment',
                              ),
                              onChanged: (value) {
                                setState(() {
                                  commentTransaction = value;
                                });
                              },
                            ),
                            // dropdown button for debit or credit
                            DropdownButton(
                              value: userEntry,
                              items: [
                                DropdownMenuItem(
                                  child: Text('DEBIT'),
                                  value: 'DEBIT',
                                ),
                                DropdownMenuItem(
                                  child: Text('CREDIT'),
                                  value: 'CREDIT',
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  userEntry = value.toString();
                                });
                              },
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
