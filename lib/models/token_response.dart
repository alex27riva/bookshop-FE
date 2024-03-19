class TokenResponse {
  final String accessToken;

  TokenResponse({required this.accessToken});

  factory TokenResponse.fromJson(Map<String, dynamic> json) {
    return TokenResponse(accessToken: json['access_token']);
  }
}