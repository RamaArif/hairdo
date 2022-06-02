part of 'spotlight_bloc.dart';

abstract class SpotlightState extends Equatable {
  const SpotlightState();

  @override
  List<Object> get props => [];
}

class SpotlightInitial extends SpotlightState {}

class SpotlightLoading extends SpotlightState {}

class SpotlightLoaded extends SpotlightState {
  final ListSpotlight listSpotlight;
  const SpotlightLoaded(this.listSpotlight);

  @override
  List<Object> get props => [listSpotlight];
}
