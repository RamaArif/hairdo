import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:omahdilit/model/listmitra.dart';

Future<List<Mitra>> getMitraFavorite() async {
  var url = Uri.parse('http://omahdilit.my.id/public/api/mitrafavorite');
  var response = await http.get(url);
  var body = json.decode(response.body);
  ListMitra lm = ListMitra.fromJson(body);
  List<Mitra> m = lm.mitra!;
  print("error e cok = " + m[0].name.toString());
  return m;
}