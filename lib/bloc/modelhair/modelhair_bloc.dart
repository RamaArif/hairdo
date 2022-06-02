import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:omahdilit/Api/api_provider.dart';
import 'package:omahdilit/model/listmodelrambut.dart';
import 'package:omahdilit/model/modelhair.dart';

part 'modelhair_event.dart';
part 'modelhair_state.dart';

class ModelhairBloc extends Bloc<ModelhairEvent, ModelhairState> {
  ModelhairBloc() : super(ModelhairInitial()) {
    ModelHome modelHome = ModelHome();
    ListModelRambut listModelRambut = ListModelRambut();
    on<FetchHairHome>((event, emit) async {
      try {
        modelHome = await ApiProvider().fetchModelHome();
        emit(ModelhairSuccess(listModelRambut, modelHome));
      } catch (e) {
        print(e);
        throw Exception(e);
      }
    });
    on<FetchHair>((event, emit) async {
      try {
         listModelRambut = await ApiProvider().fetchModel();
        emit(ModelhairSuccess(listModelRambut, modelHome));
      } catch (e) {
        print(e);
        throw Exception(e);
      }
    });
  }
}
