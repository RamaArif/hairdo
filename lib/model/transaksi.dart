import 'package:omahdilit/model/customer.dart';
import 'package:omahdilit/model/detailmitra.dart';
import 'package:omahdilit/model/listalamat.dart';
import 'package:omahdilit/model/listmitra.dart';
import 'package:omahdilit/model/modelhair.dart';

class ListTransaksi {
  List<Transaksi>? transaksis;

  ListTransaksi({this.transaksis});

  ListTransaksi.fromJson(Map<String, dynamic> json) {
    if (json['transaksis'] != null) {
      transaksis = <Transaksi>[];
      json['transaksis'].forEach((v) {
        transaksis!.add(new Transaksi.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.transaksis != null) {
      data['transaksis'] = this.transaksis!.map((v) => v.toJson()).toList();
    }
    return data;
  }
  
  ListTransaksi.withError(String errorMessage) {
    errorMessage = errorMessage;
  }
}

class Transaksi {
  int? id;
  int? idtukang;
  int? idcustomer;
  int? idmodel;
  int? idalamat;
  String? codetransaksi;
  int? totalharga;
  int? hargacukur;
  int? promo;
  int? penanganan;
  int? hargalayanan;
  int? jarak;
  String? status;
  String? createdAt;
  String? updatedAt;
  Mitra? mitra;
  Alamat? alamat;
  Customer? customer;
  ModelHair? model;

  Transaksi(
      {this.id,
      this.idtukang,
      this.idcustomer,
      this.idmodel,
      this.idalamat,
      this.codetransaksi,
      this.totalharga,
      this.hargacukur,
      this.promo,
      this.penanganan,
      this.hargalayanan,
      this.jarak,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.mitra,
      this.alamat,
      this.customer,
      this.model});

  Transaksi.withError(String errorMessage) {
    errorMessage = errorMessage;
  }

  Transaksi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idtukang = json['idtukang'];
    idcustomer = json['idcustomer'];
    idmodel = json['idmodel'];
    idalamat = json['idalamat'];
    codetransaksi = json['codetransaksi'];
    totalharga = json['totalharga'];
    hargacukur = json['hargacukur'];
    promo = json['promo'];
    penanganan = json['penanganan'];
    hargalayanan = json['hargalayanan'];
    jarak = json['jarak'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    mitra = json['mitra'] != null ? new Mitra.fromJson(json['mitra']) : null;
    alamat =
        json['alamat'] != null ? new Alamat.fromJson(json['alamat']) : null;
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    model =
        json['model'] != null ? new ModelHair.fromJson(json['model']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idtukang'] = this.idtukang;
    data['idcustomer'] = this.idcustomer;
    data['idmodel'] = this.idmodel;
    data['idalamat'] = this.idalamat;
    data['codetransaksi'] = this.codetransaksi;
    data['totalharga'] = this.totalharga;
    data['hargacukur'] = this.hargacukur;
    data['promo'] = this.promo;
    data['penanganan'] = this.penanganan;
    data['hargalayanan'] = this.hargalayanan;
    data['jarak'] = this.jarak;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.mitra != null) {
      data['mitra'] = this.mitra!.toJson();
    }
    if (this.alamat != null) {
      data['alamat'] = this.alamat!.toJson();
    }
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.model != null) {
      data['model'] = this.model!.toJson();
    }
    return data;
  }
}
