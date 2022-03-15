import 'package:omahdilit/model/review.dart';
import 'package:omahdilit/model/transaksi.dart';

class DetailMitra {
  Mitra? detail;
  String? rating;
  int? total;

  DetailMitra({this.detail, this.rating, this.total});

  DetailMitra.fromJson(Map<String, dynamic> json) {
    detail = json['detail'] != null ? new Mitra.fromJson(json['detail']) : null;
    rating = json['rating'];
    total = json['total'];
  }
  DetailMitra.withError(String errorMessage) {
    errorMessage = errorMessage;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.detail != null) {
      data['detail'] = this.detail!.toJson();
    }
    data['rating'] = this.rating;
    data['total'] = this.total;
    return data;
  }
}

class Mitra {
  int? id;
  String? name;
  String? addres;
  String? number;
  String? email;
  String? jenkel;
  String? uid;
  String? pushtoken;
  String? photo;
  String? status;
  String? workshop;
  double? lat;
  double? lng;
  double? rating;
  String? createdAt;
  String? updatedAt;
  List<Transaksi>? transaksis;
  List<ReviewModel>? reviews;

  Mitra(
      {this.id,
      this.name,
      this.addres,
      this.number,
      this.email,
      this.jenkel,
      this.uid,
      this.pushtoken,
      this.photo,
      this.status,
      this.workshop,
      this.lat,
      this.lng,
      this.rating,
      this.createdAt,
      this.updatedAt,
      this.transaksis,
      this.reviews});

  Mitra.withError(String errorMessage) {
    errorMessage = errorMessage;
  }

  Mitra.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    addres = json['addres'];
    number = json['number'];
    email = json['email'];
    jenkel = json['jenkel'];
    uid = json['uid'];
    pushtoken = json['pushtoken'];
    photo = json['photo'];
    status = json['status'];
    workshop = json['workshop'];
    lat = json['lat'];
    lng = json['lng'];
    rating = json['rating'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['transaksis'] != null) {
      transaksis = <Transaksi>[];
      json['transaksis'].forEach((v) {
        transaksis!.add(new Transaksi.fromJson(v));
      });
    }
    if (json['reviews'] != null) {
      reviews = <ReviewModel>[];
      json['reviews'].forEach((v) {
        reviews!.add(new ReviewModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['addres'] = this.addres;
    data['number'] = this.number;
    data['email'] = this.email;
    data['jenkel'] = this.jenkel;
    data['uid'] = this.uid;
    data['pushtoken'] = this.pushtoken;
    data['photo'] = this.photo;
    data['status'] = this.status;
    data['workshop'] = this.workshop;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['rating'] = this.rating;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.transaksis != null) {
      data['transaksis'] = this.transaksis!.map((v) => v.toJson()).toList();
    }
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
