import "package:complimentsjar/pages/main_layout.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";

class DebuggedCodePage extends StatelessWidget {
  const DebuggedCodePage({super.key});

  void _copyToClipboard(BuildContext context, String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$label copied to clipboard'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bug =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return MainLayout(
      child: SingleChildScrollView(
        child: Card(
          elevation: 2,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.code, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 8),
                    Text(
                      'Debugged Code:',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap:
                          () => _copyToClipboard(
                            context,
                            bug['new_code']?.toString() ?? '',
                            'Debugged code',
                          ),
                      child: Icon(
                        Icons.copy,
                        size: 16,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: SelectableText(
                    bug['new_code']?.toString() ?? 'N/A',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Row(
                      spacing: 12,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back),
                            label: const Text('Back to List'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),

                        Expanded(
                          child: OutlinedButton.icon(
                            label: Text('Reject', style: TextStyle(color: Colors.white),),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.red.shade800,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/check-debugged-code',
                                arguments: bug,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
