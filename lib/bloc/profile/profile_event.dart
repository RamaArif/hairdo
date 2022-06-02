part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class SignIn extends ProfileEvent {
  final String phone, code, pushToken, uid;
  const SignIn(this.phone, this.code, this.pushToken, this.uid);

  @override
  List<Object> get props => [phone, code, pushToken, uid];
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

class UpdateProfile extends ProfileEvent {
  final Customer customer;
  const UpdateProfile(this.customer);

  @override
  List<Object> get props => [customer];

}

class UpdateAva extends ProfileEvent {
  final String uid, image;
  const UpdateAva(this.uid,this.image);

  @override
  List<Object> get props => [uid,image];
}

class Logout extends ProfileEvent {}
