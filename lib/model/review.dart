import 'package:omahdilit/model/customer.dart';
import 'package:omahdilit/model/transaksi.dart';

class ListReview {
  List<ReviewModel>? review;

  ListReview({this.review});

  ListReview.withError(String errorMessage) {
    errorMessage = errorMessage;
  }

  ListReview.fromJson(Map<String, dynamic> json) {
    if (json['reviews'] != null) {
      review = <ReviewModel>[];
      json['reviews'].forEach((v) {
        review!.add(new ReviewModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.review != null) {
      data['review'] = this.review!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReviewModel {
  int? id;
  int? idtransaksi;
  int? rating;
  String? review;
  String? createdAt;
  String? updatedAt;
  Customer? customer;
  List<ImageReview>? image;

  ReviewModel(
      {this.id,
      this.idtransaksi,
      this.rating,
      this.review,
      this.createdAt,
      this.image,
      this.updatedAt,
      this.customer});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idtransaksi = json['idtransaksi'];
    rating = json['rating'];
    review = json['review'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    if (json['image'] != null) {
      image = <ImageReview>[];
      json['image'].forEach((v) {
        image!.add(new ImageReview.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idtransaksi'] = this.idtransaksi;
    data['rating'] = this.rating;
    data['review'] = this.review;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.image != null) {
      data['image'] = this.image!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ImageReview {
  int? id;
  int? idreview;
  String? name;
  String? createdAt;
  String? updatedAt;

  ImageReview(
      {this.id, this.idreview, this.name, this.createdAt, this.updatedAt});

  ImageReview.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idreview = json['idreview'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idreview'] = this.idreview;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
