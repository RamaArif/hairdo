part of 'activity_bloc.dart';

abstract class ActivityState extends Equatable {
  const ActivityState();

  @override
  List<Object> get props => [];
}

class ActivityInitial extends ActivityState {}

class ActivityLoading extends ActivityState {}

class ActivityLoaded extends ActivityState {
  final ListTransaksi listTransaksi;
  const ActivityLoaded(this.listTransaksi);
}

class ActivityError extends ActivityState {
  final String message;
  const ActivityError(this.message);

  @override
  List<Object> get props => [message];
}
