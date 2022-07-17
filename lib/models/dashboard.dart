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
  late Stream<QuerySnapshot> _transactions;

  String? get username => _username;
  String? get email => _email;
  List<dynamic>? get items => _items;
  Map<String, dynamic>? get defaultTransaction => _defaultTransaction;
  String? get userDefaultCurrency => _userDefaultCurrency;
  String? get userDefaultItem => _userDefaultItem;
  Stream<QuerySnapshot> get transactions => _transactions;

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

  set transactions(Stream<QuerySnapshot> value) {
    _transactions = value;
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
      // the document might not exist, if it doesnt exist, then set new value, otherwise, update collection by appending new value to the existing one
      await FirebaseFirestore.instance
          .collection('transactions')
          .doc(email)
          .get()
          .then((value) {
        if (value.data() == null) {
          FirebaseFirestore.instance.collection('transactions').doc(email).set({
            DateFormat('MM-yyyy').format(DateTime.parse(date)): [
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
          FirebaseFirestore.instance
              .collection('transactions')
              .doc(email)
              .update({
            DateFormat('MM-yyyy').format(DateTime.parse(date)):
                FieldValue.arrayUnion(
              [
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
            )
          });
        }
      });
    } catch (error) {
      print(error);
    }
    // function to get transaction as a stream
    final Stream<QuerySnapshot> transactions = FirebaseFirestore.instance
        .collection('transactions')
        .doc(email)
        .collection(DateFormat('MM-yyyy').format(DateTime.parse(date)))
        .snapshots();
  }
}
