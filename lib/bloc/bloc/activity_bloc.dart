import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';
import 'package:omahdilit/Api/api_provider.dart';
import 'package:omahdilit/bloc/alamat/alamat_bloc.dart';
import 'package:omahdilit/model/customer.dart';
import 'package:omahdilit/model/transaksi.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'activity_event.dart';
part 'activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  ActivityBloc() : super(ActivityInitial()) {
    final ApiProvider _apiProvider = ApiProvider();

    ListTransaksi listTransaksi = ListTransaksi();
    Transaksi transaksi = Transaksi();
    Customer customer = Customer();
    on<GetActivity>((event, emit) async {
      final SharedPreferences _prefs = await SharedPreferences.getInstance();
      try {
        customer = Customer.fromJson(jsonDecode(_prefs.getString("user")!));
        emit(ActivityLoading());
        await _apiProvider.fetchActivity(customer.id).then((value) {
          // print(jsonEncode(value));
          listTransaksi = value;
        });
        emit(ActivityLoaded(listTransaksi));
      } on ActivityError {
        emit(ActivityError("Periksa internet kamu"));
      }
    });
    on<DetailActivity>((event, emit) async {
      try {
        emit(ActivityLoading());
        transaksi = listTransaksi.transaksis![event.index];
        emit(TransaksiLoaded(transaksi, event.index));
      } on ActivityError {
        emit(ActivityError("Periksa internet kamu"));
      }
    });
    on<DetailTransaksi>((event, emit) async {
      try {
        emit(ActivityLoading());
        listTransaksi.transaksis!.insert(0, event.transaksi);
        transaksi = event.transaksi;
        emit(TransaksiLoaded(transaksi, 0));
      } on ActivityError {
        emit(ActivityError("Periksa internet kamu"));
      }
    });
    on<GetDetail>((event, emit) async {
      try {
        emit(ActivityLoading());

        emit(TransaksiLoaded(transaksi, event.index));
      } on ActivityError {
        emit(ActivityError("Periksa internet kamu"));
      }
    });
  }
}
