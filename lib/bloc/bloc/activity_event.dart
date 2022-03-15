part of 'activity_bloc.dart';

abstract class ActivityEvent extends Equatable {
  const ActivityEvent();

  @override
  List<Object> get props => [];
}

class GetActivity extends ActivityEvent {
  const GetActivity();
  @override
  List<Object> get props => [];
}

class DetailActivity extends ActivityEvent {
  final int index;
  const DetailActivity(this.index);
  @override
  List<Object> get props => [index];
}

class DetailTransaksi extends ActivityEvent {
  final Transaksi transaksi;
  const DetailTransaksi(this.transaksi);
  @override
  List<Object> get props => [transaksi];
}

class GetDetail extends ActivityEvent {
  final int index;
  const GetDetail(this.index);
  @override
  List<Object> get props => [index];
}
