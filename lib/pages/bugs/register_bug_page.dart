import 'package:complimentsjar/api/bugs_service.dart';
import 'package:complimentsjar/pages/main_layout.dart';
import 'package:complimentsjar/widgets/custom_dropdown.dart';
import 'package:flutter/material.dart';
class RegisterBugPage extends StatefulWidget{
  const RegisterBugPage({super.key});

    @override
  State<RegisterBugPage> createState() => _RegisterBugPageState();
}

class _RegisterBugPageState extends State<RegisterBugPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _codeController = TextEditingController();
  final _userIdController = TextEditingController();
  final _statusController =TextEditingController();
  final _projectIdController = TextEditingController();
  bool _loading = false;

void _registerBug() async {
  final project = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

  if (_formKey.currentState!.validate()) {
    setState(() => _loading = true);
    final result = await BugsService.registerBug(
      _titleController.text,
      _codeController.text,
      _descriptionController.text,
      _userIdController.text,
      project['id'].toString(),
      _statusController.text,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result.toString()), behavior: SnackBarBehavior.floating),
    );

    setState(() => _loading = false);

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushNamed(context, '/projects');
    });
  }
}

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.sizeOf(context).width;
        List<String> statusOptions = ['Active', 'Pending', 'Completed'];

    return MainLayout(
      child: Container(
        width: deviceWidth,
        color: Colors.white,
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 6,
            children: [
              const Text(
                "Register Bug Page",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Title required' : null,
              ),
              TextFormField(
                controller: _codeController,
                decoration: const InputDecoration(
                  labelText: "Code",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value!.isEmpty ? 'Code required' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                ),
              ),
                            InputDecorator(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 4,
                  ),
                  labelText: 'Status',
                ),
                child: CustomDropdown(
                  values: statusOptions,
                  onSelected: (String value) {
                    setState(() {
                      _statusController.text = value;
                    });
                  },
                  color: Colors.grey.shade700,
                  backgroundColor: Colors.grey.shade100,
                  textStyle: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 17,
                  ),
                ),
              ),
              TextFormField(
                controller: _userIdController,
                decoration: const InputDecoration(
                  labelText: "User Id",
                  border: OutlineInputBorder(),
                ),
              ),
              //               TextFormField(
              //   controller: _projectIdController,
              //   decoration: const InputDecoration(
              //     labelText: "Project Id",
              //     border: OutlineInputBorder(),
              //   ),
              // ),
              const SizedBox(height: 6),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _loading ? null : _registerBug,
                  child:
                      _loading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("Register"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}