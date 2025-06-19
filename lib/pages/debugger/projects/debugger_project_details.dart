import 'package:complimentsjar/pages/debugger/bugs/debugger_bugs_page.dart';
import 'package:complimentsjar/pages/main_layout.dart';
import 'package:complimentsjar/pages/bugs/bugs_page.dart';
import 'package:flutter/material.dart';

class DebuggerProjectDetails extends StatelessWidget {
  const DebuggerProjectDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final project =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return MainLayout(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      project['name'] ?? "Untitled Project",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      child: Text('Back'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                Container(
                  color: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  child: Text(project['status'], style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold))),
                const SizedBox(height: 8),
                Text(
                  project['description'] ?? "No description available",
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
          Container(
            height: 2,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            color: Colors.blue.shade900,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Bugs',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: DebuggerBugsPage(project['id']),
            ),
          ),
        ],
      ),
    );
  }
}
