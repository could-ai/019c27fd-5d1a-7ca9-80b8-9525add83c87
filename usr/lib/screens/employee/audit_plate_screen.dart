import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/api_service.dart';

class AuditPlateScreen extends StatefulWidget {
  const AuditPlateScreen({super.key});

  @override
  State<AuditPlateScreen> createState() => _AuditPlateScreenState();
}

class _AuditPlateScreenState extends State<AuditPlateScreen> {
  final _plateController = TextEditingController();
  final _locationController = TextEditingController();
  Map<String, dynamic>? _auditResult;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Audit Plate')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _plateController,
              decoration: const InputDecoration(
                labelText: 'License Plate Number',
                hintText: 'Enter plate number to audit',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(
                labelText: 'Location ID',
                hintText: 'Enter location identifier',
              ),
            ),
            const SizedBox(height: 32),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: _auditPlate,
                    child: const Text('Audit Plate'),
                  ),
            if (_auditResult != null) ...[
              const SizedBox(height: 32),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Audit Result:', style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 8),
                      Text('Plate: ${_auditResult!['plate']}'),
                      Text('Location: ${_auditResult!['location']}'),
                      Text('Status: ${_auditResult!['status']}'),
                      if (_auditResult!['session'] != null) ...[
                        const SizedBox(height: 8),
                        Text('Active Session: Yes'),
                        Text('Start Time: ${_auditResult!['session']['start_time']}'),
                        Text('End Time: ${_auditResult!['session']['end_time']}'),
                      ] else ...[
                        const SizedBox(height: 8),
                        const Text('Active Session: No'),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _auditPlate() async {
    if (_plateController.text.isEmpty || _locationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both plate number and location')),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      final result = await ApiService().auditPlate(
        _plateController.text,
        _locationController.text,
      );
      setState(() => _auditResult = result);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Audit failed: $e')),
      );
    }
    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    _plateController.dispose();
    _locationController.dispose();
    super.dispose();
  }
}