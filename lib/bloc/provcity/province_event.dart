part of 'province_bloc.dart';

abstract class ProvinceEvent extends Equatable {
  const ProvinceEvent();

  @override
  List<Object> get props => [];
}

class GetProvince extends ProvinceEvent {}

