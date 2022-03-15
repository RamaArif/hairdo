import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'modelhair_event.dart';
part 'modelhair_state.dart';

class ModelhairBloc extends Bloc<ModelhairEvent, ModelhairState> {
  ModelhairBloc() : super(ModelhairInitial()) {
    on<ModelhairEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
