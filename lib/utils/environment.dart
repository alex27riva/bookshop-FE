import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get clientID => dotenv.get('CLIENT_ID');
  static String get keycloakRealm => dotenv.get('KEYCLOAK_REALM');
  static String get keycloakUriScheme => dotenv.get('KEYCLOAK_URI_SCHEME');
  static String get keycloakHost => dotenv.get('KEYCLOAK_HOST');
}
