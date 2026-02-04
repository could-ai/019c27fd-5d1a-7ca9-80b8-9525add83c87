import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'admin/manage_locations_screen.dart';
import 'admin/manage_users_screen.dart';
import 'admin/reports_screen.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
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
                leading: const Icon(Icons.location_on),
                title: const Text('Manage Locations'),
                subtitle: const Text('Add, edit, and manage parking locations'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ManageLocationsScreen()),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const Icon(Icons.people),
                title: const Text('Manage Users'),
                subtitle: const Text('Manage employees and admin accounts'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ManageUsersScreen()),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const Icon(Icons.report),
                title: const Text('View Reports'),
                subtitle: const Text('View violation reports and analytics'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ReportsScreen()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}