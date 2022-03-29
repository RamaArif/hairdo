import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:omahdilit/Api/api_provider.dart';
import 'package:omahdilit/model/customer.dart';
import 'package:omahdilit/model/transaksi.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(HistoryInitial()) {
    final ApiProvider _apiProvider = ApiProvider();

    ListTransaksi listTransaksi = ListTransaksi();
    Transaksi transaksi = Transaksi();
    Customer customer = Customer();
    on<GetHistory>((event, emit) async {
      final SharedPreferences _prefs = await SharedPreferences.getInstance();
      try {
        customer = Customer.fromJson(jsonDecode(_prefs.getString("user")!));
        emit(HistoryLoading());
        await _apiProvider.FetchHistory(customer.id).then((value) {
          print(jsonEncode(value));
          listTransaksi = value;
        });
        emit(HistoryLoaded(listTransaksi));
      } on HistoryError {
        emit(HistoryError("Periksa internet kamu"));
      }
    });
    on<DetailHistory>((event, emit) async {
      try {
        emit(HistoryLoading());
        transaksi = listTransaksi.transaksis![event.index];
        emit(DetailHistoryLoaded(transaksi, event.index));
      } on HistoryError {
        emit(HistoryError("Periksa internet kamu"));
      }
    });
  }
}
