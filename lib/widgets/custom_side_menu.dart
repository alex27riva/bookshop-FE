import 'package:flutter/material.dart';

class CustomSideMenu extends StatelessWidget {
  const CustomSideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: const [
          // Add your menu items here
        ],
      ),
    );
  }
}
