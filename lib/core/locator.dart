import 'package:get_it/get_it.dart';
import 'package:company_wiki/features/provinces/ui/bloc/province_bloc.dart';
import 'package:company_wiki/features/companies/ui/bloc/company_bloc.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerFactory(() => ProvinceBloc());
  getIt.registerFactory(() => CompanyBloc());
}
