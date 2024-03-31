import 'package:bookshop_fe/models/user.dart';
import 'package:flutter/material.dart';

class Login with ChangeNotifier {
  User emptyUser = User(jwtToken: "");
  User currentUser = User(jwtToken: "");

  bool get loggedIn => currentUser.loggedIn;
  String get username => currentUser.name;
  String get accessToken => currentUser.jwtToken;

  void login(token) {
    currentUser = User(jwtToken: token);
    notifyListeners();
  }

  void logout() {
    currentUser = emptyUser;
    notifyListeners();
  }
}
