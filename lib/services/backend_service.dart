import 'dart:convert';
import 'dart:io';

import 'package:bookshop_fe/constants/urls.dart';
import 'package:http/http.dart' as http;

class BackendService {
  static Future<http.Response> checkAccount(String token) async {
    final response = await http.post(
      Uri.parse(Urls.signupEndpoint),
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token"
      },
    );
    return response;
  }

  static Future<http.Response> addToWishlist(String token, int bookId) async {
    final Map<String, dynamic> body = {"book_id": bookId};
    final response = await http.post(
      Uri.parse(Urls.wishlistEndpoint),
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
      body: jsonEncode(body),
    );
    return response;
  }

  static Future<http.Response> removeFromWishlist(
      String token, int bookId) async {
    String baseUrl = Urls.wishlistEndpoint;
    final response = await http.delete(
      Uri.parse("$baseUrl/$bookId"),
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
    );
    return response;
  }
}
