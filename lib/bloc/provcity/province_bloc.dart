import 'package:bloc/bloc.dart';
import 'package:omahdilit/Api/api_provider.dart';
import 'package:equatable/equatable.dart';
import 'package:omahdilit/model/listprovinsi.dart';

part 'province_event.dart';
part 'province_state.dart';

class ProvinceBloc extends Bloc<ProvinceEvent, ProvinceState> {
  ProvinceBloc() : super(ProvinceInitial()) {
    ListProvinsi listProvinsi = ListProvinsi();

    on<GetProvince>((event, emit) async {
      // TODO: implement event handler
      emit(ProvinceLoading());
      listProvinsi = await ApiProvider().fetchProvinsi();
      emit(ProvLoaded(listProvinsi));
    });


  }
}
