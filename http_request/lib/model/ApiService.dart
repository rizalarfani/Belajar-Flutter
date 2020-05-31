import 'package:http_request/model/modelLansia.dart';
import 'package:http_request/model/modelBerita.dart';
import 'package:http/http.dart' show Client;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String baseUrl = "http://10.0.3.2/jempolan";
  Client client = Client();

  getPrev() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("kode_pdm");
  }

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

  Future<dynamic> login(String username,String password) async {
    final response = await client.post("$baseUrl/ApiLansia/login",
      body: {
        "username" : username,
        "password" : password
      }
    );
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return result;
    } else if (response.statusCode == 404) {
      final result = json.decode(response.body);
      return result;
    }
  }

  Future<dynamic> addBukuTamu(String name,String judul,String ket) async {
    final response = await client.post("$baseUrl/ApiLansia/AddBukuTamu",body: {
      "nama" : name,
      "judul" : judul,
      "keterangan" : ket,
    });
    if(response.statusCode == 200){
      final result = jsonDecode(response.body);
      return result;
    } else {
      final result = jsonDecode(response.body);
      return result;
    }
  }

  Future<dynamic> jumlahHistory(String kodepdm) async {
    final response = await client.get("$baseUrl/ApiLansia/infoJumlah?kode_pendamping=$kodepdm");
    if (response.statusCode == 200){
      final result = jsonDecode(response.body);
      return result;
    } else {
      final result = jsonDecode(response.body);
      return result;
    }
  }

}