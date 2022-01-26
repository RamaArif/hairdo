import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:omahdilit/View/Login/login.dart';
import 'package:omahdilit/model/baseresponse.dart';
import 'package:omahdilit/model/customer.dart';
import 'package:omahdilit/model/listkota.dart';
import 'package:omahdilit/model/listmitra.dart';
import 'package:omahdilit/model/listprovinsi.dart';
import 'package:omahdilit/model/loginresponse.dart';

class ApiProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  final String _baseUrl = "https://omahdilit.my.id/api/";
  final String _pickerUrl = "https://api.rajaongkir.com/starter/";
  final String _apiPicker = "2604e0d2b5bcd3c6b146c36b9447bd25";

  Future<LoginResponse> login(number, pushToken) async {
    try {
      Response response = await _dio.post(
        _baseUrl + "loginnumber",
        data: {'number': number, 'pushtoken': pushToken},
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      return LoginResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      return LoginResponse.withError("Data not found / Connection issue");
    }
  }

  Future<BaseResponse> register(Customer customer) async {
    print(customer.name);
    print(customer.email);
    print(customer.jenkel);
    print(customer.uid);
    print(customer.pushtoken);
    print(customer.number);
    try {
      Response response = await _dio.post(
        _baseUrl + "daftaruser",
        data: customer,
        // options: Options(headers: {
        //   HttpHeaders.contentTypeHeader: "application/json",
        // }),
      );
      return BaseResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      return BaseResponse.withError("Data not found / Connection issue");
    }
  }

  Future<ListMitra> fetchFavorite() async {
    try {
      Response response = await _dio.get(_baseUrl + "mitrafavorite");
      return ListMitra.fromJson(response.data);
    } catch (error, stacktrace) {
      return ListMitra.withError("Data not found / Connection issue");
    }
  }

  Future<ListMitra> fetchMitra() async {
    try {
      Response response = await _dio.get(_baseUrl + "tukang");
      return ListMitra.fromJson(response.data);
    } catch (error, stacktrace) {
      return ListMitra.withError("Data not found / Connection issue");
    }
  }

  Future<ListProvinsi> fetchProvinsi() async {
    try {
      Response response = await _dio.get(
        _pickerUrl + "province",
        options: Options(
          headers: {"key": _apiPicker},
        ),
      );
      // print("Provinsi = " + jsonEncode(response.data));
      return ListProvinsi.fromJson(response.data);
    } catch (error, stacktrace) {
      return ListProvinsi.withError("Data not found / Connection issue");
    }
  }

  Future<ListKota> fetchKota(province) async {
    try {
      Response response = await _dio.get(
        _pickerUrl + "city?province=" + province,
        options: Options(
          headers: {"key": _apiPicker},
        ),
      );
      return ListKota.fromJson(response.data);
    } catch (error, stacktrace) {
      return ListKota.withError("Data not found / Connection issue");
    }
  }
}
