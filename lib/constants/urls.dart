class URLS {
  // Prevent this class being instantiated
  URLS._();

  static const String baseDomain = 'http://localhost:5000';
  static const String booksEndpoint = '$baseDomain/api/books';
  static const String signupEndpoint = '$baseDomain/api/register';
}
