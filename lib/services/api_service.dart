import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:oauth_frontend/models/token_response.dart';

class ApiService {
  final String _tokenUrl = 'http://localhost:8080/auth/realms/unimi/protocol/openid-connect/token';
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<String?> getToken(String code) async {
    final response = await http.post(
      Uri.parse(_tokenUrl),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'grant_type': 'authorization_code',
        'client_id': 'flask-demo',
        'redirect_uri': 'your_redirect_uri',
        'code': code,
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final tokenResponse = TokenResponse.fromJson(jsonResponse);
      await _secureStorage.write(key: 'access_token', value: tokenResponse.accessToken);
      return tokenResponse.accessToken;
    } else {
      throw Exception('Failed to get token');
    }
  }

  Future<String?> getAccessToken() async {
    return await _secureStorage.read(key: 'access_token');
  }
}