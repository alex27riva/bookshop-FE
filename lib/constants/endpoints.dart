import 'package:bookshop_fe/utils/environment.dart';

class Endpoints {
  // Prevent this class being instantiated
  Endpoints._();

  static const String baseDomain = 'http://localhost:5000';
  static const String books = '$baseDomain/api/books';
  static const String signup = '$baseDomain/api/signup';
  static const String wishlist = '$baseDomain/api/wishlist';
  static const String profile = '$baseDomain/api/profile';
  static const String profilePicUpdate = '$baseDomain/api/profile/picture';
}
