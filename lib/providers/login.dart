import 'package:flutter/material.dart';
import 'package:openid_client/openid_client.dart';

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

  void setAccessToken(token) {
    _loggedIn = true;
    _accessToken = token;
    notifyListeners();
  }
}
