import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Dashboard extends ChangeNotifier {
  String? _username;
  String? _email;
  List<dynamic>? _items;
  Map<String, String>? _defaultTransaction;

  String? get username => _username;
  String? get email => _email;
  List<dynamic>? get items => _items;
  Map<String, String>? get defaultTransaction => _defaultTransaction;

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
  
  set defaultTransaction(Map<String, String>? value) {
    _defaultTransaction = value;
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

 
}
