import 'package:complimentsjar/pages/main_layout.dart';
import 'package:complimentsjar/pages/projects/bugs/bugs_page.dart';
import 'package:flutter/material.dart';

class ProjectDetailsPage extends StatelessWidget {
  const ProjectDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final project =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return MainLayout(
      child: Column(
        children: [
          Text(project['name'] ?? " "),
          Text(project['description'] ?? " "),
          Container(height: 2,margin: EdgeInsets.symmetric(vertical: 12 ,horizontal: 0),color: Colors.blue.shade900,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6,vertical: 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Bugs'),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Register Bug'),
                    ),
                  ],
                ),
                BugsPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
