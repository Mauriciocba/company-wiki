import 'package:company_wiki/features/create_company/model/company_model.dart';

abstract class CompanyEvent {}

class LoadCompanies extends CompanyEvent {
  final String provinceId;

  LoadCompanies(this.provinceId);
}

class AddCompany extends CompanyEvent {
 CompanyModel companyModel;
  AddCompany(this.companyModel);
}