part of 'transaksi_bloc.dart';

abstract class TransaksiState extends Equatable {
  const TransaksiState();
  
  @override
  List<Object> get props => [];
}

class TransaksiInitial extends TransaksiState {}

class TransaksiLoading extends TransaksiState {}

class TransaksiLoaded extends TransaksiState {
  final Transaksi transaksi;
  TransaksiLoaded(this.transaksi);
  @override
  List<Object> get props => [transaksi];}
