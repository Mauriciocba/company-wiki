abstract class ProvinceState {}

class ProvinceInitial extends ProvinceState {}

class ProvinceLoading extends ProvinceState {}

class ProvinceSuccess extends ProvinceState {
  final List<Map<String, dynamic>> provinces;

  ProvinceSuccess(this.provinces);
}

class ProvinceError extends ProvinceState {
  final String message;

  ProvinceError(this.message);
}
