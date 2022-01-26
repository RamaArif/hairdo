class ListReview {
  List<Review>? review;

  ListReview({this.review});

  ListReview.fromJson(Map<String, dynamic> json) {
    if (json['review'] != null) {
      review = <Review>[];
      json['review'].forEach((v) {
        review!.add(new Review.fromJson(v));
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

class Review {
  int? id;
  String? codeTransaksi;
  String? review;
  int? rating;
  String? createdAt;
  CustomerReview? customer;

  Review(
      {this.id,
      this.codeTransaksi,
      this.review,
      this.rating,
      this.createdAt,
      this.customer});

  Review.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    codeTransaksi = json['code_transaksi'];
    review = json['review'];
    rating = json['rating'];
    createdAt = json['created_at'];
    customer = json['customer'] != null
        ? new CustomerReview.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code_transaksi'] = this.codeTransaksi;
    data['review'] = this.review;
    data['rating'] = this.rating;
    data['created_at'] = this.createdAt;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    return data;
  }
}

class CustomerReview {
  String? name;
  String? photo;

  CustomerReview({this.name, this.photo});

  CustomerReview.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['photo'] = this.photo;
    return data;
  }
}
