part of 'modelhair_bloc.dart';

abstract class ModelhairState extends Equatable {
  const ModelhairState();

  @override
  List<Object> get props => [];
}

class ModelhairInitial extends ModelhairState {}

class ModelhairLoading extends ModelhairState {}

class ModelhairSuccess extends ModelhairState {
  final ListModelRambut listModelRambut;
  final ModelHome modelHome;
  const ModelhairSuccess(this.listModelRambut, this.modelHome);

  @override
  List<Object> get props => [listModelRambut, modelHome];
}
