class Customer {
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

  Customer(
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

  Customer.fromJson(Map<String, dynamic> json) {
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
