import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:omahdilit/Api/api_provider.dart';
import 'package:omahdilit/model/hargamodel.dart';

part 'harga_event.dart';
part 'harga_state.dart';

class HargaBloc extends Bloc<HargaEvent, HargaState> {
  HargaBloc() : super(HargaInitial()) {
    on<FetchHarga>((event, emit) async {
      try {
        emit(HargaLoading());
        HargaModel hargaModel = await ApiProvider().fetchHarga();
        emit(HargaLoaded(hargaModel));
      } catch (e) {
        print(e);
        throw Exception(e);
      }
    });
  }
}
