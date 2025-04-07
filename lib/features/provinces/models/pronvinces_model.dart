class ProvincesModel {
  final String id;
  final String name;

  ProvincesModel({required this.id, required this.name});

  factory ProvincesModel.fromFirestore(String id, Map<String, dynamic> data) {
    return ProvincesModel(
      id: id,
      name: data['name'] ?? '',
    );
  }
}
