import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'employee/report_violation_screen.dart';
import 'employee/audit_plate_screen.dart';

class EmployeeHomeScreen extends StatelessWidget {
  const EmployeeHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authProvider.logout();
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.report_problem),
                title: const Text('Report Violation'),
                subtitle: const Text('Upload photo and report parking violations'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ReportViolationScreen()),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const Icon(Icons.search),
                title: const Text('Audit Plate'),
                subtitle: const Text('Check active payment sessions for plates'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AuditPlateScreen()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}