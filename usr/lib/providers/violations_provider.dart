import 'package:flutter/material.dart';
import '../models/violation.dart';
import '../services/api_service.dart';

class ViolationsProvider with ChangeNotifier {
  List<Violation> _violations = [];
  bool _isLoading = false;

  List<Violation> get violations => _violations;
  bool get isLoading => _isLoading;

  Future<void> loadViolations() async {
    _isLoading = true;
    notifyListeners();

    try {
      final data = await ApiService().getViolations();
      _violations = data.map((json) => Violation.fromJson(json)).toList();
    } catch (e) {
      // Handle error
      print('Error loading violations: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> reportViolation(Violation violation) async {
    try {
      await ApiService().reportViolation(violation.toJson());
      _violations.add(violation);
      notifyListeners();
    } catch (e) {
      print('Error reporting violation: $e');
    }
  }
}