import 'package:flutter/material.dart';
import 'package:http_request/lansia/lansia_AppBar.dart';
import 'package:http_request/model/ApiService.dart';
import 'package:http_request/model/modelLansia.dart';

class ListLansia extends StatefulWidget {
  @override
  _ListLansiaState createState() => _ListLansiaState();
}

class _ListLansiaState extends State<ListLansia> {
  ApiService apiService;

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    return _buildListLansia();
  }

  Widget _buildListLansia() {
    return Scaffold(
      appBar: LansiaAppBar(),
      body: SafeArea(
        child: FutureBuilder(
          future: apiService.getLansia(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Lansia>> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                    "Something wrong with message: ${snapshot.error.toString()}"),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              List<Lansia> profiles = snapshot.data;
              return _buildListView(profiles);
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

  Widget _buildListView(List<Lansia> listLansia) {
    return ListView.builder(
      itemCount: listLansia == null ? 0 : listLansia.length,
      itemBuilder: (context, index) {
        Lansia lansia = listLansia[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              "https://jempolan.tegalkota.go.id/uploads/pribadi/"+lansia.foto
            )
          ),
          title: Text(lansia.name),
          subtitle: Text(lansia.alamat, style: TextStyle(color: Colors.grey),),
          trailing: Image.asset(lansia.jk == "L" ? "assets/icons/man.png" : "assets/icons/grandmother.png"),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)
              => DetailLansia(lansia),
            ));
          },
        );
      },
    );
  }
}

class DetailLansia extends StatelessWidget {
  final Lansia nama;
  DetailLansia(this.nama);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(nama.name)
        ),
      ),
    );
  }
} 
