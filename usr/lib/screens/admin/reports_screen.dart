import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/violations_provider.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  @override
  void initState() {
    super.initState();
    final violationsProvider = Provider.of<ViolationsProvider>(context, listen: false);
    violationsProvider.loadViolations();
  }

  @override
  Widget build(BuildContext context) {
    final violationsProvider = Provider.of<ViolationsProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Violation Reports')),
      body: violationsProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: violationsProvider.violations.length,
              itemBuilder: (context, index) {
                final violation = violationsProvider.violations[index];
                return Card(
                  child: ListTile(
                    title: Text('Plate: ${violation.plateNumber}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Location: ${violation.locationId}'),
                        Text('Status: ${violation.status}'),
                        Text('Date: ${violation.createdAt.toString().split(' ')[0]}'),
                        if (violation.description != null)
                          Text('Description: ${violation.description}'),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}