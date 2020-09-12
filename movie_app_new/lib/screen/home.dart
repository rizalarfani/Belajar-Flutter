import 'package:flutter/material.dart';
import 'package:movie_app_new/custom/itemTab.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.6);
  int _selectPage = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        drawer: Drawer(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text("Movie App"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            )
          ],
          bottom: TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey[300],
              indicator: UnderlineTabIndicator(borderSide: BorderSide.none),
              isScrollable: true,
              tabs: [
                ItemTab(
                  icon: Icons.home,
                  title: "Playing",
                ),
                ItemTab(
                  icon: Icons.favorite,
                  title: "Favorite",
                ),
                ItemTab(
                  icon: Icons.feedback,
                  title: "Top Reted",
                ),
                ItemTab(
                  icon: Icons.history,
                  title: "Coming Soon",
                ),
              ]),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue[300], Colors.indigo[800]]),
          ),
          child: TabBarView(
            children: [
              Container(
                child: PageView(
                  onPageChanged: (item) {
                    setState(() {
                      _selectPage = item;
                    });
                  },
                controller: pageController,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: _selectPage == 0 ? 130 : 150, horizontal: 15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        "https://image.tmdb.org/t/p/w440_and_h660_face/wcaDIAG1QdXQLRaj4vC1EFdBT2.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: _selectPage == 1 ? 130 : 150, horizontal: 15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        "https://image.tmdb.org/t/p/w440_and_h660_face/7WsyChQLEftFiDOVTGkv3hFpyyt.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: _selectPage == 2 ? 130 : 150, horizontal: 15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        "https://image.tmdb.org/t/p/w440_and_h660_face/8kOWDBK6XlPUzckuHDo3wwVRFwt.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: _selectPage == 3 ? 130 : 150, horizontal: 15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        "https://image.tmdb.org/t/p/w440_and_h660_face/wHa6KOJAoNTFLFtp7wguUJKSnju.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              )),
              Container(
                child: Center(
                  child: Text("Favorire"),
                ),
              ),
              Container(
                child: Center(
                  child: Text("Top reted"),
                ),
              ),
              Container(
                child: Center(
                  child: Text("Coming soon"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
