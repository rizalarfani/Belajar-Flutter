import 'package:flutter/material.dart';
import 'package:movie_app_new/custom/itemRatingMovie.dart';
import 'package:movie_app_new/custom/itemTab.dart';
import 'package:movie_app_new/custom/posterMovie.dart';
import 'package:movie_app_new/models/movie.dart';
import 'package:movie_app_new/screen/movieDetail.dart';
import 'package:movie_app_new/service/serviceMovie.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.6);
  int _selectPage = 0;
  List<Movie> list;
  var cekData = false;
  @override
  void initState() {
    ServiceMovie.getNowPlaying().then((value) {
      setState(() {
        list = value;
        if (list.length > 0) {
          cekData = true;
        } else {
          cekData = false;
        }
      });
    });
    super.initState();
  }

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
              cekData
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(
                          height: 100,
                        ),
                        Expanded(
                          child: Container(
                            height: 600,
                            margin: EdgeInsets.only(top: 30),
                            child: PageView.builder(
                              onPageChanged: (item) {
                                setState(() {
                                  _selectPage = item;
                                });
                              },
                              controller: pageController,
                              itemCount: list.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MovieDetail(
                                                  index: index,
                                                  models: list[index],
                                                )));
                                  },
                                  child: PosterMovie(
                                    selectPage: _selectPage,
                                    index: index,
                                    imgUrl:
                                        "https://image.tmdb.org/t/p/w440_and_h660_face${list[index].posterPath}",
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Text(
                          '${list[_selectPage].originalTitle}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Category movie | 2 hours',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            ItemRatingMovie(
                              rating: "${list[_selectPage].popularity}",
                              titleRating: "Popularity",
                            ),
                            ItemRatingMovie(
                              rating: "${list[_selectPage].voteCount}",
                              titleRating: "Vote count",
                            ),
                            ItemRatingMovie(
                              rating: "${list[_selectPage].voteAverage}",
                              titleRating: "Vote averega",
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 60),
                          padding: EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border:
                                  Border.all(width: 3, color: Colors.white)),
                          child: Text(
                            "Buy Tickets",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    )
                  : Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
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
