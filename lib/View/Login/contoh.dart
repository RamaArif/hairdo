class Transaksi {
  List<Transaksis>? transaksis;

  Transaksi({this.transaksis});

  Transaksi.fromJson(Map<String, dynamic> json) {
    if (json['transaksis'] != null) {
      transaksis = <Transaksis>[];
      json['transaksis'].forEach((v) {
        transaksis!.add(new Transaksis.fromJson(v));
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
}

class Transaksis {
  int? id;
  int? idtukang;
  int? idcustomer;
  int? idmodel;
  int? idalamat;
  Null? idriview;
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
  Model? model;
  Alamat? alamat;

  Transaksis(
      {this.id,
      this.idtukang,
      this.idcustomer,
      this.idmodel,
      this.idalamat,
      this.idriview,
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
      this.model,
      this.alamat});

  Transaksis.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idtukang = json['idtukang'];
    idcustomer = json['idcustomer'];
    idmodel = json['idmodel'];
    idalamat = json['idalamat'];
    idriview = json['idriview'];
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
    model = json['model'] != null ? new Model.fromJson(json['model']) : null;
    alamat =
        json['alamat'] != null ? new Alamat.fromJson(json['alamat']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idtukang'] = this.idtukang;
    data['idcustomer'] = this.idcustomer;
    data['idmodel'] = this.idmodel;
    data['idalamat'] = this.idalamat;
    data['idriview'] = this.idriview;
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
    if (this.model != null) {
      data['model'] = this.model!.toJson();
    }
    if (this.alamat != null) {
      data['alamat'] = this.alamat!.toJson();
    }
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
  double? lat;
  double? lng;
  String? createdAt;
  String? updatedAt;

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
      this.lat,
      this.lng,
      this.createdAt,
      this.updatedAt});

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
    lat = json['lat'];
    lng = json['lng'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Model {
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

  Model(
      {this.id,
      this.namaModel,
      this.photo1,
      this.photo2,
      this.photo3,
      this.kategori,
      this.jenisModel,
      this.detail,
      this.createdAt,
      this.updatedAt});

  Model.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class Alamat {
  int? id;
  String? tag;
  String? nama;
  String? uidCustomer;
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
      this.tag,
      this.nama,
      this.uidCustomer,
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
    tag = json['tag'];
    nama = json['nama'];
    uidCustomer = json['uidCustomer'];
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
    data['tag'] = this.tag;
    data['nama'] = this.nama;
    data['uidCustomer'] = this.uidCustomer;
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
