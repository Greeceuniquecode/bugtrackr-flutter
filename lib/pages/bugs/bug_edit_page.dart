import 'package:complimentsjar/api/bugs_service.dart';
import 'package:complimentsjar/pages/main_layout.dart';
import 'package:complimentsjar/widgets/custom_dropdown.dart';
import 'package:flutter/material.dart';

class BugEditPage extends StatefulWidget {
  const BugEditPage({super.key});

  @override
  State<BugEditPage> createState() => _BugEditPageState();
}

class _BugEditPageState extends State<BugEditPage> {
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  late TextEditingController _titleController = TextEditingController();
  late TextEditingController _codeController = TextEditingController();
  late TextEditingController _descriptionController = TextEditingController();
  late TextEditingController _statusController = TextEditingController();
  late TextEditingController _userIdController = TextEditingController();
  late TextEditingController _projectIdController = TextEditingController();

  Map<String, dynamic>? bug;
  Key? dropdownKey;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments;
    if (bug == null && args != null && args is Map<String, dynamic>) {
      bug = args;

      _titleController = TextEditingController(text: bug!['title']);
      _codeController = TextEditingController(text: bug!['code']);
      _descriptionController = TextEditingController(text: bug!['description']);
      _statusController = TextEditingController(text: bug!['status']);
      _userIdController = TextEditingController(
        text: bug!['user_id'].toString(),
      );
      _projectIdController = TextEditingController(
        text: bug!['project_id'].toString(),
      );

      dropdownKey = ValueKey(bug!['status']);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _codeController.dispose();
    _descriptionController.dispose();
    _statusController.dispose();
    _userIdController.dispose();
    _projectIdController.dispose();
    super.dispose();
  }

  void _editBug() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _loading = true);

      final result = await BugsService.editBug(
        _titleController.text,
        _codeController.text,
        _descriptionController.text,
        _statusController.text,
        bug!['user_id'],
        bug!['project_id'],
        bug!['id'],
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Edit Bug",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: "Bug Title",
                  border: OutlineInputBorder(),
                ),
                validator:
                    (value) => value!.isEmpty ? 'Bug title required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _codeController,
                decoration: const InputDecoration(
                  labelText: "Code",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
                validator: (value) => value!.isEmpty ? 'Code required' : null,
              ),
              const SizedBox(height: 12),
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
              const SizedBox(height: 12),
              InputDecorator(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 4,
                  ),
                  labelText: 'Status',
                ),
                child: CustomDropdown(
                  key: dropdownKey, // force rebuild with initial value
                  values: statusOptions,
                  onSelected: (String value) {
                    setState(() {
                      _statusController.text =
                          value; // update controller text on selection
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
                  onPressed: _loading ? null : _editBug,
                  child:
                      _loading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("Edit Bug"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
