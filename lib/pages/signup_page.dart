<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _loading = false;

  Future<void> _signupUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _loading = true);

      final url = Uri.parse('http://10.0.2.2:8000/api/register');

      try {
        final response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode({
            'name': _nameController.text,
            'email': _emailController.text,
            'password': _passwordController.text,
            'password_confirmation': _confirmPasswordController.text,
          }),
        );

        final data = jsonDecode(response.body);

        if (response.statusCode == 200) {
          const SnackBar(
            content: Text('Signed up successfully!'),
            behavior: SnackBarBehavior.floating,
          );
        } else {
          SnackBar(
            content: Text(data['message'] ?? 'Signup failed'),
            behavior: SnackBarBehavior.floating,
          );
        }
      } catch (e) {
        SnackBar(
          content: Text('Error: $e'),
          behavior: SnackBarBehavior.floating,
        );
      } finally {
        setState(() => _loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.sizeOf(context).width;

    return Container(
      width: deviceWidth,
      color: Colors.white,
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          spacing: 18,
          children: [
            const Text(
              "Sign Up Page",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Full Name",
                border: OutlineInputBorder(),
              ),
              validator: (value) => value!.isEmpty ? 'Name required' : null,
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) => value!.isEmpty ? 'Email required' : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
              validator:
                  (value) => value!.length < 6 ? 'Minimum 6 characters' : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Confirm Password",
                border: OutlineInputBorder(),
              ),
              validator:
                  (value) =>
                      value != _passwordController.text
                          ? 'Passwords do not match'
                          : null,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _loading ? null : _signupUser,
                child:
                    _loading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Sign Up"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
=======
import "package:flutter/material.dart";

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(children: [Text("Signup Page")]);
  }
}
>>>>>>> 78b52a0a59815ff3ac582bbf224dbd500ff838c3
