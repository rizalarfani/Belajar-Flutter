import 'package:flutter/material.dart';
import 'package:http_request/buku_tamu/AppBarBukuTamu.dart';
import 'package:http_request/model/ApiService.dart';

class AddBukuTamu extends StatefulWidget {
  @override
  _AddBukuTamuState createState() => _AddBukuTamuState();
}

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class _AddBukuTamuState extends State<AddBukuTamu> {
  bool isLoading = false;
  bool _validName;
  bool _validJudul;
  bool _validKet;
  TextEditingController name = TextEditingController();
  TextEditingController judul = TextEditingController();
  TextEditingController keterangan = TextEditingController();
  ApiService apiService = ApiService();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        key: _scaffoldState,
        appBar: AppBarBukuTamu(),
        body: _widgetAddBukuTamu(),
      ),
    );
  }

  Widget _widgetAddBukuTamu() {
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(right: 15.0, left: 15.0),
          width: double.infinity,
          height: 300.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(35)),
              color: Colors.lightBlueAccent),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 200.0,
                child: Text(
                  "Add Buku Tamu",
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Image.asset(
                "assets/logo/logo_jempolan.png",
                height: 130.0,
                width: 130.0,
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment(0, 0.8),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                color: Colors.white),
            child: Container(
              margin: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: name,
                    onChanged: (value) {
                      bool _isFiledValid = value.trim().isNotEmpty;
                      if (_isFiledValid != _validName) {
                        setState(() {
                          _validName = _isFiledValid;
                        });
                      }
                    },
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        labelText: "Masukan Nama",
                        prefixIcon: Icon(Icons.person_add),
                        errorText: _validName == null || _validName
                            ? null
                            : "Wajib di isi"),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: judul,
                    onChanged: (value) {
                      bool _isFiledValid = value.trim().isNotEmpty;
                      if (_isFiledValid != _validJudul) {
                        setState(() {
                          _validJudul = _isFiledValid;
                        });
                      }
                    },
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        labelText: "Masukan Judul buku",
                        prefixIcon: Icon(Icons.book),
                        errorText: _validJudul == null || _validJudul
                            ? null
                            : "Wajing di isi"),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: keterangan,
                    onChanged: (value) {
                      bool _isFiledValid = value.trim().isNotEmpty;
                      if (_isFiledValid != _validKet) {
                        setState(() {
                          _validKet = _isFiledValid;
                        });
                      }
                    },
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        labelText: "Masukan Keterangan",
                        prefixIcon: Icon(Icons.info),
                        errorText: _validKet == null || _validKet
                            ? null
                            : "Harus di isi"),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  RaisedButton(
                      onPressed: () {
                        if (_validName == null ||
                            _validJudul == null ||
                            _validKet == null) {
                          _scaffoldState.currentState.showSnackBar(SnackBar(
                            backgroundColor: Colors.redAccent,
                            content: Text("From Masih Ada yang kosong"),
                          ));
                          return;
                        }
                        setState(() {
                          isLoading = true;
                        });
                        String _name = name.text;
                        String _judul = judul.text;
                        String _keterangan = keterangan.text;
                        apiService
                            .addBukuTamu(_name, _judul, _keterangan)
                            .then((value) {
                          setState(() {
                            isLoading = false;
                          });
                          if (value['status'] == 200) {
                            _scaffoldState.currentState.showSnackBar(SnackBar(
                              backgroundColor: Colors.redAccent,
                              content: Text("Berhasil add buku tamu"),
                            ));
                            setState(() {
                              name.text = "";
                              judul.text = "";
                              keterangan.text = "";
                            });
                          } else {
                            _scaffoldState.currentState.showSnackBar(SnackBar(
                              backgroundColor: Colors.redAccent,
                              content: Text("Gagal Tambah Buku Tamu"),
                            ));
                          }
                        });
                      },
                      hoverColor: Colors.blueAccent,
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
                              "Krim Buku Tamu",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
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
