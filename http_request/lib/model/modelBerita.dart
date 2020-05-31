import 'dart:convert';

class  Berita {
  String idBerita;
  String judul;
  String aouthor;
  String foto;
  String created;

  Berita({this.idBerita,this.judul,this.aouthor,this.foto,this.created});

  factory Berita.fromJson(Map<String, dynamic> map)
  {
    return Berita(idBerita: map["ID_BERITA"],judul: map["JUDUL"],aouthor: map["AUTHOR"],foto: map["FOTO"],created: map['CREATED_AT']);
  }

  Map<String, dynamic> toJson ()
  {
    return {"id_berita" : idBerita,"judul" : judul,"aouthor" : aouthor,"foto" : foto,"created": created};
  }

  @override
  String toString ()
  {
    return 'Berita{id_berita: $idBerita,judul: $judul,aouthor: $aouthor,foto: $foto.created: $created}';
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