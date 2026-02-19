class ContactModel {
  final String id;
  final String name;
  final String phone;
  final String relation;
  final bool isPrimary;

  ContactModel({
    required this.id,
    required this.name,
    required this.phone,
    this.relation = '',
    this.isPrimary = false,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'phone': phone,
        'relation': relation,
        'isPrimary': isPrimary,
      };

  factory ContactModel.fromMap(Map<String, dynamic> map) => ContactModel(
        id: map['id'] ?? '',
        name: map['name'] ?? '',
        phone: map['phone'] ?? '',
        relation: map['relation'] ?? '',
        isPrimary: map['isPrimary'] ?? false,
      );
}
