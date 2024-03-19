class OauthConfig {
  // Prevent this class being instantiated
  OauthConfig._();

  static const String clientId = 'flask-demo';
  static const redirectUriScheme = 'http';
  static const redirectUriPath = 'localhost:8000/redirect';
  static const authorizationEndpoint =
      'http://localhost:8080/realms/unimi/protocol/openid-connect/auth';
  static const tokenUri = 'http://localhost:8080/realms/unimi/protocol/openid-connect/token';

}
