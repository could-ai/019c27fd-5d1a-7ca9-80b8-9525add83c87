import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';
import 'screens/employee/employee_home.dart';
import 'screens/admin/admin_home.dart';
import 'providers/auth_provider.dart';
import 'providers/violations_provider.dart';
import 'providers/locations_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ViolationsProvider()),
        ChangeNotifierProvider(create: (_) => LocationsProvider()),
      ],
      child: const ParklyyApp(),
    ),
  );
}

class ParklyyApp extends StatelessWidget {
  const ParklyyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parklyy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/employee_home': (context) => const EmployeeHomeScreen(),
        '/admin_home': (context) => const AdminHomeScreen(),
      },
    );
  }
}