part of 'create_transaksi_bloc.dart';

abstract class CreateTransaksiState extends Equatable {
  const CreateTransaksiState();

  @override
  List<Object> get props => [];
}

class CreatetransaksiInitial extends CreateTransaksiState {}

class CreatetransaksiLoading extends CreateTransaksiState {}

class PriceLoading extends CreateTransaksiState {}

class CreatetransaksiLoaded extends CreateTransaksiState {
  final Transaksi transaksi;
  final bool isComplete, isFilled;
  const CreatetransaksiLoaded(this.transaksi,this.isComplete, this.isFilled);

  @override
  List<Object> get props => [transaksi, isComplete,this.isFilled];
}

class CreatetransaksiError extends CreateTransaksiState {
  final String message;
  const CreatetransaksiError(this.message);

  @override
  List<Object> get props => [message];
}
class OrderLoaded extends CreateTransaksiState{
  final Transaksi transaksi;
  const OrderLoaded(this.transaksi);

  @override
  List<Object> get props => [transaksi];
}


class OnTransaction extends CreateTransaksiState{
  final Transaksi transaksi;
  const OnTransaction(this.transaksi);

  @override
  List<Object> get props => [transaksi];
}
