import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Welcome to Dashboard",
          style: Theme.of(context).textTheme.headlineMedium),
    );
  }
}
