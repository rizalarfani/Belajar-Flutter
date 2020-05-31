import 'package:flutter/material.dart';
import 'package:http_request/berita/ListBeritaAppBar.dart';
import 'package:http_request/model/modelBerita.dart';
import 'package:http_request/model/ApiService.dart';

class ListBerita extends StatefulWidget {
  @override
  _ListBeritaState createState() => _ListBeritaState();
}

class _ListBeritaState extends State<ListBerita> {
  ApiService apiService;

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _buildListBerita(),
    );
  }

  Widget _buildListBerita() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: BeritaAppBar(),
      body: SafeArea(
        child: FutureBuilder(
          future: apiService.getBerita(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Berita>> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Error Kode: ${snapshot.error.toString()}"),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              List<Berita> berita = snapshot.data;
              return _buildListView(berita);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildListView(List<Berita> _berita) {
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(right: 15.0, left: 15.0),
          width: double.infinity,
          height: 200.0,
          decoration: BoxDecoration(color: Colors.lightBlueAccent),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 200.0,
                child: Text(
                  "Berita",
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              )
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
                    topRight: Radius.circular(30)),
                color: Colors.white),
            child: ListView.builder(
              itemCount: _berita == null ? 0 : _berita.length,
              physics: new ClampingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                Berita listBerita = _berita[index];
                return Container(
                  height: 120.0,
                  child: Card(
                    shadowColor: Colors.grey,
                    margin: EdgeInsets.only(
                        top: 15.0, bottom: 10.0, right: 15.0, left: 15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ListTile(
                          leading: Container(
                            height: 120.0,
                            width: 80.0,
                            child: Image.network(
                              'https://jempolan.tegalkota.go.id/uploads/berita/' +
                                  listBerita.foto,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            listBerita.judul,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                          ),
                          subtitle: Text(
                            listBerita.created,
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.grey),
                          ),
                          trailing: Text(listBerita.aouthor,
                              style: TextStyle(color: Colors.grey)),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
