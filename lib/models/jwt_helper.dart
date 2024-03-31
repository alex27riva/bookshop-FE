import 'package:jwt_decoder/jwt_decoder.dart';

class JwtHelper {
  final String token;
  late Map<String, dynamic> _decodedToken;

  JwtHelper(this.token) {
    _decodedToken = JwtDecoder.decode(token);
  }

  String get subject => _decodedToken['sub'];
  String get issuer => _decodedToken['iss'];
  String get audience => _decodedToken['aud'];
  String get fullname => _decodedToken['name'];
  String get username => _decodedToken['preferred_username'];
  String get name => _decodedToken['given_name'];
  String get surname => _decodedToken['family_name'];
  String get email => _decodedToken['email'];

  int get expirationTimestamp => _decodedToken['exp'];
  int get issuedAtTimestamp => _decodedToken['iat'];
  List<String> get scopes => List<String>.from(_decodedToken['scopes'] ?? []);

  DateTime get expirationDate =>
      DateTime.fromMillisecondsSinceEpoch(expirationTimestamp * 1000);
  DateTime get issuedAtDate =>
      DateTime.fromMillisecondsSinceEpoch(issuedAtTimestamp * 1000);

  bool isValid() => DateTime.now().isBefore(expirationDate);
}
