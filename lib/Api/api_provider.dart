import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:omahdilit/model/baseresponse.dart';
import 'package:omahdilit/model/customer.dart';
import 'package:omahdilit/model/detailmitra.dart';
import 'package:omahdilit/model/listalamat.dart';
import 'package:omahdilit/model/listkota.dart';
import 'package:omahdilit/model/listmitra.dart';
import 'package:omahdilit/model/listmodelrambut.dart';
import 'package:omahdilit/model/listprovinsi.dart';
import 'package:omahdilit/model/loginresponse.dart';
import 'package:omahdilit/model/modelhair.dart';
import 'package:omahdilit/model/price.dart';
import 'package:omahdilit/model/review.dart';
import 'package:omahdilit/model/transaksi.dart';

class ApiProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  final String _baseUrl = "https://omahdilit.site/api/";
  final String _pickerUrl = "https://api.rajaongkir.com/starter/";
  final String _apiPicker = "2604e0d2b5bcd3c6b146c36b9447bd25";

  Future<LoginResponse> login(number, pushToken) async {
    try {
      Response response = await _dio.post(
        _baseUrl + "loginnumber",
        data: {'number': number, 'pushtoken': pushToken},
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      print(jsonEncode(response.data));
      return LoginResponse.fromJson(response.data);
    } catch (e) {
      print(e);
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
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );
      print(jsonEncode(response.data));
      return BaseResponse.fromJson(response.data);
    } catch (e, stacktrace) {
      print(e);
      return BaseResponse.withError("Data not found / Connection issue");
    }
  }

  Future<ListAlamat> createAlamat(Alamat alamat) async {
    try {
      Response response = await _dio.post(
        _baseUrl + "createAlamat",
        data: alamat,
        options: Options(contentType: Headers.jsonContentType),
      );
      print(response);
      return ListAlamat.fromJson(response.data);
    } catch (error) {
      print(error);
      return ListAlamat.withError("Data not found / Connection issue");
    }
  }

  Future<ListAlamat> fetchAlamat(uid) async {
    try {
      Response response = await _dio.get(_baseUrl + "alamat/" + uid);
      return ListAlamat.fromJson(response.data);
    } catch (error) {
      print(error);
      return ListAlamat.withError("Data not found / Connection issue");
    }
  }

  Future<ListMitraFavorite> fetchFavorite() async {
    try {
      Response response = await _dio.get(_baseUrl + "mitrafavorite");
      return ListMitraFavorite.fromJson(response.data);
    } catch (error, stacktrace) {
      return ListMitraFavorite.withError("Data not found / Connection issue");
    }
  }

  Future<ListMitra> fetchMitra() async {
    try {
      Response response = await _dio.get(_baseUrl + "mitragender");
      // print(response.data);
      return ListMitra.fromJson(response.data);
    } catch (error) {
      print(error);
      return ListMitra.withError("Data not found / Connection issue");
    }
  }

  Future<DetailMitra> fetchDetailMitra(id) async {
    try {
      Response response = await _dio.get(_baseUrl + "detailmitra/" + id);
      print(id);
      print(response.data.toString());
      return DetailMitra.fromJson(response.data);
    } catch (error) {
      print(error);
      return DetailMitra.withError("Data not found / Connection issue");
    }
  }

  Future<ListReview> fetchReview(id) async {
    try {
      Response response = await _dio.get(_baseUrl + "review/" + id);
      // print(response.data.toString());
      return ListReview.fromJson(response.data);
    } catch (error) {
      print(error);
      return ListReview.withError("Data not found / Connection issue");
    }
  }

  Future<ModelHome> fetchModelHome() async {
    try {
      Response response = await _dio.get(_baseUrl + "modelhairhome");
      return ModelHome.fromJson(response.data);
    } catch (error) {
      return ModelHome.withError("Data not found / Connection issue");
    }
  }

  Future<ListModelRambut> fetchModel() async {
    try {
      Response response = await _dio.get(_baseUrl + "modelhair");
      return ListModelRambut.fromJson(response.data);
    } catch (error) {
      return ListModelRambut.withError("Data not found / Connection issue");
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

  Future<PriceModel> countPrice(Mitra mitra, Alamat alamat) async {
    try {
      Response response = await _dio.post(
        _baseUrl + "countprice",
        data: {
          "lat1": mitra.lat,
          "lat2": alamat.lat,
          "long1": mitra.lng,
          "long2": alamat.lng,
        },
        // data: {
        //   "lat1": -7.2581098,
        //   "lat2": -7.284931,
        //   "long1": 112.6605914,
        //   "long2": 112.7557532
        // },
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      print(response.data.toString());
      return PriceModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print(error);
      return PriceModel.withError("Data not found / Connection issue");
    }
  }

  Future<Transaksi> transaksi(Transaksi _transaksi) async {
    try {
      Response response = await _dio.post(
        _baseUrl + "newtransaksi",
        data: _transaksi,
        options: Options(contentType: Headers.jsonContentType),
      );
      // print(response);
      return Transaksi.fromJson(response.data);
    } catch (error) {
      print(error);
      return Transaksi.withError("Data not found / Connection issue");
    }
  }

  Future<Transaksi> detailTransaksi(String id) async {
    try {
      Response response = await _dio.get(
        _baseUrl + "fetch-transaksi/$id",
      );
      // print(response);
      return Transaksi.fromJson(response.data);
    } catch (error) {
      print(error);
      return Transaksi.withError("Data not found / Connection issue");
    }
  }

  Future<Transaksi> cancelTransaksi(Transaksi _transaksi) async {
    try {
      Response response = await _dio.post(
        _baseUrl + "customerCancelOrder",
        data: _transaksi,
        options: Options(contentType: Headers.jsonContentType),
      );
      // print(response);
      return Transaksi.fromJson(response.data);
    } catch (error) {
      print(error);
      return Transaksi.withError("Data not found / Connection issue");
    }
  }

  Future<ListTransaksi> fetchActivity(id) async {
    try {
      // print(id.toString());
      Response response = await _dio.get(
        _baseUrl + "activity/" + id.toString(),
      );
      return ListTransaksi.fromJson(response.data);
    } catch (error) {
      print(error);
      return ListTransaksi.withError("Data not found / Connection issue");
    }
  }

  Future<ListTransaksi> FetchHistory(id) async {
    try {
      // print(id.toString());
      Response response = await _dio.get(
        _baseUrl + "history/" + id.toString(),
      );
      return ListTransaksi.fromJson(response.data);
    } catch (error) {
      print(error);
      return ListTransaksi.withError("Data not found / Connection issue");
    }
  }
}
