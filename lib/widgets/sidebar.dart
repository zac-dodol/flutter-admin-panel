import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      color: Colors.blueGrey.shade900,
      child: Column(
        children: [
          const SizedBox(height: 40),
          const Text("Admin Panel", style: TextStyle(fontSize: 20)),
          const SizedBox(height: 20),
          ListTile(
            title: const Text("Dashboard"),
            onTap: () => context.go('/'),
          ),
          ListTile(
            title: const Text("Users"),
            onTap: () => context.go('/users'),
          ),
          ListTile(
            title: const Text("Settings"),
            onTap: () => context.go('/settings'),
          ),
        ],
      ),
    );
  }
}
