import 'dart:convert';
import 'dart:io';

import 'package:bookshop_fe/constants/endpoints.dart';
import 'package:bookshop_fe/models/book.dart';
import 'package:bookshop_fe/models/user.dart';
import 'package:http/http.dart' as http;

class BackendService {
  static Future<List<Book>> fetchBooks() async {
    final response = await http.get(Uri.parse(Endpoints.books));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      return data.map((item) => Book.fromJson(item)).toList();
    } else {
      // Handle other errors (non-client exceptions)
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  static Future<http.Response> checkAccount(String token) async {
    final response = await http.post(
      Uri.parse(Endpoints.signup),
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token"
      },
    );
    return response;
  }

  static Future<List<Book>> fetchWishlist(String token) async {
    final response = await http.get(
      Uri.parse(Endpoints.wishlist),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final wishlist = data['wishlist'] as List<dynamic>;
      print(wishlist);

      var wishlistBooks = wishlist.map((item) => Book.fromJson(item)).toList();
      return wishlistBooks;
    } else {
// Handle API errors here, e.g., show a snackbar
      print('Error fetching wishlist: ${response.statusCode}');
      return [];
    }
  }

  static Future<User> getProfile(String token) async {
    final response = await http.get(Uri.parse(Endpoints.profile),
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
    if (response.statusCode == 200) {
      return User.fromBackendResponse(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch profile: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> updateProfilePicture(
      String token, String newUrl) async {
    final response = await http.put(
      Uri.parse(Endpoints.profilePicUpdate),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
        'Content-Type': 'application/json'
      },
      body: jsonEncode({'profile_pic_url': newUrl}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'Failed to update profile picture: ${response.statusCode}');
    }
  }

  static Future<http.Response> addToWishlist(String token, int bookId) async {
    final Map<String, dynamic> body = {"book_id": bookId};
    final response = await http.post(
      Uri.parse(Endpoints.wishlist),
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
    String baseUrl = Endpoints.wishlist;
    final response = await http.delete(
      Uri.parse("$baseUrl/$bookId"),
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
    );
    return response;
  }

  static Future<http.Response> adminBookDelete(String token, int bookId) async {
    String endpoint = Endpoints.adminBook;
    final response = await http.delete(
      Uri.parse("$endpoint/$bookId"),
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
    );
    return response;
  }

  static Future<http.Response> adminBookAdd(String token, String title, String author, double price, String coverImageUrl) async {
    final Map<String, dynamic> bookData = {
      'title': title,
      'author': author,
      'price': price,
      'cover_image_url': coverImageUrl,
    };

    final body = jsonEncode(bookData);

    final response = await http.post(
      Uri.parse(Endpoints.adminBook),
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
      body: body,
    );

    return response;
  }
}
