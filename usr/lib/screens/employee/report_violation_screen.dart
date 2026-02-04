import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import '../../models/violation.dart';
import '../../providers/violations_provider.dart';
import '../../providers/locations_provider.dart';

class ReportViolationScreen extends StatefulWidget {
  const ReportViolationScreen({super.key});

  @override
  State<ReportViolationScreen> createState() => _ReportViolationScreenState();
}

class _ReportViolationScreenState extends State<ReportViolationScreen> {
  File? _image;
  final _plateController = TextEditingController();
  String? _selectedLocationId;
  final _descriptionController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final locationsProvider = Provider.of<LocationsProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Report Violation')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.camera_alt),
              label: const Text('Take Photo'),
            ),
            if (_image != null) ...[
              const SizedBox(height: 16),
              Image.file(_image!, height: 200),
            ],
            const SizedBox(height: 16),
            TextField(
              controller: _plateController,
              decoration: const InputDecoration(
                labelText: 'License Plate Number',
                hintText: 'Auto-detected or enter manually',
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedLocationId,
              decoration: const InputDecoration(labelText: 'Location'),
              items: locationsProvider.locations.map((location) {
                return DropdownMenuItem(
                  value: location.id,
                  child: Text(location.name),
                );
              }).toList(),
              onChanged: (value) => setState(() => _selectedLocationId = value),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description (Optional)',
                hintText: 'Additional details about the violation',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 32),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: _submitViolation,
                    child: const Text('Submit Violation'),
                  ),
          ],
        ),
      ),
    );
  }

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() => _image = File(pickedFile.path));
      // TODO: Send image to backend for OCR to auto-fill plate number
    }
  }

  void _submitViolation() async {
    if (_plateController.text.isEmpty || _selectedLocationId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in plate number and location')),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      final violation = Violation(
        id: DateTime.now().millisecondsSinceEpoch.toString(), // Temporary ID
        plateNumber: _plateController.text,
        locationId: _selectedLocationId!,
        createdAt: DateTime.now(),
        status: 'Pending',
        description: _descriptionController.text.isEmpty ? null : _descriptionController.text,
        // TODO: Upload image and get URL
      );

      final violationsProvider = Provider.of<ViolationsProvider>(context, listen: false);
      await violationsProvider.reportViolation(violation);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Violation reported successfully')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to report violation: $e')),
      );
    }
    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    _plateController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}