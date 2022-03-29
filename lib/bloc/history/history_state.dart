part of 'history_bloc.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();
  
  @override
  List<Object> get props => [];
}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final ListTransaksi listTransaksi;
  const HistoryLoaded(this.listTransaksi);
}

class DetailHistoryLoaded extends HistoryState {
  final Transaksi transaksi;
  final int index;
  const DetailHistoryLoaded(
    this.transaksi,
    this.index,
  );
}

class HistoryError extends HistoryState {
  final String message;
  const HistoryError(this.message);

  @override
  List<Object> get props => [message];
}
