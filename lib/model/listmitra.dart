class ListMitra {
  List<Mitra>? mitra;
  bool? error;

  ListMitra({this.mitra, this.error});

  ListMitra.fromJson(Map<String, dynamic> json) {
    if (json['mitra'] != null) {
      mitra = [];
      json['mitra'].forEach((v) {
        mitra!.add(new Mitra.fromJson(v));
      });
    }
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mitra != null) {
      data['mitra'] = this.mitra!.map((v) => v.toJson()).toList();
    }
    data['error'] = this.error;
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
    workshop = json['workshop'];
    lat = json['lat'];
    lng = json['lng'];
    rating = json['rating'];
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
    data['workshop'] = this.workshop;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['rating'] = this.rating;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
