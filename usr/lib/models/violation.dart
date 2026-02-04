class Violation {
  final String id;
  final String plateNumber;
  final String locationId;
  final DateTime createdAt;
  final String status; // Pending, Cancelled, Escalated
  final String? imageUrl;
  final String? description;

  Violation({
    required this.id,
    required this.plateNumber,
    required this.locationId,
    required this.createdAt,
    required this.status,
    this.imageUrl,
    this.description,
  });

  factory Violation.fromJson(Map<String, dynamic> json) {
    return Violation(
      id: json['id'],
      plateNumber: json['plate_number'],
      locationId: json['location_id'],
      createdAt: DateTime.parse(json['created_at']),
      status: json['status'],
      imageUrl: json['image_url'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plate_number': plateNumber,
      'location_id': locationId,
      'created_at': createdAt.toIso8601String(),
      'status': status,
      'image_url': imageUrl,
      'description': description,
    };
  }
}