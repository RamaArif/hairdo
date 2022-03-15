class ListAlamat {
  List<Alamat>? alamat;

  ListAlamat({this.alamat});

  ListAlamat.fromJson(Map<String, dynamic> json) {
    if (json['alamat'] != null) {
      alamat = <Alamat>[];
      json['alamat'].forEach((v) {
        alamat!.add(new Alamat.fromJson(v));
      });
    }
  }

  ListAlamat.withError(String errorMessage) {
    errorMessage = errorMessage;
  }

  get error => null;

  get errorMessage => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.alamat != null) {
      data['alamat'] = this.alamat!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Alamat {
  int? id;
  String? uidCustomer;
  String? tag;
  String? nama;
  String? noTelp;
  String? alamat;
  String? provinsi;
  String? kota;
  String? kecamatan;
  double? lat;
  double? lng;
  int? utama;
  String? createdAt;
  String? updatedAt;

  Alamat(
      {this.id,
      this.uidCustomer,
      this.tag,
      this.nama,
      this.noTelp,
      this.alamat,
      this.provinsi,
      this.kota,
      this.kecamatan,
      this.lat,
      this.lng,
      this.utama,
      this.createdAt,
      this.updatedAt});

  Alamat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uidCustomer = json['uidCustomer'];
    tag = json['tag'];
    nama = json['nama'];
    noTelp = json['noTelp'];
    alamat = json['alamat'];
    provinsi = json['provinsi'];
    kota = json['kota'];
    kecamatan = json['kecamatan'];
    lat = json['lat'];
    lng = json['lng'];
    utama = json['utama'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uidCustomer'] = this.uidCustomer;
    data['tag'] = this.tag;
    data['nama'] = this.nama;
    data['noTelp'] = this.noTelp;
    data['alamat'] = this.alamat;
    data['provinsi'] = this.provinsi;
    data['kota'] = this.kota;
    data['kecamatan'] = this.kecamatan;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['utama'] = this.utama;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
