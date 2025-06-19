import 'package:complimentsjar/api/bugs_service.dart';
import 'package:complimentsjar/pages/main_layout.dart';
import 'package:flutter/material.dart';

class BugSubmissionPage extends StatefulWidget {
  const BugSubmissionPage({super.key});

  @override
  State<BugSubmissionPage> createState() => _BugSubmissionPageState();
}

class _BugSubmissionPageState extends State<BugSubmissionPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;
  String? _submitMessage;
  bool _isSuccess = false;

  late TextEditingController _codeController;
  Map<String, dynamic>? bug;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (bug == null) {
      bug = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      _codeController = TextEditingController();
    }
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _submitBug() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
      _submitMessage = null;
    });

    try {
      final bugId = bug!['id'] as int;
      
      final result = await BugsService.submitBug(
        _codeController.text.trim(),
        bugId,
      );

      setState(() {
        _isSubmitting = false;
        _submitMessage = result;
        _isSuccess = result.contains('successfully');
      });

      if (_isSuccess) {
        // Clear form on success
        _codeController.clear();
        
        // Show success snackbar
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 3),
            ),
          );
        }
        Navigator.pushNamed(context, '/debugger-bug-details', arguments: bug);
      }
    } catch (e) {
      setState(() {
        _isSubmitting = false;
        _submitMessage = 'Error: $e';
        _isSuccess = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'Submit Bug Fix',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              
              // Bug Info
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bug ID: ${bug?['id'] ?? 'N/A'}',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    if (bug?['title'] != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        'Title: ${bug!['title']}',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                    if (bug?['description'] != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        'Description: ${bug!['description']}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Original Code Section (if available)
              if (bug?['original_code'] != null) ...[
                Text(
                  'Original Code:',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  constraints: const BoxConstraints(maxHeight: 200),
                  child: SingleChildScrollView(
                    child: Text(
                      bug!['code'],
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],

              // Code Input Section
              Text(
                'Your Fixed Code:',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              
              Expanded(
                child: TextFormField(
                  controller: _codeController,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    hintText: 'Paste your debugged code here...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.all(12),
                  ),
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 14,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter the fixed code';
                    }
                    if (value.trim().length < 10) {
                      return 'Code must be at least 10 characters long';
                    }
                    if (value.trim().length > 10000) {
                      return 'Code must not exceed 10,000 characters';
                    }
                    return null;
                  },
                ),
              ),
              
              const SizedBox(height: 16),

              // Character Counter
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '${_codeController.text.length}/10000',
                  style: TextStyle(
                    color: _codeController.text.length > 10000 
                        ? Colors.red 
                        : Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ),
              
              const SizedBox(height: 16),

              // Submit Message
              if (_submitMessage != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: _isSuccess ? Colors.green[50] : Colors.red[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _isSuccess ? Colors.green[300]! : Colors.red[300]!,
                    ),
                  ),
                  child: Text(
                    _submitMessage!,
                    style: TextStyle(
                      color: _isSuccess ? Colors.green[700] : Colors.red[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitBug,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: _isSubmitting
                      ? const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ),
                            SizedBox(width: 12),
                            Text('Submitting...'),
                          ],
                        )
                      : const Text(
                          'Submit Fixed Code',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}