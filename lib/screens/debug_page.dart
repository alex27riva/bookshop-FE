import 'package:bookshop_fe/providers/login.dart';
import 'package:bookshop_fe/services/backend_service.dart';
import 'package:bookshop_fe/widgets/custom_side_menu.dart';
import 'package:bookshop_fe/widgets/jwt_claim_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:bookshop_fe/utils/app_state.dart' as app_state;

class DebugPage extends StatefulWidget {
  const DebugPage({super.key});

  @override
  State<DebugPage> createState() => _DebugPageState();
}

class _DebugPageState extends State<DebugPage> {
  @override
  Widget build(BuildContext context) {
    var lp = Provider.of<LoginProvider>(context);
    final user = app_state.cachedAuthedUser.of(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Debug'),
        ),
        drawer: const CustomSideMenu(),
        body: lp.loggedIn
            ? Column(
                children: [
                  Container(
                    color: Colors.orange,
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () =>
                              BackendService.checkAccount(lp.accessToken),
                          child: const Text("Force account registration",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        TextButton(
                          onPressed: () {
                            Clipboard.setData(
                                ClipboardData(text: lp.accessToken));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('JWT token copied to clipboard')),
                            );
                          },
                          child: const Text("Copy token",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                  JwtClaimViewer(token: lp.accessToken),
                ],
              )
            : const Center(child: Text("Please login")));
  }
}
