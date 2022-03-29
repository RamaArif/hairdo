import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:omahdilit/Api/api_provider.dart';
import 'package:omahdilit/model/customer.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    final ApiProvider _apiProvider = ApiProvider();

    Customer customer = Customer();
    on<GetProfile>((event, emit) async {
      try {
        emit(ProfileLoading());
        print(jsonEncode(customer));
        emit(ProfileLoaded(customer));
      } on ProfileError {
        emit(ProfileError("Periksa internet kamu"));
      }
    });
  }
}
