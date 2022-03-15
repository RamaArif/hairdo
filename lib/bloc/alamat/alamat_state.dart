part of 'alamat_bloc.dart';

abstract class AlamatState extends Equatable {
  const AlamatState();
  
  @override
  List<Object> get props => [];
}

class AlamatInitial extends AlamatState {}
class AlamatLoading extends AlamatState {}
class AlamatLoaded extends AlamatState {

  final ListAlamat listAlamat;
  const AlamatLoaded(this.listAlamat);

  @override
  List<Object> get props => [listAlamat];
}
class AlamatError extends AlamatState {
  final String message;
  const AlamatError(this.message);

  @override
  List<Object> get props => [message];}
