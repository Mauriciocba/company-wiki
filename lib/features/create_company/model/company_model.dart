class CompanyModel {
  final String? id;
  final String name;
  final String description;
  final String? linkedin;
  final String? website;
  final String provinceId;
  final String? logoUrl;
  final int? employees; 

  CompanyModel({
    this.id,
    required this.name,
    required this.description,
    required this.provinceId,
    this.linkedin,
    this.website,
    this.logoUrl,
    this.employees,
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
      logoUrl: map['logo'] ?? '',
      employees: map['employees'] != null ? int.tryParse(map['employees'].toString()) : null,
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
      if (logoUrl != null) 'logo': logoUrl,
      if (employees != null) 'employees': employees.toString(),
    };
  }

  CompanyModel copyWith({
    String? id,
    String? name,
    String? description,
    String? linkedin,
    String? website,
    String? provinceId,
    String? logoUrl,
    int? employees,
  }) {
    return CompanyModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      provinceId: provinceId ?? this.provinceId,
      linkedin: linkedin ?? this.linkedin,
      website: website ?? this.website,
      logoUrl: logoUrl ?? this.logoUrl,
      employees: employees ?? this.employees,
    );
  }
}
