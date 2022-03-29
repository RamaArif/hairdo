import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:omahdilit/Api/api_provider.dart';
import 'package:omahdilit/model/customer.dart';
import 'package:omahdilit/model/listalamat.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'alamat_event.dart';
part 'alamat_state.dart';

class AlamatBloc extends Bloc<AlamatEvent, AlamatState> {
  AlamatBloc() : super(AlamatInitial()) {
    final ApiProvider _apiProvider = ApiProvider();

    ListAlamat listAlamat = ListAlamat();
    Customer customer = Customer();

    on<GetAlamatEvent>((event, emit) async {
      final SharedPreferences _prefs = await SharedPreferences.getInstance();
      try {
        customer = Customer.fromJson(jsonDecode(_prefs.getString("user")!));
        emit(AlamatLoading());
        listAlamat = await _apiProvider.fetchAlamat(customer.uid);
        print("Mitra" + jsonEncode(listAlamat));
        emit(AlamatLoaded(listAlamat));
        if (listAlamat.error == true) {
          emit(AlamatError(listAlamat.errorMessage.toString()));
        }
      } on AlamatError {
        emit(AlamatError("Gagal memuat data, cek internet kamu "));
      }
    });
    on<CreateAlamatEvent>((event, emit) async {
      try {
        emit(AlamatLoading());
        final listAlamat = await _apiProvider.createAlamat(event.alamat);
        print("Mitra" + jsonEncode(listAlamat));
        emit(AlamatLoaded(listAlamat));
        if (listAlamat.error == true) {
          emit(AlamatError(listAlamat.errorMessage.toString()));
        }
      } on AlamatError {
        emit(AlamatError("Gagal memuat data, cek internet kamu "));
      }
    });
  }
}
