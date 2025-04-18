abstract class CompanyState {}

class CompanyInitial extends CompanyState {}

class CompanyLoading extends CompanyState {}

class CompanySuccess extends CompanyState {
  final List<Map<String, dynamic>> companies;

  CompanySuccess(this.companies);
}

class CompanyError extends CompanyState {
  final String message;

  CompanyError(this.message);
}

class CreateCompanyLoading extends CompanyState {}

class CreateCompanySuccess extends CompanyState {}

class CreateCompanyError extends CompanyState {
  final String message;

  CreateCompanyError(this.message);
}