import 'package:flutter/material.dart';

import '../models/user.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  User? user;

  bool get isLoggedIn => user != null;

  Future<void> login(String email, String password) async {
    user = await _authService.login(email, password);
    notifyListeners();
  }

  Future<void> register(String name, String email, String password) async {
    user = await _authService.register(name, email, password);
    notifyListeners();
  }

  void logout() {
    user = null;
    notifyListeners();
  }
}
