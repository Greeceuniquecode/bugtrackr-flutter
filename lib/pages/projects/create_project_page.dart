import 'package:complimentsjar/api/projects_service.dart';
import 'package:complimentsjar/pages/main_layout.dart';
import 'package:complimentsjar/widgets/custom_dropdown.dart';
import 'package:flutter/material.dart';

class CreateProjectPage extends StatefulWidget {
  const CreateProjectPage({super.key});

  @override
  State<CreateProjectPage> createState() => _CreateProjectPageState();
}

class _CreateProjectPageState extends State<CreateProjectPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _statusController = TextEditingController();
  bool _loading = false;

  void _createProject() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _loading = true);
      final result = await ProjectsService.createProject(
        _nameController.text,
        _descriptionController.text,
        _statusController.text,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result), behavior: SnackBarBehavior.floating),
      );

      setState(() => _loading = false);

      // If signup is successful, navigate to login
      if (result.toLowerCase().contains('success')) {
        Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.pushNamed(context, '/reporter-projects');
        });
      }
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
            spacing: 12,
            children: [
              const Text(
                "Create Project",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Name required' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
                validator:
                    (value) => value!.isEmpty ? 'Description required' : null,
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
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _loading ? null : _createProject,
                  child:
                      _loading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("Create"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
