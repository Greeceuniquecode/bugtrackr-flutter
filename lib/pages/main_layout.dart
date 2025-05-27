import 'package:complimentsjar/widgets/custom_dropdown.dart';
import 'package:flutter/material.dart';
class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  static const List<String> menuItems = [
    "Home",
    "About",
    "Contact",
    "Login",
    "Sign Up",
    "Projects",
  ];

  void _navigate(BuildContext context, String value) {
    switch (value) {
      case "Home":
        Navigator.pushNamed(context, '/');
        break;
      case "About":
        Navigator.pushNamed(context, '/about');
        break;
      case "Contact":
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Contact page coming soon!')),
        );
        break;
      case "Login":
        Navigator.pushNamed(context, '/login');
        break;
      case "Sign Up":
        Navigator.pushNamed(context, '/signup');
        break;
        case "Projects":
        Navigator.pushNamed(context, '/projects');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
         automaticallyImplyLeading: false, // 🔺 This removes the back arrow
        backgroundColor: Colors.blue.shade800,
        title: const Text(
          "BugTrackr",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 28,
            color: Colors.white,
          ),
        ),
        actions: [
          Center(
            child: CustomDropdown(
              values: menuItems,
              onSelected: (value) => _navigate(context, value),
            ),
          ),
        ],
      ),
      body: SafeArea(child: child),
    );
  }
}