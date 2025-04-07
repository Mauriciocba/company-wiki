class CompanyModel {
  final String? id;
  final String name;
  final String description;
  final String? linkedin;
  final String? website;
  final String provinceId; 

  CompanyModel({
    required this.id,
    required this.name,
    required this.description,
    required this.provinceId,
    this.linkedin,
    this.website,
  });

  // Constructor desde Firebase
  factory CompanyModel.fromMap(Map<String, dynamic> map, String id) {
    return CompanyModel(
      id: map['name'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      provinceId: map['provinceId'] ?? '', 
      linkedin: map['linkedin'],
      website: map['website'],
    );
  }

  // Para enviar a Firebase
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'provinceId': provinceId,
      if (linkedin != null) 'linkedin': linkedin,
      if (website != null) 'website': website,
    };
  }
}
