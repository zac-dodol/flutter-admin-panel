import 'package:flutter/material.dart';
import 'dart:html' as html; // For local storage on Flutter web

class AuthService extends ChangeNotifier {
  String? _username;
  String? _role;

  String? get username => _username;
  String get role => _role ?? 'viewer';

  bool get isAuthenticated => _username != null;

  AuthService() {
    _loadFromStorage();
  }

  bool login(String username, String password) {
    if (username == 'admin' && password == 'password') {
      _username = username;
      _role = 'admin';
      _saveToStorage();
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() {
    _username = null;
    _role = null;
    _clearStorage();
    notifyListeners();
  }

  void _saveToStorage() {
    html.window.localStorage['username'] = _username ?? '';
    html.window.localStorage['role'] = _role ?? 'viewer';
  }

  void _loadFromStorage() {
    final storedUsername = html.window.localStorage['username'];
    final storedRole = html.window.localStorage['role'];

    if (storedUsername != null && storedUsername.isNotEmpty) {
      _username = storedUsername;
      _role = storedRole ?? 'viewer';
    }
  }

  void _clearStorage() {
    html.window.localStorage.remove('username');
    html.window.localStorage.remove('role');
  }
}
