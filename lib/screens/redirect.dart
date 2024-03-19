import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class KeycloakRedirectPage extends StatefulWidget {
  final Function(String) onTokenReceived;
  String _uri = "";
  String _code = "";

  KeycloakRedirectPage({required this.onTokenReceived});

  @override
  _KeycloakRedirectPageState createState() => _KeycloakRedirectPageState();
}

class _KeycloakRedirectPageState extends State<KeycloakRedirectPage> {
  @override
  void initState() {
    super.initState();
    _handleRedirect();
  }

  void _handleRedirect() {
    // Extract token from the redirect URI
    Uri uri = Uri.parse(html.window.location.href);
    widget._uri = uri.toString();
    String? code = uri.queryParameters['code'];
    widget._code = code.toString();

    // Notify the parent widget with the received token
    widget.onTokenReceived(code!);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(widget._uri),
          Text(
            widget._code,
            style: const TextStyle(color: Colors.red),
          )
        ],
      ),
    );
  }
}
