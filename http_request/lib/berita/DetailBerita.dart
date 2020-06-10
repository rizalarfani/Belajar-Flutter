import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_request/model/modelBerita.dart';

class DetailBerita extends StatefulWidget {
  String id_berita;
  DetailBerita({this.id_berita});
  @override
  _DetailBeritaState createState() => _DetailBeritaState(id_berita: id_berita);
}

class _DetailBeritaState extends State<DetailBerita> {
  String id_berita;
  _DetailBeritaState({this.id_berita});

  String id;
  String judul;
  String aouthor;
  String foto;
  String created;
  String isiContent;
  Future<String> _getBeritaDetail () async {
    final response = await http.get("http://192.168.43.74/jempolan/ApiLansia/detailBerita?id_berita=$id_berita");
    if(response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Map <String, dynamic> dataResult = result['result'][0];
      setState(() {
        id = dataResult['ID'];
        judul = dataResult['JUDUL'];
        aouthor = dataResult['AUTHOR'];
        foto = dataResult["FOTO"];
        created = dataResult["CREATED_AT"];
        isiContent = dataResult['ISI'];
      });
    }
  }

  @override
  void initState() {
    _getBeritaDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        body: SafeArea(
          child: ListView(
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      ClipRRect(
                        child: Image.asset(
                          'assets/slider/slider_1.jpg',
                          color: Color.fromRGBO(0, 0, 0, 0.4),
                          colorBlendMode: BlendMode.darken,
                          height: MediaQuery.of(context).size.width - 100,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 20.0),
                        height: MediaQuery.of(context).size.width - 100,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              aouthor.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              created.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17.0,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                    color: Colors.white,
                    width: double.infinity,
                    height: 50.0,
                    child: Text(
                      judul.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Divider()),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                    color: Colors.white,
                    width: double.infinity,
                    child: Text(
                      isiContent.toString()
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
