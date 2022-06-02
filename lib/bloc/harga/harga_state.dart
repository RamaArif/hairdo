part of 'harga_bloc.dart';

abstract class HargaState extends Equatable {
  const HargaState();

  @override
  List<Object> get props => [];
}

class HargaInitial extends HargaState {}

class HargaLoading extends HargaState {}

class HargaLoaded extends HargaState {
  final HargaModel hargaModel;
  const HargaLoaded(this.hargaModel);

  @override
  List<Object> get props => [hargaModel];
}
