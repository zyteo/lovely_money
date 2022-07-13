import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class Dashboard extends ChangeNotifier {
  String? _username;
  String? _email;
  List<dynamic>? _items;
  Map<String, dynamic>? _defaultTransaction;
  String? _userDefaultCurrency;
  String? _userDefaultItem;

  String? get username => _username;
  String? get email => _email;
  List<dynamic>? get items => _items;
  Map<String, dynamic>? get defaultTransaction => _defaultTransaction;
  String? get userDefaultCurrency => _userDefaultCurrency;
  String? get userDefaultItem => _userDefaultItem;

  set username(String? value) {
    _username = value;
    notifyListeners();
  }

  set email(String? value) {
    _email = value;
    notifyListeners();
  }

  set items(List<dynamic>? value) {
    _items = value;
    notifyListeners();
  }

  set defaultTransaction(Map<String, dynamic>? value) {
    _defaultTransaction = value;
    notifyListeners();
  }

  set userDefaultCurrency(String? value) {
    _userDefaultCurrency = value;
    notifyListeners();
  }

  set userDefaultItem(String? value) {
    _userDefaultItem = value;
    notifyListeners();
  }

  // function retrieveitems that takes items from firebase firestore and set them to the items list
  Future retrieveItems(email) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(email)
          .get()
          .then((value) {
        _items = value.data()!['items'];
        print(items);
      });
    } catch (error) {
      print(error);
    }
  }

  // function to retrieve the username from firebase with email as input
  Future retrieveUsername(email) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(email)
          .get()
          .then((value) {
        _username = value.data()!['username'];
        print(username);
      });
    } catch (error) {
      print(error);
    }
  }

  // function to retrieve the default transaction from firebase with email as input
  Future retrieveDefaultTransaction(email) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(email)
          .get()
          .then((value) {
        _defaultTransaction = value.data()!['default'];
        userDefaultItem = _defaultTransaction!['item'];
        userDefaultCurrency = _defaultTransaction!['currency'];
      });
    } catch (error) {
      print(error);
    }
  }

  // function to add transaction to firebase
  Future addTransaction(
      email, date, time, currency, item, amount, entry, comment) async {
    try {
      // the document might not exist, if it doesnt exist, then set new, otherwise, update collection
      await FirebaseFirestore.instance
          .collection('transactions')
          .doc(email)
          .get()
          .then((value) {
        if (value.exists) {
          FirebaseFirestore.instance
              .collection('transactions')
              .doc(email)
              .update({
            DateFormat('MM-yyyy').format(DateTime.now()): [
              {
                // 7 inputs for the transaction - date, time, currency, item, amount, entry, comment
                'date': date,
                'time': time,
                'currency': currency,
                'item': item,
                'amount': amount,
                'entry': entry,
                'comment': comment,
              }
            ],
          });
        } else {
          FirebaseFirestore.instance.collection('transactions').doc(email).set({
            DateFormat('MM-yyyy').format(DateTime.now()): [
              {
                // 7 inputs for the transaction - date, time, currency, item, amount, entry, comment
                'date': date,
                'time': time,
                'currency': currency,
                'item': item,
                'amount': amount,
                'entry': entry,
                'comment': comment,
              }
            ],
          });
        }
      });
    } catch (error) {
      print(error);
    }
  }
}
