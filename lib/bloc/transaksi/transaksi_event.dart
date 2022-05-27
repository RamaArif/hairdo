part of 'transaksi_bloc.dart';

abstract class TransaksiEvent extends Equatable {
  const TransaksiEvent();

  @override
  List<Object> get props => [];
}

class CreateOrderEvent extends TransaksiEvent {
  final Transaksi transaksi;
  CreateOrderEvent(this.transaksi);
  @override
  List<Object> get props => [transaksi];
}

class CancelOrder extends TransaksiEvent {
  final Transaksi transaksi;
  CancelOrder(this.transaksi);
  @override
  List<Object> get props => [transaksi];
}

class FetchOrder extends TransaksiEvent {
  final int transaksi;
  FetchOrder(this.transaksi);
  @override
  List<Object> get props => [transaksi];
}
