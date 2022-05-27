import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:omahdilit/Api/api_provider.dart';
import 'package:omahdilit/Api/shared_prefs_services.dart';
import 'package:omahdilit/model/customer.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    final ApiProvider _apiProvider = ApiProvider();

    Customer customer = Customer();
    on<SignIn>((event, emit) async {
      try {
        emit(ProfileLoading());
        print("masuk Login");
        await _apiProvider
            .login(event.code + event.phone, event.pushToken)
            .then((value) async {
          if (value.error == false) {
            print("user terdaftar");
            customer = value.customer!;
            SharedPrefsServices().saveUser(customer);
            emit(ProfileSuccess(customer));
          } else {
            print("user belum daftar");
            emit(Unregistered(event.code, event.phone));
          }
        });
      } on ProfileError {
        emit(ProfileError("Periksa internet kamu"));
      }
    });
    on<Registering>((event, emit) async {
      try {
        emit(ProfileLoading());
        await _apiProvider.register(event.customer).then((value) async {
          if (value.error == false) {
            customer = event.customer;
            SharedPrefsServices().saveUser(customer);
            emit(ProfileSuccess(customer));
          } else {
            emit(ProfileError("Gagal Registrasi"));
          }
        });
      } on ProfileError {
        emit(ProfileError("Periksa internet kamu"));
      }
    });

    on<SetUser>((event, emit) async {
      try {
        emit(ProfileLoading());
        customer = event.customer;
        emit(ProfileSuccess(customer));
      } on ProfileError {
        emit(ProfileError("Periksa internet kamu"));
      }
    });
  }
}
