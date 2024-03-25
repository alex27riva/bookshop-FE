import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get clientID => dotenv.get('CLIENT_ID');
  static String get redirectUriScheme => dotenv.get('REDIRECT_URI_SCHEME');
  static String get redirectUriPath => dotenv.get('REDIRECT_URI_PATH');
  static String get authorizationEndpoint => dotenv.get('AUTH_ENDPOINT_URI');
  static String get backendCallbackUri => dotenv.get('BACKEND_CALLBACK_URI');
}
