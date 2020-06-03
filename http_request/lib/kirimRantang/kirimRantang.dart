import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class KirimRantang extends StatefulWidget {
  final String id;
  KirimRantang({this.id});
  @override
  _KirimRantangState createState() => _KirimRantangState(idLansia: id);
}

class _KirimRantangState extends State<KirimRantang> {
  _KirimRantangState({this.idLansia});
  String idLansia;
  String _nama;
  String _nik;
  String _alamat;
  String _foto;

  TextEditingController _keterangan = TextEditingController();
  bool _isFieldValid;
  bool _isLoading = false;

  Future<dynamic> getDetailLansia(id) async {
    final response = await http
        .get("http://192.168.43.74/jempolan/ApiLansia/detailLansia?id=$id");
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Map<String, dynamic> value = result['result'];
      setState(() {
        _nama = value['NAMA'];
        _nik = value['NIK'];
        _alamat = value['ALAMAT'];
        _foto = value['FOTO_PRIBADI'];
        print(_foto);
      });
    } else {
      print("GAGAL");
    }
  }

  @override
  void initState() {
    super.initState();
    getDetailLansia(idLansia);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            backgroundColor: Colors.blueAccent,
            leading: Image.asset(
              "assets/logo/logo_jempolan.png",
              height: 25.0,
              width: 25.0,
            ),
            title: Text("JEMPOLAN"),
          ),
          body: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(right: 15.0, left: 15.0),
                width: double.infinity,
                height: 200.0,
                decoration: BoxDecoration(color: Colors.lightBlueAccent),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8),
                        ),
                        Text(
                          _nama.toString(),
                          style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          _nik.toString(),
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          _alamat.toString(),
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ],
                    ),
                    // CircleAvatar(
                    //   backgroundImage: NetworkImage(
                    //       "https://jempolan.tegalkota.go.id/uploads/pribadi/" +
                    //           _foto.toString()),
                    // ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment(0, 0.8),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)
                    ),
                    color: Colors.white
                  ),
                  child: ListView(
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextField(
                            controller: _keterangan,
                            onChanged: (value) {
                              bool _isField = value.trim().isNotEmpty;
                              if(_isField != _isFieldValid) {
                                setState(() {
                                  _isFieldValid = _isField;
                                });
                              }
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              errorText: _isFieldValid == null || _isFieldValid ? null : "Keterangan Wajib disi",
                              prefixIcon: Icon(Icons.info),
                              labelText: "Masukan Keterangan"
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
