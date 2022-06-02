part of 'harga_bloc.dart';

abstract class HargaEvent extends Equatable {
  const HargaEvent();

  @override
  List<Object> get props => [];
}

class FetchHarga extends HargaEvent {
  FetchHarga();
  @override
  List<Object> get props => [];
}