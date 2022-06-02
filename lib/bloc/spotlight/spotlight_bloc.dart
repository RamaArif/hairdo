import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:omahdilit/Api/api_provider.dart';
import 'package:omahdilit/model/spotlight.dart';

part 'spotlight_event.dart';
part 'spotlight_state.dart';

class SpotlightBloc extends Bloc<SpotlightEvent, SpotlightState> {
  SpotlightBloc() : super(SpotlightInitial()) {
    on<FetchSpotlight>((event, emit) async {
      try {
        emit(SpotlightLoading());
        ListSpotlight listSpotlight = await ApiProvider().fetchSpotlight();
        emit(SpotlightLoaded(listSpotlight));
      } catch (e) {
        print(e);
        throw Exception(e);
      }
    });
  }
}
