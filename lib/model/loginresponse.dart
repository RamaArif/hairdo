import 'package:omahdilit/model/customer.dart';

class LoginResponse {
  bool? error;
  Customer? customer;

  LoginResponse({this.error, this.customer});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    return data;
  }
  LoginResponse.withError(String errorMessage) {
    errorMessage = errorMessage;
  }
}
