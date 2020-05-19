import 'package:clone_gojek/constant.dart';
import 'package:flutter/material.dart';
import 'package:clone_gojek/beranda/beranda_appBar.dart';
import 'package:clone_gojek/beranda/beranda_model.dart';

class BerandaPage extends StatefulWidget {
  @override
  _BerandaPageState createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  List<GojekService> _gojekServiceList = [];
  List<Food> _goFoodFeaturedList = [];

  void initState() {
    // TODO: implement initState
    super.initState();
    _gojekServiceList.add(new GojekService(
        image: Icons.directions_bike,
        color: GojekPalet.menuRide,
        title: "GO-RIDE"));
    _gojekServiceList.add(new GojekService(
        image: Icons.local_car_wash,
        color: GojekPalet.menuCar,
        title: "GO-CAR"));
    _gojekServiceList.add(new GojekService(
        image: Icons.directions_car,
        color: GojekPalet.menuBluebird,
        title: "GO-BLUEBIRD"));
    _gojekServiceList.add(new GojekService(
        image: Icons.restaurant, color: GojekPalet.menuFood, title: "GO-FOOD"));
    _gojekServiceList.add(new GojekService(
        image: Icons.next_week, color: GojekPalet.menuSend, title: "GO-SEND"));
    _gojekServiceList.add(new GojekService(
        image: Icons.local_offer,
        color: GojekPalet.menuDeals,
        title: "GO-DEALS"));
    _gojekServiceList.add(new GojekService(
        image: Icons.phonelink_ring,
        color: GojekPalet.menuPulsa,
        title: "GO-PULSA"));
    _gojekServiceList.add(new GojekService(
        image: Icons.apps, color: GojekPalet.menuOther, title: "LAINNYA"));
    _gojekServiceList.add(new GojekService(
        image: Icons.shopping_basket,
        color: GojekPalet.menuShop,
        title: "GO-SHOP"));
    _gojekServiceList.add(new GojekService(
        image: Icons.shopping_cart,
        color: GojekPalet.menuMart,
        title: "GO-MART"));
    _gojekServiceList.add(new GojekService(
        image: Icons.local_play, color: GojekPalet.menuTix, title: "GO-TIX"));

    _goFoodFeaturedList.add(
        new Food(judul: "Steak Andakar", image: "assets/menu/food_1.jpg"));
    _goFoodFeaturedList.add(
        new Food(judul: "Mie Ayam Tumini", image: "assets/menu/food_2.jpg"));
    _goFoodFeaturedList.add(
        new Food(judul: "Tengkleng Hohah", image: "assets/menu/food_3.jpg"));
    _goFoodFeaturedList.add(
        new Food(judul: "Warung Steak", image: "assets/menu/food_4.jpg"));
    _goFoodFeaturedList.add(new Food(
        judul: "Kindai Warung Banjar", image: "assets/menu/food_5.jpg"));
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: GojekAppBar(),
          body: Container(
            color: GojekPalet.grey,
            child: ListView(
              physics: ClampingScrollPhysics(),
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      _bulidGopayMenu(),
                      _buildGojekServicesMenu()
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(top: 16.0),
                  child: Column(
                    children: <Widget>[
                      _bulidGoFoodMenu(),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }

  Widget _buildGojekServicesMenu() {
    return new SizedBox(
        width: double.infinity,
        height: 220.0,
        child: new Container(
            margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: GridView.builder(
                physics: ClampingScrollPhysics(),
                itemCount: 8,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (context, position) {
                  return _rowGojekService(_gojekServiceList[position]);
                })));
  }

  Widget _rowGojekService(GojekService gojekService) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: GojekPalet.grey200, width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            padding: EdgeInsets.all(12.0),
            child: Icon(
              gojekService.image,
              color: gojekService.color,
              size: 32.0,
            ),
          ),
          Padding (padding: EdgeInsets.only(top: 6.0),),
          Text(
            gojekService.title, style: TextStyle(fontSize: 10.0),
          )
        ],
      ),
    );
  }

  Widget _bulidGopayMenu() {
    return Container(
      height: 120.0,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [const Color(0xff3164bd), const Color(0xff295cb5)],
          ),
          borderRadius: BorderRadius.circular(5.0)),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(7.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [const Color(0xff3164bd), const Color(0xff295cb5)]),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0.5),
                    bottomLeft: Radius.circular(0.5))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "GOPAY",
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Rp 1.000.000",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      color: Colors.white),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "assets/icons/icon_transfer.png",
                      height: 25.0,
                      width: 25.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 6.0),
                    ),
                    Text(
                      "Tranfers",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "assets/icons/icon_scan.png",
                      height: 25.0,
                      width: 25.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 6.0),
                    ),
                    Text(
                      "QR COde",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "assets/icons/icon_menu.png",
                      height: 25.0,
                      width: 25.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 6.0),
                    ),
                    Text(
                      "Menu",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "assets/icons/icon_saldo.png",
                      height: 25.0,
                      width: 25.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 6.0),
                    ),
                    Text(
                      "Saldo",
                      style: TextStyle(
                        color: Colors.white,
                      ),
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

  Widget _bulidGoFoodMenu ()
  {
    return Container(
      padding: EdgeInsets.fromLTRB(16.0, 16.0, 0.0, 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            "Go-Food",
            style: TextStyle(fontFamily: "Pluto",fontSize: 18.0,fontWeight: FontWeight.bold),
          ),
          Padding(padding: EdgeInsets.only(top: 8.0)),
          SizedBox(
            height: 175.0,
            child: ListView.builder(
              itemCount: _goFoodFeaturedList.length,
              padding: EdgeInsets.only(top: 12.0),
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return _rowFoodMenu(_goFoodFeaturedList[index]);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _rowFoodMenu (Food food)
  {
    return Container(
      margin: EdgeInsets.only(right: 16.0),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              food.image,
              width: 135.0,
              height: 135.0,
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 8.0)),
          Text(
            food.judul,
          )
        ],
      ),
    );
  }
}
