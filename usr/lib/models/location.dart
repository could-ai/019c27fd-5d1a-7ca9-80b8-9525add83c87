class Location {
  final String id;
  final String name;
  final String address;
  final double? latitude;
  final double? longitude;
  final int capacity;

  Location({
    required this.id,
    required this.name,
    required this.address,
    this.latitude,
    this.longitude,
    required this.capacity,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      capacity: json['capacity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'capacity': capacity,
    };
  }
}