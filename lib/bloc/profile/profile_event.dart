part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class SignIn extends ProfileEvent {
  final String phone, code, pushToken;
  const SignIn(this.phone, this.code, this.pushToken);

  @override
  List<Object> get props => [phone, code, pushToken];
}

class Registering extends ProfileEvent {
  final Customer customer;
  const Registering(this.customer);

  @override
  List<Object> get props => [customer];

}

class SetUser extends ProfileEvent {
  final Customer customer;
  const SetUser(this.customer);

  @override
  List<Object> get props => [customer];

}

class UpdateProfile extends ProfileEvent {}

class Logout extends ProfileEvent {}
