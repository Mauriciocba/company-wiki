abstract class CompanyEvent {}

class LoadCompanies extends CompanyEvent {
  final String provinceId;

  LoadCompanies(this.provinceId);
}
