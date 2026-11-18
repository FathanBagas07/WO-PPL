import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  String _selectedRole = 'client';

  String get selectedRole => _selectedRole;

  void setRole(String role) {
    _selectedRole = role;
    notifyListeners();
  }
}