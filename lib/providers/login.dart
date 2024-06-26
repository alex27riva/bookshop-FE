import 'dart:html' as html;

import 'package:bookshop_fe/constants/urls.dart';
import 'package:bookshop_fe/models/user.dart';
import 'package:bookshop_fe/services/backend_service.dart';
import 'package:bookshop_fe/services/secure_storage.dart';
import 'package:bookshop_fe/utils/environment.dart';
import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
  User currentUser = User.empty();

  bool get loggedIn => currentUser.loggedIn;

  String get username => currentUser.name;

  String get accessToken => currentUser.accessToken;

  void login(token) {
    currentUser = User.fromJwtToken(accessToken: token);
    // create account if not exist
    BackendService.createAccount(token);
    // Store token
    SecureStorage.storeAccessToken(token);
    notifyListeners();
  }

  Future<void> logout() async {
    html.window.location.href =
        "${Urls.logoutUrl}?client_id=${Environment.clientID}&post_logout_redirect_uri=${Uri.encodeComponent(Urls.bookshopUrl)}";
    SecureStorage.deleteAccessToken();
    currentUser = User.empty();
    notifyListeners();
  }
}
