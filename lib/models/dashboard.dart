import 'dart:ffi';

import 'package:flutter/cupertino.dart';

class Dashboard extends ChangeNotifier {
  String? _username;
  String? _email;
  List<String>? _items;
  List<String>? _default;
}
