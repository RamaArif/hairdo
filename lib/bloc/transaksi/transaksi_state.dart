part of 'transaksi_bloc.dart';

abstract class TransaksiState extends Equatable {
  const TransaksiState();

  @override
  List<Object> get props => [];
}

class CreatetransaksiInitial extends TransaksiState {}

class CreatetransaksiLoading extends TransaksiState {}

class PriceLoading extends TransaksiState {}

class CreatetransaksiLoaded extends TransaksiState {
  final Transaksi transaksi;
  final bool isComplete, isFilled;
  const CreatetransaksiLoaded(this.transaksi,this.isComplete, this.isFilled);

  @override
  List<Object> get props => [transaksi, isComplete,this.isFilled];
}

class CreatetransaksiError extends TransaksiState {
  final String message;
  const CreatetransaksiError(this.message);

  @override
  List<Object> get props => [message];
}


class OnTransaction extends TransaksiState{
  final Transaksi transaksi;
  const OnTransaction(this.transaksi);

  @override
  List<Object> get props => [transaksi];
}
