import 'package:flutter/cupertino.dart';

class Login extends ChangeNotifier {
  String? _username;
  String? _password;
  String? _email;

  String? get username => _username;
  String? get password => _password;
  String? get email => _email;

  set username(String? value) {
    _username = value;
    notifyListeners();
  }

  set password(String? value) {
    _password = value;
    notifyListeners();
  }

  set email(String? value) {
    _email = value;
    notifyListeners();
  }

  // login function
  void login() {
    print('login');
  }
}
