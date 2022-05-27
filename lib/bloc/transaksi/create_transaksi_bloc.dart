import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:omahdilit/Api/api_provider.dart';
import 'package:omahdilit/bloc/activity/activity_bloc.dart';
import 'package:omahdilit/model/customer.dart';
import 'package:omahdilit/model/detailmitra.dart';
import 'package:omahdilit/model/listalamat.dart';
import 'package:omahdilit/model/modelhair.dart';
import 'package:omahdilit/model/transaksi.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'create_transaksi_event.dart';
part 'create_transaksi_state.dart';

class CreateTransaksiBloc extends Bloc<CreateTransaksiEvent, CreateTransaksiState> {
  CreateTransaksiBloc() : super(CreatetransaksiInitial()) {
    final ApiProvider _apiProvider = ApiProvider();

    Transaksi _transaksi = Transaksi();

    on<GetCustomer>(
      (event, emit) async {
        final SharedPreferences _prefs = await SharedPreferences.getInstance();
        try {
          emit(CreatetransaksiLoading());
          Customer _customer = Customer.fromJson(
            jsonDecode(_prefs.getString("user")!),
          );
          _transaksi.customer = _customer;
          _transaksi.idcustomer = _customer.id;
          emit(CreatetransaksiLoaded(_transaksi, false, false));
        } on CreatetransaksiError {
          emit(CreatetransaksiError("Gagal memuat data, cek internet kamu "));
        }
      },
    );

    on<MitraAddedEvent>(
      (event, emit) async {
        try {
          emit(CreatetransaksiLoading());
          _transaksi.mitra = event.mitra;
          _transaksi.idtukang = event.mitra.id;
          var isFilled;
          if (_transaksi.alamat != null &&
              _transaksi.mitra != null &&
              _transaksi.model != null) {
            isFilled = true;
          } else {
            isFilled = false;
          }
          emit(CreatetransaksiLoaded(_transaksi, false, isFilled));
        } on CreatetransaksiError {
          emit(CreatetransaksiError("Gagal memuat data, cek internet kamu "));
        }
      },
    );
    on<ModelAddedEvent>(
      (event, emit) async {
        try {
          emit(CreatetransaksiLoading());
          _transaksi.model = event.modelHair;
          _transaksi.idmodel = event.modelHair.id;
          // print("Mitra" + jsonEncode(transaksi));
          bool isFilled = false;
          if (_transaksi.alamat != null &&
              _transaksi.mitra != null &&
              _transaksi.model != null) {
            isFilled = true;
          }
          emit(CreatetransaksiLoaded(_transaksi, false, isFilled));
        } on CreatetransaksiError {
          emit(CreatetransaksiError("Gagal memuat data, cek internet kamu "));
        }
      },
    );

    on<AlamatAddedEvent>(
      (event, emit) async {
        try {
          emit(CreatetransaksiLoading());
          _transaksi.alamat = event.alamat;
          _transaksi.idalamat = event.alamat.id;
          // print("Mitra" + jsonEncode(transaksi));
          bool isFilled = false;
          if (_transaksi.alamat != null &&
              _transaksi.mitra != null &&
              _transaksi.model != null) {
            isFilled = true;
          }
          emit(CreatetransaksiLoaded(_transaksi, false, isFilled));
        } on CreatetransaksiError {
          emit(CreatetransaksiError("Gagal memuat data, cek internet kamu "));
        }
      },
    );

    on<CountPriceEvent>(
      (event, emit) async {
        try {
          emit(PriceLoading());
          await _apiProvider
              .countPrice(_transaksi.mitra!, _transaksi.alamat!)
              .then(
            (value) {
              _transaksi.hargacukur = value.hargacukur;
              _transaksi.penanganan = value.hargalebih;
              _transaksi.totalharga = value.hargatotal;
              _transaksi.jarak = value.jarak;
            },
          );
          bool isFilled = false;
          if (_transaksi.alamat != null &&
              _transaksi.mitra != null &&
              _transaksi.model != null) {
            isFilled = true;
          }
          emit(CreatetransaksiLoaded(_transaksi, false, isFilled));
        } on CreatetransaksiError {
          emit(CreatetransaksiError("Gagal memuat data, cek internet kamu "));
        }
      },
    );
  }
}
