class SOSEventModel {
  final String id;
  final String userId;
  final double latitude;
  final double longitude;
  final String address;
  final DateTime startTime;
  final DateTime? endTime;
  final bool isActive;
  final List<String> notifiedContacts;
  final List<String> evidenceUrls;

  SOSEventModel({
    required this.id,
    required this.userId,
    required this.latitude,
    required this.longitude,
    this.address = '',
    required this.startTime,
    this.endTime,
    this.isActive = true,
    this.notifiedContacts = const [],
    this.evidenceUrls = const [],
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'userId': userId,
        'latitude': latitude,
        'longitude': longitude,
        'address': address,
        'startTime': startTime.toIso8601String(),
        'endTime': endTime?.toIso8601String(),
        'isActive': isActive,
        'notifiedContacts': notifiedContacts,
        'evidenceUrls': evidenceUrls,
      };
}
