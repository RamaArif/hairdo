part of 'city_bloc.dart';

abstract class CityEvent extends Equatable {
  const CityEvent();

  @override
  List<Object> get props => [];
}

class GetCity extends CityEvent {
  final String provId;

  const GetCity(this.provId);

  @override
  List<Object> get props => [provId];
}
