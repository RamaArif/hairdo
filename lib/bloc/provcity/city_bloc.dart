import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:omahdilit/Api/api_provider.dart';
import 'package:omahdilit/model/listkota.dart';

part 'city_event.dart';
part 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  CityBloc() : super(CityInitial()) {
    ListKota? listKota;
    
    on<GetCity>((event, emit) async {
      
      emit(CityLoading());
      listKota = await ApiProvider().fetchKota(event.provId);
      emit(CityLoaded(listKota!));
    });
  }
}
