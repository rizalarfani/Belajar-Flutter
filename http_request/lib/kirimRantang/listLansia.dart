import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http_request/model/ApiService.dart';
import 'package:http_request/model/modelLansia.dart';
import 'package:http_request/kirimRantang/SendRantang.dart';

class ListLansiaPdm extends StatefulWidget {
  String kode;
  ListLansiaPdm({this.kode});
  @override
  _ListLansiaPdmState createState() => _ListLansiaPdmState(kodePdm: kode);
}

class _ListLansiaPdmState extends State<ListLansiaPdm> {
  String kodePdm;
  ApiService apiservice;
  _ListLansiaPdmState({this.kodePdm});

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    apiservice = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: Image.asset(
            "assets/logo/logo_jempolan.png",
            height: 25.0,
            width: 25.0,
          ),
          title: Text("JEMPOLAN"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              iconSize: 28,
              onPressed: () {
                showSearch(
                    context: context, delegate: DataSearch(kodePdm: kodePdm));
              },
            )
          ],
        ),
        body: _listLansia(kodePdm),
      ),
    );
  }

  Widget _listLansia(kode) {
    return SafeArea(
      child: FutureBuilder(
        future: apiservice.listLansiaPdm(kode),
        builder: (BuildContext context, AsyncSnapshot<List<Lansia>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<Lansia> lansia = snapshot.data;
            return _buildListView(lansia);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildListView(List<Lansia> listLansia) {
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
                  "Joko Margo",
                  style: TextStyle(
                      fontSize: 30.0,
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
                controller: _scrollController,
                itemCount: listLansia.length,
                physics: new ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  Lansia lansia = listLansia[index];
                  return Dismissible(
                    key: ValueKey(lansia),
                    background: Container(
                        color: Colors.blueAccent,
                        child: Icon(
                          Icons.send,
                          size: 30.0,
                          color: Colors.white,
                        )),
                    onDismissed: (DismissDirection direction) {
                      if (direction == DismissDirection.startToEnd ||
                          direction == DismissDirection.endToStart) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SendRantang(
                                      idLansia: lansia.id,
                                    )));
                      }
                    },
                    child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SendRantang(
                                        idLansia: lansia.id,
                                      )));
                        },
                        leading: Image.asset(lansia.jk == "L"
                            ? "assets/icons/man.png"
                            : "assets/icons/grandmother.png"),
                        title: Text(lansia.name),
                        subtitle: Text(
                          lansia.alamat,
                          style: TextStyle(color: Colors.grey),
                        )),
                  );
                },
              )),
        )
      ],
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  String kodePdm;
  DataSearch({this.kodePdm})
      : super(
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
        );

  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme.copyWith(
      primaryColor: Colors.blueAccent,
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: () => query = '')];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {}

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Silahkan Cari Berdasarkan Nama",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            ),
          )
        ],
      );
    } else {
      return FutureBuilder(
        future: ApiService().listLansiaPdmAll(kodePdm),
        builder: (BuildContext context, AsyncSnapshot<List<Lansia>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data.length >= 0) {
              List<Lansia> list = snapshot.data;
              final searchList =
                  list.where((p) => p.name.startsWith(query)).toList();
              return ListView.builder(
                itemCount: searchList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Image.asset(list[index].jk == "L"
                        ? "assets/icons/man.png"
                        : "assets/icons/grandmother.png"),
                    title: RichText(
                      text: TextSpan(
                        text: searchList[index].name.substring(0, query.length),
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                            text:
                                searchList[index].name.substring(query.length),
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    subtitle: Text(searchList[index].alamat),
                    trailing: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SendRantang(
                                      idLansia: list[index].id,
                                    )));
                      },
                      icon: Icon(Icons.send,
                          size: 30.0, color: Colors.blueAccent),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text("Data Tidak diTukan"),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
    }
  }
}
