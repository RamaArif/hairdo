part of 'history_bloc.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

class GetHistory extends HistoryEvent {
  const GetHistory();
  @override
  List<Object> get props => [];
}

class DetailHistory extends HistoryEvent {
  final int index;
  const DetailHistory(this.index);
  @override
  List<Object> get props => [index];
}
