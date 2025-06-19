import 'package:complimentsjar/api/projects_service.dart';
import 'package:complimentsjar/pages/main_layout.dart';
import 'package:flutter/material.dart';

class DebuggerProjectPage extends StatefulWidget {
  const DebuggerProjectPage({super.key});

  @override
  State<DebuggerProjectPage> createState() => _DebuggerProjectPageState();
}

class _DebuggerProjectPageState extends State<DebuggerProjectPage> {
  List<Map<String, dynamic>> _projects = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _getProjects();
  }

  Future<void> _getProjects() async {
    setState(() => _loading = true);

    final response = await ProjectsService.getProjects();

    if (response is String) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(response)));
    } else if (response is Map<String, dynamic> &&
        response.containsKey('projects') &&
        response['projects'] is List) {
      setState(() {
        _projects = List<Map<String, dynamic>>.from(response['projects']);
      });
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to load projects')));
    }

    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Container(
        padding: const EdgeInsets.all(4),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Project Page',
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            //card
            const SizedBox(height: 6),
            _loading
                ? const CircularProgressIndicator()
                : Expanded(
                  child: ListView.builder(
                    itemCount: _projects.length,
                    itemBuilder: (BuildContext context, int index) {
                      final project = _projects[index];
                      return Card(
                        color: Colors.blue.shade600,
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 4,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/debugger-project-details',
                                        arguments: project,
                                      );
                                    },
                                    child: Text(
                                      project['name'] ?? '',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                color: Colors.white,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                child: Text("Status: ${project['status']}",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                project['description'] ??
                                    "No description available",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
