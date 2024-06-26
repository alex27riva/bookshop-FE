import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static Future<String> getAccessToken() async =>
      await const FlutterSecureStorage().read(key: "accessToken") ?? '';

  static void storeAccessToken(token) async =>
      await const FlutterSecureStorage()
          .write(key: "accessToken", value: token);

  static Future<void> deleteAccessToken() async =>
      await const FlutterSecureStorage().delete(key: 'accessToken');

  static Future<bool> isLoggedIn() async {
    return await getAccessToken() != '';
  }
}
