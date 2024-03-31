import 'package:bookshop_fe/models/user.dart';
import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
  User currentUser = User.empty();

  bool get loggedIn => currentUser.loggedIn;
  String get username => currentUser.name;
  String get accessToken => currentUser.accessToken;

  void login(token) {
    currentUser = User.fromJwtToken(accessToken: token);
    notifyListeners();
  }

  void logout() {
    currentUser = User.empty();
    notifyListeners();
  }
}
