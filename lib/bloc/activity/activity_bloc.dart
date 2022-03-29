import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:omahdilit/Api/api_provider.dart';
import 'package:omahdilit/model/customer.dart';
import 'package:omahdilit/model/transaksi.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'activity_event.dart';
part 'activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  ActivityBloc() : super(ActivityInitial()) {
    final ApiProvider _apiProvider = ApiProvider();

    List<Transaksi> listTransaksi = [];
    Transaksi transaksi = Transaksi();
    Customer customer = Customer();
    on<GetActivity>((event, emit) async {
      final SharedPreferences _prefs = await SharedPreferences.getInstance();
      try {
        customer = Customer.fromJson(jsonDecode(_prefs.getString("user")!));
        emit(ActivityLoading());
        if (listTransaksi.isEmpty) {
          await _apiProvider.fetchActivity(customer.id).then((value) {
            // print(jsonEncode(value));
            listTransaksi = value.transaksis!;
          });
        }
        emit(ActivityLoaded(ListTransaksi(transaksis: listTransaksi)));
      } on ActivityError {
        emit(ActivityError("Periksa internet kamu"));
      }
    });

    on<DetailActivity>((event, emit) async {
      try {
        emit(ActivityLoading());
        print(event.index.toString());
        print(jsonEncode(listTransaksi));
        transaksi = listTransaksi[event.index];
        emit(TransaksiLoaded(transaksi, event.index));
      } on ActivityError {
        emit(ActivityError("Periksa internet kamu"));
      }
    });
  }
}
