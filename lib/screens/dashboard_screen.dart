import 'package:flutter/material.dart';
import 'package:lovely_money/constants.dart';
import 'package:lovely_money/models/dashboard.dart';
import 'package:lovely_money/models/login.dart';
import 'package:lovely_money/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class DashboardScreen extends StatefulWidget {
  static const String id = 'dashboard_screen';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String date = DateFormat('dd-MMM-yyyy').format(DateTime.now());
  String time = DateFormat('h:mm a').format(DateTime.now());
  var userSelectDate;
  var userSelectTime;
  String commentTransaction = '';
  String userEntry = "DEBIT";
  String userAmount = '';
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
    // retrieve default transaction
    Provider.of<Dashboard>(context, listen: false).retrieveDefaultTransaction(
        Provider.of<Login>(context, listen: false).email);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // use consumer widget for text to show username
                Consumer<Dashboard>(
                  builder: (context, dashboard, child) {
                    return Text(
                      'Hi, ${dashboard.username}! Today is $date, a ${DateFormat('EEEE').format(DateTime.now())}.',
                      style: kTitleStyle,
                    );
                  },
                ),
                // Icon button for settings, to go to settings screen
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    // Navigator.pushNamed(context, SettingsScreen.id);
                  },
                ),
                // icon button for logout
                IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                ),
              ],
            ),
            kSizedBoxLarge,
            FloatingActionButton(
              onPressed: () {
                // create a popup with 3 input text and a button for selecting date, along with a ok and cancel button
                showDialog(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(builder: (context, setState) {
                      return AlertDialog(
                        title: Text('New Transaction'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            // label showing the userSelectDate
                            Text(
                              // the text will be date if userselectdate is null, othertwise it will be userseelectdate
                              userSelectDate == null
                                  ? 'Date: $date'
                                  : 'Date: $userSelectDate',
                              style: kTitleStyle,
                            ),
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
                                    userSelectDate = date;
                                    userSelectDate = DateFormat('dd-MMM-yyyy')
                                        .format(userSelectDate);
                                    print(userSelectDate);
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
                                    userSelectTime = time?.format(context);
                                  });
                                });
                              },
                            ),
                            // use consumer for this dropdown button to select the user currency, with items from currenciesCode in constants file
                            Consumer<Dashboard>(
                              builder: (context, dashboard, _) =>
                                  DropdownButton(
                                value: dashboard.userDefaultCurrency,
                                items: currenciesCode
                                    .map((currency) => DropdownMenuItem(
                                          child: Text(currency),
                                          value: currency,
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    Provider.of<Dashboard>(context,
                                            listen: false)
                                        .userDefaultCurrency = value.toString();
                                  });
                                },
                              ),
                            ),
                            // textformfield for amount, with a label for amount and a textformat for only numbers and inputformatter
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Amount',
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d+\.?\d{0,2}')),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  userAmount = value;
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
                            // dropdown button for debit or credit entry
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
                            // use consumer for the dropdown list for item picker using items from dashboard
                            Consumer<Dashboard>(
                              builder: (context, dashboard, child) {
                                return DropdownButton(
                                  value: dashboard.userDefaultItem,
                                  items: dashboard.items!
                                      .map((item) => DropdownMenuItem(
                                            child: Text(item),
                                            value: item,
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      Provider.of<Dashboard>(context,
                                              listen: false)
                                          .userDefaultItem = value.toString();
                                    });
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Add'),
                            onPressed: () {
                              // add transaction
                              Provider.of<Dashboard>(context, listen: false)
                                  .addTransaction(
                                Provider.of<Login>(context, listen: false)
                                    .email,
                                userSelectDate ?? date,
                                userSelectTime ?? time,
                                Provider.of<Dashboard>(context, listen: false)
                                    .userDefaultCurrency,
                                Provider.of<Dashboard>(context, listen: false)
                                    .userDefaultItem,
                                userAmount,
                                userEntry,
                                commentTransaction,
                              );
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
                    });
                  },
                );
              },
              child: Icon(
                Icons.add,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
