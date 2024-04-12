import 'package:bookshop_fe/utils/environment.dart';

class Urls {
  // Prevent this class being instantiated
  Urls._();

  static String get keycloakRealmUrl =>
      '${Environment.keycloakUriScheme}://${Environment.keycloakHost}/realms/${Environment.keycloakRealm}';
}
