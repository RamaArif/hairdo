import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'mitra_event.dart';
part 'mitra_state.dart';

class MitraBloc extends Bloc<MitraEvent, MitraState> {
  MitraBloc() : super(MitraInitial()) {
    on<MitraEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
