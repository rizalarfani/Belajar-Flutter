import 'package:flutter/material.dart';
import 'package:http_request/kirimRantang/AppBarSend.dart';
import 'package:http_request/landing/Landing_page.dart';
import 'dart:io';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SendRantang extends StatefulWidget {
  String idLansia;
  SendRantang({this.idLansia});
  @override
  _SendRantangState createState() => _SendRantangState(idLansia: idLansia);
}

class _SendRantangState extends State<SendRantang> {
  String idLansia;
  _SendRantangState({this.idLansia});
  TextEditingController _keterangan = TextEditingController();
  bool isLoading = false;
  bool _isFieldKet;
  List listDetailLansia;
  File _image;

  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  Future<File> getImageCam() async {
    var img = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = img;
    });
  }

  String _name;
  String _nik;
  String _alamat;
  String _foto;
  Future<dynamic> getLansiaDetail() async {
    final response = await http.get(
        "http://192.168.43.74/jempolan/ApiLansia/detailLansia?id=$idLansia");
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Map<String, dynamic> dataResult = result['result'];
      setState(() {
        _name = dataResult['NAMA'];
        _nik = dataResult['NIK'];
        _alamat = dataResult['ALAMAT'];
        _foto = dataResult['FOTO_PRIBADI'];
      });
    } else {
      print("Gagal");
    }
  }

  Future<dynamic> uploadImage(File imageFile) async {
    var uri =
        Uri.parse("http://192.168.43.74/jempolan/ApiLansia/AddSendRantang");
    var request = new http.MultipartRequest("POST", uri);
    var multiPartFile =
        await http.MultipartFile.fromPath("FOTO_BUKTI", imageFile.path);
    String kodePdm;
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      kodePdm = pref.getString("kode_pdm");
    });

    request.fields['KD_PDM'] = kodePdm;
    request.fields['NIK'] = _nik;
    request.fields['ALAMAT'] = _alamat;
    request.fields['KETERANGAN'] = _keterangan.text;
    request.files.add(multiPartFile);
    var response = await request.send();
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
        _keterangan.text = "";
      });
      _scaffoldState.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Colors.greenAccent,
          content: Text(
            "Berhasil Send Rantang",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Landingpage()));
      });
    } else {
      print("Gagal");
    }
  }

  @override
  void initState() {
    super.initState();
    getLansiaDetail();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldState,
        appBar: AppBarSend(),
        body: _buildSend(idLansia),
        floatingActionButton: FloatingActionButton(
          onPressed: () => getImageCam(),
          child: Icon(Icons.photo),
        ),
      ),
    );
  }

  Widget _buildSend(id) {
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        ListView(
          physics: ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
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
                        _name.toString(),
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
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.6,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      controller: _keterangan,
                      maxLines: 3,
                      onChanged: (value) {
                        bool _isFieldValid = value.trim().isNotEmpty;
                        if (_isFieldValid != _isFieldKet) {
                          setState(() {
                            _isFieldKet = _isFieldValid;
                          });
                        }
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        fillColor: Colors.blueAccent,
                        labelText: "Masukan Keterangan",
                        prefixIcon: Icon(Icons.info),
                        errorText: _isFieldKet == null || _isFieldKet
                            ? null
                            : "Wajib di isi",
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width / 1.1,
                          color: Colors.white,
                          child: _image == null
                              ? Center(
                                  child: Text("Belum Ada Image Yang di Upload"),
                                )
                              : Image.file(_image),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    RaisedButton(
                      onPressed: () {
                        if (_keterangan == null || _image == null) {
                          _scaffoldState.currentState.showSnackBar(SnackBar(
                            backgroundColor: Colors.redAccent,
                            content: Text(
                              "Maaf masih ada form yang kosong",
                              style: TextStyle(color: Colors.white),
                            ),
                          ));
                        }
                        setState(() {
                          isLoading = true;
                        });
                        uploadImage(_image);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      textColor: Colors.white,
                      color: Colors.lightBlueAccent,
                      child: Container(
                        height: 45.0,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.send,
                              size: 25,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 30.0,
                            ),
                            Text(
                              "Simpan",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        isLoading
            ? Stack(
                children: <Widget>[
                  Opacity(
                    opacity: 0.3,
                    child: ModalBarrier(
                      dismissible: false,
                      color: Colors.grey,
                    ),
                  ),
                  Center(
                    child: CircularProgressIndicator(),
                  )
                ],
              )
            : Container()
      ],
    );
  }
}
