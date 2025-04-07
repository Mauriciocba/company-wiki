import 'package:bloc/bloc.dart';
import 'province_event.dart';
import 'province_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProvinceBloc extends Bloc<ProvinceEvent, ProvinceState> {
  ProvinceBloc() : super(ProvinceInitial()) {
    on<LoadProvinces>(_onLoadProvinces);
  }

  Future<void> _onLoadProvinces(LoadProvinces event, Emitter<ProvinceState> emit) async {
    emit(ProvinceLoading());

    try {
      final snapshot = await FirebaseFirestore.instance.collection('provinces').get();
      final provinces = snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'name': doc['name'],
        };
      }).toList();

      emit(ProvinceSuccess(provinces));
    } catch (e) {
      emit(ProvinceError('Error al cargar provincias'));
    }
  }
}
