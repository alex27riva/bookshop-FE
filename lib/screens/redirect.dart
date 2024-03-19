import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RedirectPage extends StatefulWidget {
  final String redirectUrl;

  const RedirectPage({super.key, required this.redirectUrl});

  @override
  _RedirectPageState createState() => _RedirectPageState();
}

class _RedirectPageState extends State<RedirectPage> {
  @override
  void initState() {
    super.initState();
    _handleRedirect();
  }

  Future<void> _handleRedirect() async {
    // Extract OAuth2 authorization code or access token from the redirect URL
    // and send it to the Flask backend for further processing
    // Example: send token to backend using HTTP POST request

    // Assuming you're using package:url_launcher to handle redirection
    final url = Uri.parse(widget.redirectUrl);
    if (url.queryParameters.containsKey('code')) {
      // Extract code from URL
      String code = url.queryParameters['code']!;
      // Send the code to your backend
      // Example: await http.post('YOUR_BACKEND_URL', body: {'code': code});
    }

    // Close the redirection page
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Redirect Page'),
      ),
      body: const Center(
        child: CircularProgressIndicator(), // Show a loading indicator
      ),
    );
  }
}
