part of 'modelhair_bloc.dart';

abstract class ModelhairEvent extends Equatable {
  const ModelhairEvent();

  @override
  List<Object> get props => [];
}

class FetchHairHome extends ModelhairEvent {}

class FetchHair extends ModelhairEvent {}
