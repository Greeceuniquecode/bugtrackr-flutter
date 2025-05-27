import 'package:complimentsjar/pages/main_layout.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Text("This is Dashboard Page", style: TextStyle(color: Colors.black)),
    );
  }
}