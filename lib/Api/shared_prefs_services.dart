import 'dart:async';
import 'dart:convert';

import 'package:omahdilit/model/customer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsServices {
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  late SharedPreferences _prefs;

  void saveUser(Customer _customer) async {
    SharedPreferences _prefs = await prefs;
    _prefs.setString('user', jsonEncode(_customer.toJson()));
  }

  void saveFirstOpen() async {
    SharedPreferences _prefs = await prefs;
    _prefs.setBool('firstOpen', false);
  }

  void savePushToken(String token) async {
    SharedPreferences _prefs = await prefs;
    _prefs.setString('pushToken', token);
  }

  void saveUid(String token) async {
    SharedPreferences _prefs = await prefs;
    _prefs.setString('uid', token);
  }

  Future<String?> getUser() async {
    SharedPreferences _pref = await prefs;
    return _pref.getString('user');
  }

  Future<bool?> getFirstOpen() async {
    SharedPreferences _pref = await prefs;
    return _pref.getBool('firstOpen');
  }
}
