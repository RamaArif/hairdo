part of 'city_bloc.dart';

abstract class CityState extends Equatable {
  const CityState();
  
  @override
  List<Object> get props => [];
}

class CityInitial extends CityState {}

class CityLoading extends CityState {}

class CityLoaded extends CityState {
  final ListKota listKota;
  const CityLoaded(this.listKota);

  @override
  List<Object> get props => [listKota];
}


class CityFailed extends CityState {}