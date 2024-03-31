import 'package:flutter/material.dart';

class Login with ChangeNotifier {
  // ignore: prefer_final_fields
  bool _loggedIn = false;
  String _username = "Guest";
  String _accessToken = "";

  bool get isLoggedIn => _loggedIn | (_accessToken != "");
  String get getUsername => _username;

  void setUsername(user) {
    _username = user;
    notifyListeners();
  }

  void login(token) {
    _loggedIn = true;
    _accessToken = "";
    notifyListeners();
  }

  void logout() {
    _loggedIn = false;
    _username = "Guest";
    _accessToken = "";
    notifyListeners();
  }
}
