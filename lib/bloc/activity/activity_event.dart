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

class RefreshActivity extends ActivityEvent {}

class DetailActivity extends ActivityEvent {
  final int index;
  const DetailActivity(this.index);
  @override
  List<Object> get props => [index];
}

class RefreshDetailActivity extends ActivityEvent {}
