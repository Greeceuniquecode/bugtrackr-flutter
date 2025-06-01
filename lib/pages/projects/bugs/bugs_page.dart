import 'package:complimentsjar/api/bugs_service.dart';
import 'package:flutter/material.dart';

class BugsPage extends StatefulWidget {
  const BugsPage({super.key});

  @override
  State<BugsPage> createState() => _BugsPageState();
}

class _BugsPageState extends State<BugsPage> {
  List<Map<String, dynamic>> _bugs = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _getBugs();
  }

  Future<void> _getBugs() async {
    setState(() => _loading = true);

    final response = await BugsService.getBugs();

    if (response is String) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(response)));
    } else if (response is Map<String, dynamic> &&
        response.containsKey('bugs') &&
        response['bugs'] is List) {
      setState(() {
        _bugs = List<Map<String, dynamic>>.from(response['bugs']);
      });
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('FAILED TO LOAD BUGS')));
    }

    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
          child: Column(
            children:
                _bugs.map((bug) {
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
                              Navigator.pushNamed(
                                context,
                                '/bug-details',
                                arguments: bug,
                              );
                            },
                            child: Text(
                              bug['title'] ?? '',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            bug['code'] ?? '',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
          ),
        );
  }
}
