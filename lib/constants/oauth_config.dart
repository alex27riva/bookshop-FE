class OauthConfig {
  // Prevent this class being instantiated
  OauthConfig._();

  static const String clientId = 'flask-demo';
  static const redirectUriScheme = 'http';
  static const redirectUriPath = 'localhost:5000/api/callback';
  static const authorizationEndpoint =
      'http://localhost:8080/auth/realms/unimi/protocol/openid-connect/auth';

}
