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
  String? tag;
  String? nama;
  String? alamat;
  String? provinsi;
  String? kota;
  String? kecamatan;
  String? noTelp;
  double? lat;
  double? lng;
  bool? utama;

  Alamat(
      {this.id,
      this.tag,
      this.alamat,
      this.provinsi,
      this.kota,
      this.kecamatan,
      this.noTelp,
      this.lat,
      this.lng,
      this.utama});

  Alamat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tag = json['tag'];
    alamat = json['alamat'];
    provinsi = json['provinsi'];
    kota = json['kota'];
    kecamatan = json['kecamatan'];
    noTelp = json['no_telp'];
    lat = json['lat'];
    lng = json['lng'];
    utama = json['utama'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tag'] = this.tag;
    data['alamat'] = this.alamat;
    data['provinsi'] = this.provinsi;
    data['kota'] = this.kota;
    data['kecamatan'] = this.kecamatan;
    data['no_telp'] = this.noTelp;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['utama'] = this.utama;
    return data;
  }
}
