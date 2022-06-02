class ListSpotlight {
  List<Spotlight>? spotlight;

  ListSpotlight({this.spotlight});

  ListSpotlight.fromJson(Map<String, dynamic> json) {
    if (json['spotlight'] != null) {
      spotlight = <Spotlight>[];
      json['spotlight'].forEach((v) {
        spotlight!.add(new Spotlight.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.spotlight != null) {
      data['spotlight'] = this.spotlight!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Spotlight {
  int? id;
  String? title;
  String? description;
  String? image;
  String? createdAt;
  String? updatedAt;

  Spotlight(
      {this.id,
      this.title,
      this.description,
      this.image,
      this.createdAt,
      this.updatedAt});

  Spotlight.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
