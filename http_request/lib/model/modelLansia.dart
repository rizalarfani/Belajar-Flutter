import 'dart:convert';
import 'package:flutter/foundation.dart';

class Lansia {
  String name;
  String alamat;
  String jk;
  String foto;

  Lansia({this.name,this.alamat,this.jk,this.foto});

  factory Lansia.fromJson(Map<String, dynamic> map)
  {
    return Lansia(name: map["NAMA"], alamat: map["ALAMAT"], jk: map["JENIS_KELAMIN"], foto: map['FOTO_PRIBADI']);
  }

  Map<String, dynamic> toJson () {
    return {"name" : name,"alamat" : alamat, "jk" : jk, 'foto' : foto};
  }

  @override
  String toString ()
  {
    return 'Lansia{name: $name,alamat: $alamat,jk: $jk,foto: $foto}';
  }
}

List<Lansia> listLansia(String jsonData) {
  final data = json.decode(jsonData);
  List<dynamic> listLansia = (data as Map<String, dynamic>)['result'];
  return List<Lansia>.from(listLansia.map((item) => Lansia.fromJson(item)));
}

String getLansiaToJson (Lansia data)
{
  final jsonData = data.toJson();
  return json.encode(jsonData);
}