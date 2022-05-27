part of 'create_transaksi_bloc.dart';

abstract class CreateTransaksiEvent extends Equatable {
  const CreateTransaksiEvent();

  @override
  List<Object> get props => [];
}

class GetCustomer extends CreateTransaksiEvent {
  const GetCustomer();
  @override
  List<Object> get props => [];
}

class MitraAddedEvent extends CreateTransaksiEvent {
  final Mitra mitra;
  MitraAddedEvent(this.mitra);
  @override
  List<Object> get props => [mitra];
}

class ModelAddedEvent extends CreateTransaksiEvent {
  final ModelHair modelHair;
  ModelAddedEvent(this.modelHair);
  @override
  List<Object> get props => [modelHair];
}

class AlamatAddedEvent extends CreateTransaksiEvent {
  final Alamat alamat;
  AlamatAddedEvent(this.alamat);
  @override
  List<Object> get props => [alamat];
}

class CountPriceEvent extends CreateTransaksiEvent {
  final Transaksi transaksi;
  CountPriceEvent(this.transaksi);
  @override
  List<Object> get props => [transaksi];
}
