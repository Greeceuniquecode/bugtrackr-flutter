import 'package:complimentsjar/pages/main_layout.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Text("This is About Page", style: TextStyle(color: Colors.black)),
    );
  }
}
