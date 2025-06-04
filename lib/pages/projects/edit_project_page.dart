import 'package:complimentsjar/api/projects_service.dart';
import 'package:complimentsjar/pages/main_layout.dart';
import 'package:complimentsjar/widgets/custom_dropdown.dart';
import 'package:flutter/material.dart';

class EditProjectPage extends StatefulWidget {
  const EditProjectPage({super.key});

  @override
  State<EditProjectPage> createState() => _EditProjectPageState();
}

class _EditProjectPageState extends State<EditProjectPage> {
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _statusController;
  late TextEditingController _userIdController;

  Map<String, dynamic>? project;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    project ??=
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    _nameController = TextEditingController(text: project!['name']);
    _descriptionController = TextEditingController(
      text: project!['description'],
    );
    _statusController = TextEditingController(text: project!['status']);
_userIdController = TextEditingController(text: project!['user_id'].toString());
  }

  void _editProject() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _loading = true);

      final result = await ProjectsService.editProject(
        _nameController.text,
        _descriptionController.text,
        _statusController.text,
        _userIdController.text,
        project!['id'],
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result), behavior: SnackBarBehavior.floating),
      );

      setState(() => _loading = false);
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
                "Edit Project",
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
              TextFormField(
                controller: _userIdController,
                decoration: const InputDecoration(
                  labelText: "User Id",
                  border: OutlineInputBorder(),
                ),
                validator: null,
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
                  onPressed: _loading ? null : _editProject,
                  child:
                      _loading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("Edit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
