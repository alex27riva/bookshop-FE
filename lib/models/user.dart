import 'package:bookshop_fe/models/jwt_helper.dart';

class User {
  final String accessToken;
  bool loggedIn;
  final String id;
  final String issuer;
  final String audience;
  final String fullname;
  final String username;
  final String name;
  final String surname;
  final String email;

  User.empty()
      : accessToken = '',
        loggedIn = false,
        id = '',
        issuer = '',
        audience = '',
        fullname = '',
        username = '',
        name = '',
        surname = '',
        email = '';

  User.fromJwtToken({required this.accessToken, this.loggedIn = true})
      : id = JwtHelper(accessToken).subject,
        issuer = JwtHelper(accessToken).issuer,
        audience = JwtHelper(accessToken).audience,
        fullname = JwtHelper(accessToken).fullname,
        username = JwtHelper(accessToken).username,
        name = JwtHelper(accessToken).name,
        surname = JwtHelper(accessToken).surname,
        email = JwtHelper(accessToken).email;
}
