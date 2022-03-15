import 'package:omahdilit/model/review.dart';

class ModelHome {
  List<ModelHair>? model;

  ModelHome({this.model});

  ModelHome.fromJson(Map<String, dynamic> json) {
    if (json['model'] != null) {
      model = <ModelHair>[];
      json['model'].forEach((v) {
        model!.add(new ModelHair.fromJson(v));
      });
    }
  }

  ModelHome.withError(String errorMessage) {
    errorMessage = errorMessage;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.model != null) {
      data['model'] = this.model!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ModelHair {
  int? id;
  String? namaModel;
  String? photo1;
  String? photo2;
  String? photo3;
  String? kategori;
  String? jenisModel;
  String? detail;
  String? createdAt;
  String? updatedAt;
  List<ReviewModel>? reviews;

  ModelHair(
      {this.id,
      this.namaModel,
      this.photo1,
      this.photo2,
      this.photo3,
      this.kategori,
      this.jenisModel,
      this.detail,
      this.createdAt,
      this.updatedAt,
      this.reviews});

  ModelHair.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaModel = json['nama_model'];
    photo1 = json['photo1'];
    photo2 = json['photo2'];
    photo3 = json['photo3'];
    kategori = json['kategori'];
    jenisModel = json['jenis_model'];
    detail = json['detail'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    data['nama_model'] = this.namaModel;
    data['photo1'] = this.photo1;
    data['photo2'] = this.photo2;
    data['photo3'] = this.photo3;
    data['kategori'] = this.kategori;
    data['jenis_model'] = this.jenisModel;
    data['detail'] = this.detail;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
