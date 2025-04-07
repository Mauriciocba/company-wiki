import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'company_event.dart';
import 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  CompanyBloc() : super(CompanyInitial()) {
    on<LoadCompanies>(_onLoadCompanies);
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
}
