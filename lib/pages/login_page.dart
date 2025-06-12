// login_page.dart
import 'package:complimentsjar/api/auth_service.dart';
import 'package:complimentsjar/pages/main_layout.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _loading = false;

  void _loginUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _loading = true);
      final result = await AuthService.login(
        _emailController.text,
        _passwordController.text,
      );
    final message = result['message'] ?? 'Unknown response';
    final user = result['user'];
    final role = user?['role'];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
      );

      setState(() => _loading = false);

      // If login is successful, navigate to dashboard
      if (message.toLowerCase().contains('success')) {
        Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.pushNamed(context, '/$role-dashboard');
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.sizeOf(context).height;
    final deviceWidth = MediaQuery.sizeOf(context).width;

    return MainLayout(
      child: Container(
        width: deviceWidth,
        color: Colors.white,
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 12,
            children: [
              const Text(
                "Login Page",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),

              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),

              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _loading ? null : _loginUser,
                  child:
                      _loading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("Login"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}