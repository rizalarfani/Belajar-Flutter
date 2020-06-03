import 'dart:convert';

class Lansia {
  String id;
  String name;
  String alamat;
  String jk;
  String foto;

  Lansia({this.name,this.alamat,this.jk,this.foto,this.id});

  factory Lansia.fromJson(Map<String, dynamic> map)
  {
    return Lansia(name: map["NAMA"], alamat: map["ALAMAT"], jk: map["JENIS_KELAMIN"], foto: map['FOTO_PRIBADI'],id: map['ID']);
  }

  Map<String, dynamic> toJson () {
    return {"name" : name,"alamat" : alamat, "jk" : jk, 'foto' : foto,"id" : id};
  }

  @override
  String toString ()
  {
    return 'Lansia{name: $name,alamat: $alamat,jk: $jk,foto: $foto,id: $id}';
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

class Users {
  String lastname;
  String firstname;
  String id;

  Users({this.firstname,this.lastname,this.id});

  factory Users.fromJson(Map<String,dynamic> map) {
    return Users(firstname: map['first_name'],lastname: map['last_name'],id: map['id']);
  }
}

List<Users> listUser(String jsonData) {
  List<dynamic> listUser = (jsonData as Map<String,dynamic>)['result'];
  return List<Users>.from(listUser.map((item) => Users.fromJson(item))); 
}

class DetailLansia {
  String nama;
  String fotoPribadi;
  DetailLansia({this.nama,this.fotoPribadi});
}