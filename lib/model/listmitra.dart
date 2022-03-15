import 'package:omahdilit/model/detailmitra.dart';

class ListMitra {
  List<Mitra>? mitracowok;
  List<Mitra>? mitracewek;

  ListMitra({this.mitracowok, this.mitracewek});

  ListMitra.fromJson(Map<String, dynamic> json) {
    if (json['mitracowok'] != null) {
      mitracowok = <Mitra>[];
      json['mitracowok'].forEach((v) {
        mitracowok!.add(new Mitra.fromJson(v));
      });
    }
    if (json['mitracewek'] != null) {
      mitracewek = <Mitra>[];
      json['mitracewek'].forEach((v) {
        mitracewek!.add(new Mitra.fromJson(v));
      });
    }
  }

  ListMitra.withError(String errorMessage) {
    errorMessage = errorMessage;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mitracowok != null) {
      data['mitracowok'] = this.mitracowok!.map((v) => v.toJson()).toList();
    }
    if (this.mitracewek != null) {
      data['mitracewek'] = this.mitracewek!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListMitraFavorite {
  List<Mitra>? mitra;
  bool? error;
  String? errorMessage;

  ListMitraFavorite({this.mitra, this.error});

  ListMitraFavorite.withError(String errorMessage) {
    errorMessage = errorMessage;
  }

  ListMitraFavorite.fromJson(Map<String, dynamic> json) {
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
