class User {
  final String name;
  final String? email;
  final String jwtToken;
  final bool loggedIn;

  User({
    this.name = "User",
    this.email,
    required this.jwtToken,
  }) : loggedIn = jwtToken.isNotEmpty;

  factory User.fromJson(Map<String, dynamic> json) {
    final name = json['name'] != null ? _extractNameFromJwt(json['jwtToken']) : "";
    final email = json['email'] != null ? _extractEmailFromJwt(json['jwtToken']) : "";

    return User(
      name: name,
      email: email,
      jwtToken: json['jwtToken'],
    );
  }

  // Moved these methods outside the class definition
  static String _extractNameFromJwt(String token) {
    // Extract name from JWT claims (logic specific to your JWT library)
    return "Name from JWT";
  }

  static String _extractEmailFromJwt(String token) {
    // Extract email from JWT claims (logic specific to your JWT library)
    return "Email from JWT";
  }
}