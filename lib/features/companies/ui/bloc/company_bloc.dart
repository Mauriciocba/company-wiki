import 'package:company_wiki/features/create_company/model/company_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'company_event.dart';
import 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  CompanyBloc() : super(CompanyInitial()) {
    on<LoadCompanies>(_onLoadCompanies);
    on<AddCompany>(_onAddCompany);
  }

  Future<void> _onLoadCompanies(
      LoadCompanies event, Emitter<CompanyState> emit) async {
    emit(CompanyLoading());

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('provinces')
          .doc(event.provinceId)
          .collection('companies')
          .get();

      final companies = snapshot.docs
          .map((doc) => {'id': doc.id, ...doc.data()})
          .toList();

      emit(CompanySuccess(companies));
    } catch (e) {
      emit(CompanyError('Error cargando las empresas'));
    }
  }

  Future<void> _onAddCompany(
    AddCompany event, Emitter<CompanyState> emit) async {
  try {
    final company = CompanyModel(
      id: event.companyModel.name,
      name: event.companyModel.name,
      description: event.companyModel.description,
      provinceId: event.companyModel.provinceId,
      website: event.companyModel.website,
      linkedin: event.companyModel.linkedin,
    );

    
    await FirebaseFirestore.instance
        .collection('provinces')
        .doc(event.companyModel.provinceId)  
        .collection('companies') 
        .doc(company.id)  
        .set(company.toMap());

    emit(CreateCompanySuccess()); 
  } catch (e) {
    emit(CompanyError('Error al agregar la empresa: $e'));
  }
}

}
