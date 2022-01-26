part of 'kota_bloc.dart';

abstract class KotaEvent extends Equatable {
  const KotaEvent();

}

class GetKota extends KotaEvent {
  final String provinsi;
  GetKota(this.provinsi);
  @override
  List<Object> get props => [provinsi];
}
