import 'package:bookshop_fe/utils/environment.dart';

class Urls {
  // Prevent this class being instantiated
  Urls._();

  static String get keycloakRealmUrl =>
      '${Environment.keycloakUriScheme}://${Environment.keycloakHost}/realms/${Environment.keycloakRealm}';

  static String get logoutUrl =>
      '${Environment.keycloakUriScheme}://${Environment.keycloakHost}/realms/${Environment.keycloakRealm}/protocol/openid-connect/logout';

  // Bookshop app url
  static String get bookshopUrl => 'http://localhost:8000';
}
