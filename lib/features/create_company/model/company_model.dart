class CompanyModel {
  final String? id;
  final String name;
  final String description;
  final String? linkedin;
  final String? website;
  final String provinceId; 

  CompanyModel({
    this.id,
    required this.name,
    required this.description,
    required this.provinceId,
    this.linkedin,
    this.website,
  });

  // Constructor desde Firebase
  factory CompanyModel.fromMap(Map<String, dynamic> map, String id) {
    return CompanyModel(
      id: id,
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
      'name': name,
      'description': description,
      'provinceId': provinceId,
      if (linkedin != null) 'linkedin': linkedin,
      if (website != null) 'website': website,
    };
  }

  CompanyModel copyWith({
    String? id,
    String? name,
    String? description,
    String? linkedin,
    String? website,
    String? provinceId,
  }) {
    return CompanyModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      provinceId: provinceId ?? this.provinceId,
      linkedin: linkedin ?? this.linkedin,
      website: website ?? this.website,
    );
  }
}
