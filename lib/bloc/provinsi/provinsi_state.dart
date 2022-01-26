part of 'provinsi_bloc.dart';

abstract class ProvinsiState extends Equatable {
  const ProvinsiState();
  
  @override
  List<Object> get props => [];
}

class ProvinsiInitial extends ProvinsiState {}

class ProvinsiLoading extends ProvinsiState {}

class ProvinsiLoaded extends ProvinsiState {
  final ListProvinsi listProvinsi;
  const ProvinsiLoaded(this.listProvinsi);

  @override
  List<Object> get props => [listProvinsi];
}

class ProvinsiError extends ProvinsiState {
  final String message;
  const ProvinsiError(this.message);

  @override
  List<Object> get props => [message];
}
