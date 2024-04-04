import 'package:bookshop_fe/utils/environment.dart';

class Urls {
  // Prevent this class being instantiated
  Urls._();
  static String get keycloakRealmUrl =>
      '${Environment.keycloakUriScheme}://${Environment.keycloakHost}/realms/${Environment.keycloakRealm}';

  static const String baseDomain = 'http://localhost:5000';
  static const String booksEndpoint = '$baseDomain/api/books';
  static const String signupEndpoint = '$baseDomain/api/signup';
  static const String wishlistEndpoint = '$baseDomain/api/wishlist';
}
