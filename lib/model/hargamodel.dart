class HargaModel {
  int? id;
  int? hargaperkilo;
  int? harga;
  String? createdAt;
  String? updatedAt;

  HargaModel(
      {this.id, this.hargaperkilo, this.harga, this.createdAt, this.updatedAt});

  HargaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hargaperkilo = json['hargaperkilo'];
    harga = json['harga'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hargaperkilo'] = this.hargaperkilo;
    data['harga'] = this.harga;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
