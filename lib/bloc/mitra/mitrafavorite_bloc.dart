import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:omahdilit/Api/api_provider.dart';
import 'package:omahdilit/model/listmitra.dart';

part 'mitrafavorite_event.dart';
part 'mitrafavorite_state.dart';

class MitrafavoriteBloc extends Bloc<MitrafavoriteEvent, MitrafavoriteState> {
  MitrafavoriteBloc() : super(MitrafavoriteInitial()) {
    final ApiProvider _apiProvider = ApiProvider();

    on<GetMitraFavoriteEvent>((event, emit) async {
      try {
        emit(MitrafavoriteLoading());
        final listMitra = await _apiProvider.fetchFavorite();
        print("Mitra" + jsonEncode(listMitra));
        emit(MitrafavoriteLoaded(listMitra));
        if (listMitra.error == true) {
          emit(MitrafavoriteError(listMitra.errorMessage.toString()));
        }
      } on MitrafavoriteError {
        emit(MitrafavoriteError("Gagal memuat data, cek internet kamu "));
      }
    });
  }
}
