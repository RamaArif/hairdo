import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:omahdilit/Api/api_provider.dart';
import 'package:omahdilit/model/listprovinsi.dart';

part 'provinsi_event.dart';
part 'provinsi_state.dart';

class ProvinsiBloc extends Bloc<ProvinsiEvent, ProvinsiState> {
  ProvinsiBloc() : super(ProvinsiInitial()) {

    final ApiProvider _apiProvider = ApiProvider();

    on<ProvinsiEvent>((event, emit) async {
      try {
        emit(ProvinsiLoading());
        final listMitra = await _apiProvider.fetchProvinsi();
        print("Mitra" + jsonEncode(listMitra));
        emit(ProvinsiLoaded(listMitra));
      } on ProvinsiError {
        emit(ProvinsiError("Gagal memuat data, cek internet kamu "));
      }
    });
  }
}
