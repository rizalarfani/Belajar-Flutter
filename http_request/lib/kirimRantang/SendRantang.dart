import 'package:flutter/material.dart';
import 'package:http_request/kirimRantang/AppBarSend.dart';

class SendRantang extends StatefulWidget {
  @override
  _SendRantangState createState() => _SendRantangState();
}

class _SendRantangState extends State<SendRantang> {
  TextEditingController _keterangan = TextEditingController();
  bool isLoading = false;
  bool _isFieldKet;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBarSend(),
        body: _buildSend(),
        floatingActionButton: FloatingActionButton(
          onPressed: (){},
          child: Icon(Icons.photo),
        ),
      ),
    );
  }

  Widget _buildSend() {
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
                        "Nama Lansia",
                        style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Nik Lansia",
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Alamat Lansia",
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
                    SizedBox(height: 20,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width / 1.1,
                          color: Colors.white,
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
