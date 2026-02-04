import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String? _userRole;
  Map<String, dynamic>? _user;

  String? get userRole => _userRole;
  Map<String, dynamic>? get user => _user;
  bool get isLoggedIn => _user != null;

  Future<void> login(String email, String password) async {
    // TODO: Implement actual authentication with Supabase
    // For now, mock based on email
    if (email.contains('admin')) {
      _user = {'id': '1', 'name': 'Admin User', 'email': email, 'role': 'admin'};
      _userRole = 'admin';
    } else {
      _user = {'id': '2', 'name': 'Employee User', 'email': email, 'role': 'employee'};
      _userRole = 'employee';
    }
    notifyListeners();
  }

  void logout() {
    _user = null;
    _userRole = null;
    notifyListeners();
  }
}