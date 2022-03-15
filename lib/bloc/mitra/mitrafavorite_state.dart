part of 'mitrafavorite_bloc.dart';

abstract class MitrafavoriteState extends Equatable {
  const MitrafavoriteState();

  @override
  List<Object> get props => [];
}

class MitrafavoriteInitial extends MitrafavoriteState {}

class MitrafavoriteLoading extends MitrafavoriteState {}

class MitrafavoriteLoaded extends MitrafavoriteState {
  final ListMitraFavorite listMitra;
  const MitrafavoriteLoaded(this.listMitra);

  @override
  List<Object> get props => [listMitra];
}

class MitrafavoriteError extends MitrafavoriteState {
  final String message;
  const MitrafavoriteError(this.message);

  @override
  List<Object> get props => [message];
}
