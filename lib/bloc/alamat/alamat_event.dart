part of 'alamat_bloc.dart';

abstract class AlamatEvent extends Equatable {
  const AlamatEvent();

  @override
  List<Object> get props => [];
}

class GetAlamatEvent extends AlamatEvent {
  final String uid;
  GetAlamatEvent(this.uid);
  @override
  List<Object> get props => [uid];
}

class CreateAlamatEvent extends AlamatEvent {
  final Alamat alamat;
  CreateAlamatEvent(this.alamat);
  @override
  List<Object> get props => [alamat];
}

class EditAlamatEvent extends AlamatEvent {
  final Alamat alamat;
  EditAlamatEvent(this.alamat);
  @override
  List<Object> get props => [alamat];
}
