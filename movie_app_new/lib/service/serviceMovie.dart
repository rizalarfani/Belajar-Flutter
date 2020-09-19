import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app_new/models/index.dart';
import 'package:movie_app_new/network/network.dart';

class ServiceMovie {
  static Future<List<Movie>> getNowPlaying() async {
    final response = await http.get(NetworkUrl.urlNowPlaying);
    final data = jsonDecode(response.body);
    List<Movie> list = [];
    for (Map i in data['results']) {
      list.add(Movie.fromJson(i));
    }
    return list;
  }
}
