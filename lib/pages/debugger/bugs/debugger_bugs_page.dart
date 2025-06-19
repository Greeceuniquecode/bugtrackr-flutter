import 'package:complimentsjar/api/bugs_service.dart';
import 'package:flutter/material.dart';

class DebuggerBugsPage extends StatefulWidget {
  final dynamic id;

  const DebuggerBugsPage(this.id, {super.key});

  @override
  State<DebuggerBugsPage> createState() => _DebuggerBugsPageState();
}

class _DebuggerBugsPageState extends State<DebuggerBugsPage> {
  List<Map<String, dynamic>> _bugs = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _getBugs();
  }

  Future<void> _getBugs() async {
    setState(() => _loading = true);

    final response = await BugsService.getBugs(widget.id);

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

  String _formatDate(dynamic dateValue) {
    if (dateValue == null) return 'No date';
    
    try {
      DateTime date;
      if (dateValue is String) {
        date = DateTime.parse(dateValue);
      } else if (dateValue is DateTime) {
        date = dateValue;
      } else {
        return 'Invalid date';
      }
      
      return '${date.day}/${date.month}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return 'Invalid date';
    }
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: _bugs.length,
            padding: const EdgeInsets.all(4.0),
            itemBuilder: (context, index) {
              final bug = _bugs[index];
              return Card(
                color: Colors.blue.shade600,
                elevation: 4,
                margin: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 4,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/debugger-bug-details',
                      arguments: bug,
                    );
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bug['title'] ?? 'No Title',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time,
                              size: 16,
                              color: Colors.white70,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              _formatDate(bug['created_at'] ?? bug['createdAt'] ?? bug['date']),
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }
}