// ignore_for_file: avoid_redundant_argument_values

import 'package:async/async.dart';
import 'package:bdaya_shared_value/bdaya_shared_value.dart';
import 'package:bookshop_fe/constants/urls.dart';
import 'package:bookshop_fe/utils/environment.dart';
import 'package:logging/logging.dart';
import 'package:oidc/oidc.dart';
import 'package:oidc_default_store/oidc_default_store.dart';

final logger = Logger('Bookshop');
const String redirectPage = 'redirect.html';

// Gets the current manager
OidcUserManager currentManager = duendeManager;

final duendeManager = OidcUserManager.lazy(
  discoveryDocumentUri: OidcUtils.getOpenIdConfigWellKnownUri(
    Uri.parse(
        "${Environment.keycloakUriScheme}://${Environment.keycloakHost}/realms/${Environment.keycloakRealm}"),
  ),
  // this is a public client,
  // so we use [OidcClientAuthentication.none] constructor.
  clientCredentials: OidcClientAuthentication.none(
    clientId: Environment.clientID,
  ),
  store: OidcDefaultStore(
      // useSessionStorageForSessionNamespaceOnWeb: true,
      ),

  // keyStore: JsonWebKeyStore(),
  settings: OidcUserManagerSettings(
    frontChannelLogoutUri: Uri(path: redirectPage),
    uiLocales: ['en'],
    refreshBefore: (token) {
      return const Duration(seconds: 1);
    },
    // scopes supported by the provider and needed by the client.
    scope: ['openid', 'profile', 'email', 'offline_access'],
    postLogoutRedirectUri: Uri.parse("${Urls.bookshopUrl}/$redirectPage"),

    redirectUri: Uri.parse("${Urls.bookshopUrl}/$redirectPage"),
  ),
);

final initMemoizer = AsyncMemoizer<void>();

Future<void> initApp() {
  return initMemoizer.runOnce(() async {
    currentManager.userChanges().listen((event) {
      cachedAuthedUser.$ = event;
      logger.info(
        'User changed: ${event?.claims.toJson()}, info: ${event?.userInfo}',
      );
    });

    await currentManager.init();
  });
}

final cachedAuthedUser = SharedValue<OidcUser?>(value: null);
