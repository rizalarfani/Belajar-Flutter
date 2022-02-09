import 'package:flutter/material.dart';
import 'package:http_request/beranda/Beranda_AppBar.dart';
import 'package:http_request/constans.dart';
import 'package:http_request/lansia/List_lansia.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http_request/model/ApiService.dart';
import 'package:http_request/model/modelBerita.dart';
import 'package:http_request/buku_tamu/AddBukuTamu.dart';
import 'package:http_request/kirimRantang/listLansia.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_request/berita/listBerita.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BerandaPage extends StatefulWidget {
  @override
  _BerandaPageState createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  ApiService apiService;
  int jumlah;
  int jumlahAllLansia;
  int jumlahDiDampingi;
  static final List<String> imgSlider = [
    'assets/slider/slider_1.jpg',
    'assets/slider/slider_2.jpg',
    'assets/slider/slider_3.jpg',
    'assets/slider/slider_4.jpg',
    'assets/slider/slider_5.jpg',
    'assets/slider/slider_6.jpg',
  ];

  final CarouselSlider auotoPlaySlider = CarouselSlider(
    items: imgSlider.map((fileImage) {
      return Container(
        color: Colors.white,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Image.asset(
            fileImage,
            width: 1000,
            fit: BoxFit.cover,
          ),
        ),
      );
    }).toList(),
    height: 200.0,
    autoPlay: true,
    enlargeCenterPage: true,
    aspectRatio: 1.0,
  );

  var statusIsLogin;
  var nama;
  var kodePdm;
  getPrev() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      statusIsLogin = pref.getInt("status");
      nama = pref.getString("name");
      kodePdm = pref.getString('kode_pdm');
    });
  }

  void getJumlah() async {
    String kode;
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      kode = pref.getString('kode_pdm');
    });
    final response = await http.get(
        "http://192.168.43.74/jempolan/ApiLansia/infoJumlah?kode_pendamping=$kode");
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      setState(() {
        jumlah = result['jumlahHistory'];
        jumlahAllLansia = result['jumlahLansia'];
        jumlahDiDampingi = result['jumlahLansiaDamping'];
      });
    } else {
      print("Gagal");
    }
  }

  String infoAplikasi;
  Future<dynamic> getContent() async {
    final response =
        await http.get("http://192.168.43.74/jempolan/ApiLansia/content");
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Map<String, dynamic> value = result['resutl'];
      setState(() {
        infoAplikasi = value['TENTANG'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
    getPrev();
    getJumlah();
    getContent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BerandaAppbar(
        statusLogin: statusIsLogin,
        name: nama,
      ),
      body: _buildBerandaPage(),
    );
  }

  Widget _buildBerandaPage() {
    return Container(
      color: Colorspage.grey,
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: <Widget>[
          auotoPlaySlider,
          Container(
            padding: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
            color: Colors.white,
            child: Column(
              children: <Widget>[
                statusIsLogin == null ? Container() : _buildJempolanInfo(),
                _buildJempolanService(),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            margin: EdgeInsets.only(top: 16.0),
            child: Column(
              children: <Widget>[
                _buildBerita(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBerita() {
    return Container(
      padding: EdgeInsets.fromLTRB(16.0, 16.0, 0.0, 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            "Berita Terbaru ",
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          Padding(padding: EdgeInsets.only(top: 5.0)),
          SizedBox(
            height: 200.0,
            child: FutureBuilder(
              future: apiService.getBerita(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Berita>> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                        "Something wrong with message: ${snapshot.error.toString()}"),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  List<Berita> berita = snapshot.data;
                  return _buildRowBerita(berita);
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRowBerita(List<Berita> beritas) {
    return ListView.builder(
      itemCount: beritas == null ? 0 : beritas.length,
      padding: EdgeInsets.only(top: 10.0),
      physics: new ClampingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        Berita berita = beritas[index];
        return GestureDetector(
          onTap: () {},
          child: Container(
            width: 200.0,
            margin: EdgeInsets.only(right: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(35)),
                    child: Image.network(
                      "https://jempolan.tegalkota.go.id/uploads/berita/" +
                          berita.foto,
                      width: 150.0,
                      height: 150.0,
                      fit: BoxFit.cover,
                    )),
                Text(
                  berita.judul,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildJempolanInfo() {
    return Container(
      height: 150.0,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [const Color(0xff3164bd), const Color(0xff295cb5)],
          ),
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [const Color(0xff3164cd), const Color(0xff295cb5)],
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                ),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Nama :",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w800),
                ),
                Text(
                  nama,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w800),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15.0, right: 30.0, left: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          border: Border.all(color: Colors.white)),
                      child: Icon(
                        Icons.folder,
                        color: Colors.white,
                        size: 32.0,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 5.0)),
                    Text(
                      jumlahAllLansia.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          border: Border.all(color: Colors.white)),
                      child: Icon(
                        Icons.person_outline,
                        color: Colors.white,
                        size: 32.0,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 5.0)),
                    Text(
                      jumlahDiDampingi.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          border: Border.all(color: Colors.white)),
                      child: Icon(
                        Icons.history,
                        color: Colors.white,
                        size: 32.0,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 5.0)),
                    Text(
                      jumlah.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildJempolanService() {
    return SizedBox(
      width: double.infinity,
      height: 120.0,
      child: Container(
        margin: EdgeInsets.only(top: 15.0, bottom: 8.0),
        child: GridView.count(
          physics: ClampingScrollPhysics(),
          crossAxisCount: 4,
          children: <Widget>[
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListLansiaPdm(kode: kodePdm))),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueAccent),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          padding: EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.send,
                            color: Colors.blue,
                            size: 30.0,
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 6.0)),
                        Text(
                          "Krim Rantang",
                          style: TextStyle(fontSize: 13.0),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ListLansia()));
              },
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.orangeAccent),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          padding: EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.account_circle,
                            color: Colors.orange,
                            size: 30.0,
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 6.0)),
                        Text(
                          "List Lansia",
                          style: TextStyle(fontSize: 13.0),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddBukuTamu()));
              },
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.purple),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          padding: EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.book,
                            color: Colors.purple,
                            size: 30.0,
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 6.0)),
                        Text(
                          "Buku Tamu",
                          style: TextStyle(fontSize: 13.0),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                showModalBottomSheet<void>(
                    context: context,
                    builder: (context) {
                      return _buildServiceBottomSheet();
                    });
              },
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          padding: EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.apps,
                            color: Colors.grey,
                            size: 30.0,
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 6.0)),
                        Text(
                          "Lainnya",
                          style: TextStyle(fontSize: 13.0),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildServiceBottomSheet() {
    return Container(
      width: double.infinity,
      height: 200.0,
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: GridView.count(
        physics: ClampingScrollPhysics(),
        crossAxisCount: 4,
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueAccent),
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      padding: EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.send,
                        color: Colors.blue,
                        size: 30.0,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 6.0)),
                    Text(
                      "Krim Rantang",
                      style: TextStyle(fontSize: 13.0),
                    ),
                  ],
                )
              ],
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ListLansia()));
            },
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.orangeAccent),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        padding: EdgeInsets.all(10.0),
                        child: Icon(
                          Icons.account_circle,
                          color: Colors.orange,
                          size: 30.0,
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 6.0)),
                      Text(
                        "List Lansia",
                        style: TextStyle(fontSize: 13.0),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddBukuTamu(),
                )),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.purple),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        padding: EdgeInsets.all(10.0),
                        child: Icon(
                          Icons.book,
                          color: Colors.purple,
                          size: 30.0,
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 6.0)),
                      Text(
                        "Buku Tamu",
                        style: TextStyle(fontSize: 13.0),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              showModalBottomSheet<void>(
                  context: context,
                  builder: (context) {
                    return _buildModalInfo();
                  });
            },
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        padding: EdgeInsets.all(10.0),
                        child: Icon(
                          Icons.info,
                          color: Colors.grey,
                          size: 30.0,
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 6.0)),
                      Text(
                        "Info Apilkasi",
                        style: TextStyle(fontSize: 13.0),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.orangeAccent),
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      padding: EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.map,
                        color: Colors.orangeAccent,
                        size: 30.0,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 6.0)),
                    Text(
                      "Peta Lansia",
                      style: TextStyle(fontSize: 13.0),
                    ),
                  ],
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => ListBerita()))
            },
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.amberAccent),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        padding: EdgeInsets.all(10.0),
                        child: Icon(
                          Icons.new_releases,
                          color: Colors.amberAccent,
                          size: 30.0,
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 6.0)),
                      Text(
                        "Berita",
                        style: TextStyle(fontSize: 13.0),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModalInfo() {
    return Container(
      height: 400.0,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                  height: 50.0,
                  width: double.infinity,
                  color: Colors.blueAccent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Apa si Jempolan??",
                        style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  )),
              SizedBox(
                height: 25.0,
              ),
              Container(
                margin: EdgeInsets.all(15),
                child: Text(infoAplikasi.toString(),
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black38)),
              )
            ],
          ),
        ],
      ),
    );
  }
}
