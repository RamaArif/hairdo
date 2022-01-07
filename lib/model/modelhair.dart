class ModelHair {
  int? id;
  String? namaModel;
  String? photo1;
  String? photo2;
  String? photo3;
  String? kategori;
  String? jenisModel;
  String? detail;
  int? rating;
  int? totalreview;
  String? createdAt;
  String? updatedAt;

  ModelHair(
      {this.id,
      this.namaModel,
      this.photo1,
      this.photo2,
      this.photo3,
      this.kategori,
      this.jenisModel,
      this.detail,
      this.rating,
      this.totalreview,
      this.createdAt,
      this.updatedAt});

  ModelHair.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaModel = json['nama_model'];
    photo1 = json['photo1'];
    photo2 = json['photo2'];
    photo3 = json['photo3'];
    kategori = json['kategori'];
    jenisModel = json['jenis_model'];
    detail = json['detail'];
    rating = json['rating'];
    totalreview = json['totalreview'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    data['rating'] = this.rating;
    data['totalreview'] = this.totalreview;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
