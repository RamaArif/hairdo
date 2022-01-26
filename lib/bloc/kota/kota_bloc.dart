import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:omahdilit/Api/api_provider.dart';
import 'package:omahdilit/model/listkota.dart';

part 'kota_event.dart';
part 'kota_state.dart';

class KotaBloc extends Bloc<KotaEvent, KotaState> {
  KotaBloc() : super(KotaInitial()) {

    final ApiProvider _apiProvider = ApiProvider();
    
    on<GetKota>((event, emit) async {
      try {
        emit(KotaLoading());
        final listKota = await _apiProvider.fetchKota(event.provinsi);
        print("Mitra" + jsonEncode(listKota));
        emit(KotaLoaded(listKota));
      } on KotaError {
        emit(KotaError("Gagal memuat data, cek internet kamu "));
      }
    });
  }
}
