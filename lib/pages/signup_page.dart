import 'dart:io';
import 'package:complimentsjar/api/auth_service.dart';
import 'package:complimentsjar/pages/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  final _addressController = TextEditingController();
  final _dobController = TextEditingController();
  String responseResult = "";

  String? _selectedGender;
  // XFile? _selectedImage;

  bool _loading = false;

  final List<String> _genderOptions = ['Male', 'Female', 'Other'];

  // Future<void> _pickImage() async {
  //   final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (picked != null) {
  //     setState(() => _selectedImage = picked);
  //   }
  // }

  Future<void> _signupUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _loading = true);

      try {
        final result = await AuthService.signup(
          _nameController.text,
          _emailController.text,
          _passwordController.text,
          _addressController.text,
          _dobController.text,
          _selectedGender!,
        );

        setState(() => responseResult = result);

        if (result == 'Signed up successfully!') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pushNamed(context, '/login');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        setState(() => _loading = false);
      }
    }
  }

  // Date format validator
  String? _validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'DOB required';
    }
    // Validate date format (YYYY-MM-DD)
    final regex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
    if (!regex.hasMatch(value)) {
      return 'Enter date in YYYY-MM-DD format';
    }
    try {
      DateTime.parse(value);
      return null;
    } catch (e) {
      return 'Invalid date';
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.sizeOf(context).width;

    return MainLayout(
      child: SingleChildScrollView(
        child: Container(
          width: deviceWidth,
          color: Colors.white,
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 20),

                // Image Picker
                // Center(
                //   child: GestureDetector(
                //     onTap: _pickImage,
                //     child: CircleAvatar(
                //       radius: 50,
                //       backgroundImage: _selectedImage != null
                //           ? FileImage(File(_selectedImage!.path))
                //           : null,
                //       child: _selectedImage == null
                //           ? const Icon(Icons.camera_alt, size: 40)
                //           : null,
                //     ),
                //   ),
                // ),

                const SizedBox(height: 20),

                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: "Full Name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Name required' : null,
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email required';
                    }
                    // Basic email format validation
                    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!regex.hasMatch(value)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      (value?.length ?? 0) < 6 ? 'Minimum 6 characters' : null,
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    labelText: "Address",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Address required' : null,
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller: _dobController,
                  decoration: const InputDecoration(
                    labelText: "Date of Birth (YYYY-MM-DD)",
                    border: OutlineInputBorder(),
                  ),
                  validator: _validateDate,
                ),
                const SizedBox(height: 12),

                // Gender Dropdown
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: "Gender",
                    border: OutlineInputBorder(),
                  ),
                  value: _selectedGender,
                  items: _genderOptions.map((String gender) {
                    return DropdownMenuItem<String>(
                      value: gender,
                      child: Text(gender),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedGender = newValue;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Please select a gender' : null,
                ),
                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _loading ? null : _signupUser,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: _loading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text("Sign Up"),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _addressController.dispose();
    _dobController.dispose();
    super.dispose();
  }
}