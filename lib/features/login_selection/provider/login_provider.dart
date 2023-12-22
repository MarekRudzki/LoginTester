import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  int _selectedLoginValue = 0;

  int get selectedLoginValue => _selectedLoginValue;

  void setLoginValue({
    required int value,
  }) {
    _selectedLoginValue = value;
    notifyListeners();
  }
}
