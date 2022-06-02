part of 'spotlight_bloc.dart';

abstract class SpotlightEvent extends Equatable {
  const SpotlightEvent();

  @override
  List<Object> get props => [];
}

class FetchSpotlight extends SpotlightEvent {
  FetchSpotlight();
  @override
  List<Object> get props => [];
}

