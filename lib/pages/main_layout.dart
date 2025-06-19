import 'package:complimentsjar/api/auth_service.dart';
import 'package:complimentsjar/widgets/custom_dropdown.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatefulWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  String? email;
  String? role;

  @override
  void initState() {
    super.initState();
    _loadLoginInfo();
  }

  Future<void> _loadLoginInfo() async {
    final storedInfo = await AuthService.getLoginInfo();

    if (storedInfo != null) {
      setState(() {
        email = storedInfo['email'];
        role = storedInfo['role'];
      });
    }
  }

  List<String> get menuItems {
    if (email == null) {
      return ["Home", "About", "Contact", "Login", "Sign Up"];
    } else {
      return ["Home", "About", "Contact", "Projects", "Logout"];
    }
  }

  void _navigate(BuildContext context, String value) {
    switch (value) {
      case "Home":
        if (role == "reporter") {
          Navigator.pushNamed(context, '/reporter-dashboard');
        }
        if (role == 'debugger') {
          Navigator.pushNamed(context, '/debugger-dashboard');
        }
        if (role == 'admin') {
          Navigator.pushNamed(context, '/admin-dashboard');
        }
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
      if (role == "debugger") {
        Navigator.pushNamed(context, '/debugger-projects');
      }
      if (role == "reporter") {
        Navigator.pushNamed(context, '/reporter-projects');
      }
        break;
      case "Logout":
        Navigator.pushNamed(context, '/logout');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
      body: SafeArea(child: widget.child),
    );
  }
}
