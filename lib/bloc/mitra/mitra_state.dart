part of 'mitra_bloc.dart';

abstract class MitraState extends Equatable {
  const MitraState();
  
  @override
  List<Object> get props => [];
}

class MitraInitial extends MitraState {}
