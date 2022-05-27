part of 'province_bloc.dart';

abstract class ProvinceState extends Equatable {
  const ProvinceState();

  @override
  List<Object> get props => [];
}

class ProvinceInitial extends ProvinceState {}

class ProvinceLoading extends ProvinceState {}

class ProvLoaded extends ProvinceState {
  final ListProvinsi listProvinsi;
  const ProvLoaded(this.listProvinsi);

  @override
  List<Object> get props => [listProvinsi];
}


class ProvinceError extends ProvinceState {}
