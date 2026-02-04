import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://parkly-api.vercel.app';

  // Mock authentication for now
  Future<Map<String, dynamic>> login(String email, String password) async {
    // TODO: Replace with actual backend authentication when Supabase is connected
    // For now, simulate login based on email
    if (email.contains('admin')) {
      return {'user': {'id': '1', 'name': 'Admin User', 'email': email, 'role': 'admin'}};
    } else {
      return {'user': {'id': '2', 'name': 'Employee User', 'email': email, 'role': 'employee'}};
    }
  }

  // Violation operations
  Future<List<dynamic>> getViolations() async {
    final response = await http.get(Uri.parse('$baseUrl/violations'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load violations');
    }
  }

  Future<void> reportViolation(Map<String, dynamic> violationData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/violations'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(violationData),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to report violation');
    }
  }

  // Location operations
  Future<List<dynamic>> getLocations() async {
    final response = await http.get(Uri.parse('$baseUrl/locations'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load locations');
    }
  }

  Future<void> createLocation(Map<String, dynamic> locationData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/locations'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(locationData),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create location');
    }
  }

  // Plate audit
  Future<Map<String, dynamic>> auditPlate(String plateNumber, String locationId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/audit?plate=$plateNumber&location=$locationId'),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to audit plate');
    }
  }
}