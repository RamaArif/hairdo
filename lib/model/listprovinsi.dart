class ListProvinsi {
  Rajaongkir? rajaongkir;

  ListProvinsi({this.rajaongkir});
  ListProvinsi.withError(String errorMessage) {
    errorMessage = errorMessage;
  }
  ListProvinsi.fromJson(Map<String, dynamic> json) {
    rajaongkir = json['rajaongkir'] != null
        ? new Rajaongkir.fromJson(json['rajaongkir'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.rajaongkir != null) {
      data['rajaongkir'] = this.rajaongkir!.toJson();
    }
    return data;
  }
}

class Rajaongkir {
  List<Provinsi>? results;

  Rajaongkir({this.results});

  Rajaongkir.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Provinsi>[];
      json['results'].forEach((v) {
        results!.add(new Provinsi.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Provinsi {
  String? provinceId;
  String? province;

  Provinsi({this.provinceId, this.province});

  Provinsi.fromJson(Map<String, dynamic> json) {
    provinceId = json['province_id'];
    province = json['province'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['province_id'] = this.provinceId;
    data['province'] = this.province;
    return data;
  }
}
