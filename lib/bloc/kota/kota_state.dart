part of 'kota_bloc.dart';

abstract class KotaState extends Equatable {
  const KotaState();
  
  @override
  List<Object> get props => [];
}

class KotaInitial extends KotaState {}

class KotaLoading extends KotaState {}

class KotaLoaded extends KotaState {
  final ListKota listKota;
  const KotaLoaded(this.listKota);

  @override
  List<Object> get props => [listKota];
}

class KotaError extends KotaState {
  final String message;
  const KotaError(this.message);

  @override
  List<Object> get props => [message];
}
