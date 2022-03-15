part of 'transaksi_bloc.dart';

abstract class TransaksiEvent extends Equatable {
  const TransaksiEvent();

  @override
  List<Object> get props => [];
}

class CreateTransaksiEvent extends TransaksiEvent {
  final Transaksi transaksi;
  CreateTransaksiEvent(this.transaksi);
  @override
  List<Object> get props => [transaksi];
}

class GetCustomer extends TransaksiEvent {
  const GetCustomer();
  @override
  List<Object> get props => [];
}

class MitraAddedEvent extends TransaksiEvent {
  final Mitra mitra;
  MitraAddedEvent(this.mitra);
  @override
  List<Object> get props => [mitra];
}

class ModelAddedEvent extends TransaksiEvent {
  final ModelHair modelHair;
  ModelAddedEvent(this.modelHair);
  @override
  List<Object> get props => [modelHair];
}

class AlamatAddedEvent extends TransaksiEvent {
  final Alamat alamat;
  AlamatAddedEvent(this.alamat);
  @override
  List<Object> get props => [alamat];
}

class CountPriceEvent extends TransaksiEvent {
  final Transaksi transaksi;
  CountPriceEvent(this.transaksi);
  @override
  List<Object> get props => [transaksi];
}
