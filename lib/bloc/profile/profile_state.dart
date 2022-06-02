part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class Unregistered extends ProfileState {
  final String code, phone,uid;
  const Unregistered(this.code,this.phone,  this.uid);

  @override
  List<Object> get props => [code,phone,uid];
}

class ProfileSuccess extends ProfileState {
  final Customer customer;
  const ProfileSuccess(this.customer);

  @override
  List<Object> get props => [customer];
}

class ProfileError extends ProfileState {
  final String message;
  const ProfileError(this.message);

  @override
  List<Object> get props => [message];
}
