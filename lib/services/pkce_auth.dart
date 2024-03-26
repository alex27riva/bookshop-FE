// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:math';

import 'package:bookshop_fe/constants/urls.dart';
import 'package:bookshop_fe/services/secure_storage.dart';
import 'package:bookshop_fe/utils/environment.dart';
import 'package:openid_client/openid_client.dart';


class PKCEAuth {
  static String _randomString(int length) {
    var r = Random.secure();
    var chars =
        '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    return Iterable.generate(length, (_) => chars[r.nextInt(chars.length)])
        .join();
  }

  static Future<Credential> authenticateWeb() async {
    Uri keycloakRealmUri = Uri.parse(Urls.keycloakRealmUrl);
    var clientId = Environment.clientID;
    var scopes = ['openid', 'profile', 'email', 'offline_access'];
    var issuer = await Issuer.discover(keycloakRealmUri);
    var client = Client(issuer, clientId);

    var codeVerifier =
        window.sessionStorage["auth_code_verifier"] ?? _randomString(50);
    var state = window.sessionStorage["auth_state"] ?? _randomString(20);
    var responseUrl = window.sessionStorage["auth_callback_response_url"];
    var flow = Flow.authorizationCodeWithPKCE(
      client,
      scopes: scopes,
      codeVerifier: codeVerifier,
      state: state,
    );

    flow.redirectUri = Uri.parse(
        '${window.location.protocol}//${window.location.host}${window.location.pathname}');

    if (responseUrl != null) {
      // handle callback
      try {
        var responseUri = Uri.parse(responseUrl);
        var credentials = await flow.callback(responseUri.queryParameters);
        return credentials;
      } finally {
        window.sessionStorage.remove("auth_code_verifier");
        window.sessionStorage.remove("auth_callback_response_url");
        window.sessionStorage.remove("auth_state");
      }
    } else {
      // redirect to auth server
      window.sessionStorage["auth_code_verifier"] = codeVerifier;
      window.sessionStorage["auth_state"] = state;
      var authorizationUrl = flow.authenticationUri;
      window.location.href = authorizationUrl.toString();
      throw "Authenticating...";
    }
  }

  static Future<void> authenticateAndSaveToken() async {
    Credential result = await PKCEAuth.authenticateWeb();
    var tokenResponse = await result.getTokenResponse();
    SecureStorage.storeToken(tokenResponse.accessToken);
  }
}
