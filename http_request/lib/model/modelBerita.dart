import 'package:flutter/material.dart';
import 'dart:convert';

class  Berita {
  String id_berita;
  String judul;
  String aouthor;
  String foto;

  Berita({this.id_berita,this.judul,this.aouthor,this.foto});

  factory Berita.fromJson(Map<String, dynamic> map)
  {
    return Berita(id_berita: map["ID_BERITA"],judul: map["JUDUL"],aouthor: map["AUTHOR"],foto: map["FOTO"]);
  }

  Map<String, dynamic> toJson ()
  {
    return {"id_berita" : id_berita,"judul" : judul,"aouthor" : aouthor,"foto" : foto};
  }

  @override
  String toString ()
  {
    return 'Berita{id_berita: $id_berita,judul: $judul,aouthor: $aouthor,foto: $foto}';
  }
}

List<Berita> listBerita(String jsonData) {
  final response = json.decode(jsonData);
  List<dynamic> listBerita = (response as Map<String, dynamic>)['result'];
  return List<Berita>.from(listBerita.map((item) => Berita.fromJson(item)));
}

String getBeritaToJson (Berita data)
{
   final jsonData = data.toJson();
  return json.encode(jsonData);
}