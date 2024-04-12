import 'package:bookshop_fe/providers/login.dart';
import 'package:bookshop_fe/widgets/custom_side_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    var lp = Provider.of<LoginProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Admin page'),
        ),
        drawer: const CustomSideMenu(),
        body: Center());
  }
}
