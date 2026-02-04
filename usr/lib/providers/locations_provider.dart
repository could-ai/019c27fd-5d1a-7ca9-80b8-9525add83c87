import 'package:flutter/material.dart';
import '../models/location.dart';
import '../services/api_service.dart';

class LocationsProvider with ChangeNotifier {
  List<Location> _locations = [];
  bool _isLoading = false;

  List<Location> get locations => _locations;
  bool get isLoading => _isLoading;

  Future<void> loadLocations() async {
    _isLoading = true;
    notifyListeners();

    try {
      final data = await ApiService().getLocations();
      _locations = data.map((json) => Location.fromJson(json)).toList();
    } catch (e) {
      print('Error loading locations: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addLocation(Location location) async {
    try {
      await ApiService().createLocation(location.toJson());
      _locations.add(location);
      notifyListeners();
    } catch (e) {
      print('Error adding location: $e');
    }
  }
}