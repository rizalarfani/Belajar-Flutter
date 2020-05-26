import 'package:http_request/model/modelLansia.dart';
import 'package:http_request/model/modelBerita.dart';
import 'package:http/http.dart' show Client;
import 'dart:async';

class ApiService {
  final String baseUrl = "http://10.0.3.2/jempolan";
  Client client = Client();
  Future<List<Lansia>> getLansia() async {
    final response = await client.get("$baseUrl/ApiLansia");
    if (response.statusCode == 200) {
      return listLansia(response.body);
    } else {
      print("Erorr Kode");
    }
  }

  Future<List<Berita>> getBerita() async {
    final response = await client.get("$baseUrl/ApiLansia/berita");
    if (response.statusCode == 200) {
      return listBerita(response.body);
    } else {
       print("Erorr Kode");
    }
  } 

}