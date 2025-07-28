import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserService extends ChangeNotifier {
  List<Map<String, String>> users = [];

  UserService() {
    _loadUsers();
  }

  void addUser() {
    users.add({
      "id": DateTime.now().toString(),
      "name": "New User",
      "email": "",
      "role": "viewer"
    });
    _saveUsers();
  }

  void deleteUser(int index) {
    users.removeAt(index);
    _saveUsers();
  }

  void updateUser(int index, String key, String value) {
    users[index][key] = value;
    _saveUsers();
  }

  void _saveUsers() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('users', jsonEncode(users));
    notifyListeners();
  }

  void _loadUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('users');
    if (data != null) {
      users = List<Map<String, String>>.from(jsonDecode(data));
    } else {
      users = [
        {
          "id": "1",
          "name": "John Doe",
          "email": "john@example.com",
          "role": "admin"
        },
        {
          "id": "2",
          "name": "Jane Smith",
          "email": "jane@example.com",
          "role": "editor"
        },
      ];
    }
    notifyListeners();
  }
}
