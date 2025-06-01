import 'package:complimentsjar/api/projects_service.dart';
import 'package:complimentsjar/pages/main_layout.dart';
import 'package:flutter/material.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({super.key});

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
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
                ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll<Color>(
                      Colors.green,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/create-project');
                  },
                  child: const Text(
                    "Create Project",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
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
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/project-details',arguments: project);
                                },
                                child: Text(
                                project['name'] ?? '',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                )
                              ),
                              const SizedBox(height: 4),
                              Text(
                                project['description'] ?? '',
                                style: TextStyle(color: Colors.white),
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
