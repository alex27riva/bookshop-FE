import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static Future<String> getStoredToken() async =>
      await const FlutterSecureStorage().read(key: "auth_token") ?? '';
  static void storeToken(token) async =>
      await const FlutterSecureStorage().write(key: "auth_token", value: token);
}
