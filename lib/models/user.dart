import 'dart:io';

import 'package:bookshop_fe/models/jwt_helper.dart';

class User {
  final String accessToken;
  bool loggedIn;
  final String sub;
  final String issuer;
  final String audience;
  final String fullName;
  final String username;
  final String name;
  final String surname;
  final String email;
  final String profilePicUrl;

  User.empty()
      : accessToken = '',
        loggedIn = false,
        sub = '',
        issuer = '',
        audience = '',
        fullName = '',
        username = '',
        name = '',
        surname = '',
        email = '',
        profilePicUrl = '';

  User.fromJwtToken({required this.accessToken, this.loggedIn = true})
      : sub = JwtHelper(accessToken).subject,
        issuer = JwtHelper(accessToken).issuer,
        audience = JwtHelper(accessToken).audience,
        fullName = JwtHelper(accessToken).fullName,
        username = JwtHelper(accessToken).username,
        name = JwtHelper(accessToken).name,
        surname = JwtHelper(accessToken).surname,
        email = JwtHelper(accessToken).email,
        profilePicUrl = JwtHelper(accessToken).picture;

  User.fromBackendResponse(Map<String, dynamic> json)
      : sub = json['id'].toString(),
        email = json['email'],
        profilePicUrl = json['profile_pic_url'],
        accessToken = '',
        loggedIn = false,
        issuer = '',
        audience = '',
        fullName = '',
        username = '',
        name = json['name'] ?? '',
        surname = json['surname'] ?? '';
}
