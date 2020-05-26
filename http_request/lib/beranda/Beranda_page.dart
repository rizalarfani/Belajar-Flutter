import 'package:flutter/material.dart';
import 'package:http_request/beranda/Beranda_AppBar.dart';
import 'package:http_request/constans.dart';
import 'package:http_request/lansia/List_lansia.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http_request/model/ApiService.dart';
import 'package:http_request/model/modelBerita.dart';

class Beranda_page extends StatefulWidget {
  @override
  _Beranda_pageState createState() => _Beranda_pageState();
}

class _Beranda_pageState extends State<Beranda_page> {
  ApiService apiService;
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiService = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Beranda_AppBar(),
      body: _buildBerandaPage(),
    );
  }

  Widget _buildBerandaPage() {
    return Container(
      color: Colors_page.grey,
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: <Widget>[
          auotoPlaySlider,
          Container(
            padding: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
            color: Colors.white,
            child: Column(
              children: <Widget>[
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
            "Berita Terbaru",
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
          onTap: (){

          },
          child: Container(
            width: 200.0,
            margin: EdgeInsets.only(right: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(35)),
                    child: Image.asset(
                      'assets/slider/slider_2.jpg',
                      width: 200.0,
                      height: 150.0,
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

  Widget _buildJempolanService() {
    return SizedBox(
      width: double.infinity,
      height: 120.0,
      child: Container(
        margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
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
            Container(
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
                            Icons.devices_other,
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
          Container(
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
          Container(
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
        ],
      ),
    );
  }
}
