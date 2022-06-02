import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:omahdilit/Api/api_provider.dart';
import 'package:omahdilit/model/review.dart';
import 'package:omahdilit/model/transaksi.dart';

part 'transaksi_event.dart';
part 'transaksi_state.dart';

class TransaksiBloc extends Bloc<TransaksiEvent, TransaksiState> {
  TransaksiBloc() : super(TransaksiInitial()) {
    final ApiProvider _apiProvider = ApiProvider();

    Transaksi? _transaksi;
    on<CreateOrderEvent>(
      (event, emit) async {
        try {
          emit(TransaksiLoading());
          print(jsonEncode(_transaksi));
          final transaksi = await _apiProvider.transaksi(event.transaksi);
          emit(TransaksiLoaded(transaksi));
        } catch (e) {
          print(e);
          throw Exception(e);
        }
      },
    );

    on<FetchOrder>((event, emit) async {
      try {
        emit(TransaksiLoading());
        await _apiProvider
            .detailTransaksi(event.transaksi.toString())
            .then((value) {
          _transaksi = value;
          emit(TransaksiLoaded(_transaksi!));
        });
      } catch (e) {
        print(e);
        throw Exception(e);
      }
    });

    on<CancelOrder>(
      (event, emit) async {
        try {
          emit(TransaksiLoading());
          _transaksi = await _apiProvider.cancelTransaksi(event.transaksi);
          emit(TransaksiLoaded(_transaksi!));
        } catch (e) {
          print(e);
          throw Exception(e);
        }
      },
    );
    on<PostReview>(
      (event, emit) async {
        try {
          emit(TransaksiLoading());
          await _apiProvider.createReview(event.reviewModel).then((value) {
            _transaksi!.review = value;
            emit(TransaksiLoaded(_transaksi!));
          });
        } catch (e) {
          print(e);
          throw Exception(e);
        }
      },
    );
  }
}
