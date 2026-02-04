import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/location.dart';
import '../../providers/locations_provider.dart';

class ManageLocationsScreen extends StatefulWidget {
  const ManageLocationsScreen({super.key});

  @override
  State<ManageLocationsScreen> createState() => _ManageLocationsScreenState();
}

class _ManageLocationsScreenState extends State<ManageLocationsScreen> {
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _capacityController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final locationsProvider = Provider.of<LocationsProvider>(context, listen: false);
    locationsProvider.loadLocations();
  }

  @override
  Widget build(BuildContext context) {
    final locationsProvider = Provider.of<LocationsProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Manage Locations')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Location Name'),
                ),
                TextField(
                  controller: _addressController,
                  decoration: const InputDecoration(labelText: 'Address'),
                ),
                TextField(
                  controller: _capacityController,
                  decoration: const InputDecoration(labelText: 'Capacity'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _addLocation,
                        child: const Text('Add Location'),
                      ),
              ],
            ),
          ),
          Expanded(
            child: locationsProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: locationsProvider.locations.length,
                    itemBuilder: (context, index) {
                      final location = locationsProvider.locations[index];
                      return Card(
                        child: ListTile(
                          title: Text(location.name),
                          subtitle: Text('${location.address} - Capacity: ${location.capacity}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              // TODO: Implement delete functionality
                            },
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _addLocation() async {
    if (_nameController.text.isEmpty || _addressController.text.isEmpty || _capacityController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      final location = Location(
        id: DateTime.now().millisecondsSinceEpoch.toString(), // Temporary ID
        name: _nameController.text,
        address: _addressController.text,
        capacity: int.parse(_capacityController.text),
      );

      final locationsProvider = Provider.of<LocationsProvider>(context, listen: false);
      await locationsProvider.addLocation(location);

      _nameController.clear();
      _addressController.clear();
      _capacityController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location added successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add location: $e')),
      );
    }
    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _capacityController.dispose();
    super.dispose();
  }
}