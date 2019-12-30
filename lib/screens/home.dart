import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sellit_mobileapp/routes/routelinks.dart';
import 'package:sellit_mobileapp/screens/productdetails.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 5.0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Theme(
            data: ThemeData(primaryColor: Colors.white),
            child: Container(
              height: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                   Container(
                      //padding: EdgeInsets.all(2.0),
                      height: 50,
                      child: TextField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(),
                            hintText: "Find Cars, Mobile Phones and More...",
                            hintStyle: TextStyle(fontSize: 12.5)),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        body: ListView(
          children: <Widget>[_browseCatgeories(), _recentProduct()],
        ));
  }

  Widget _browseCatgeories() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Browse Categories",
                  style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 18.0,
                  )),
              Text("SELL ALL",
                  style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 15.0,
                  ))
            ],
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            height: 300,
            child: GridView.count(
              crossAxisCount: 3,
              primary: false,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 15.0,
              childAspectRatio: 1.0,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 30,
                      child: Center(
                          child: IconButton(
                        onPressed: () {},
                        icon: new Icon(FontAwesomeIcons.car),
                        iconSize: 30,
                      )),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text("Mobile")
                  ],
                ),
                Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 30,
                      child: Center(
                          child: Icon(
                        Icons.computer,
                        size: 35,
                      )),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text("Mobile")
                  ],
                ),
                Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 30,
                      child: Center(
                          child: Icon(
                        Icons.computer,
                        size: 35,
                      )),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text("Mobile")
                  ],
                ),
                Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 30,
                      child: Center(
                          child: Icon(
                        Icons.computer,
                        size: 35,
                      )),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text("Mobile")
                  ],
                ),
                Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 30,
                      child: Center(
                          child: Icon(
                        Icons.computer,
                        size: 35,
                      )),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text("Mobile")
                  ],
                ),
                Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 30,
                      child: Center(
                          child: Icon(
                        Icons.computer,
                        size: 35,
                      )),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text("Mobile")
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _recentProduct() {
    var textStyle = Theme.of(context).textTheme.subtitle;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(30.0, 0.0, 15.0, 0.0),
          child: Text('Fresh Recommendations',
              style: textStyle),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
            padding: EdgeInsets.fromLTRB(5, 0.0, 5, 0.0),
            width: MediaQuery.of(context).size.width - 30.0,
            height: MediaQuery.of(context).size.height - 50.0,
            child: GridView.count(
              crossAxisCount: 2,
              primary: false,
              crossAxisSpacing: 2.0,
              mainAxisSpacing: 15.0,
              childAspectRatio: 0.8,
              children: <Widget>[
                _buildCard('Toyota Corolla', '\$3.99',
                    'assets/images/image_07.png', false, false, context),
                _buildCard('Samsung Galaxy Note 10', '\$5.99',
                    'assets/images/image_06.png', true, false, context),
                _buildCard('Cookie classic', '\$1.99',
                    'assets/images/cookieclassic.jpg', false, true, context),
                _buildCard('Cookie choco', '\$2.99',
                    'assets/images/cookiechoco.jpg', false, false, context)
              ],
            ))
      ],
    );
  }

  Widget _buildCard(String name, String price, String imgPath, bool added,
      bool isFavorite, context) {
    return Padding(
        padding: EdgeInsets.only(top: 2.0, bottom: 5.0, left: 5.0, right: 5.0),
        child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, ProductDetailsRoute);
            },
            child: Card(
              elevation: 5.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Hero(
                      tag: imgPath,
                      child: Container(
                          height: 160,
                          width: 180.0,
                         child: Image.asset(imgPath, fit: BoxFit.cover,),)),
                    Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Container(color: Color(0xFFEBEBEB), height: 1.0)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  Text(price,
                  textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color(0xFFCC8053),
                          fontFamily: 'Varela',
                          fontSize: 15.0)),
                  Text(name,
                        softWrap: true,                
                      style: TextStyle(
                          color: Color(0xFF575E67),
                          fontFamily: 'Varela',
                          fontSize: 14.0)),
                  ],),

                ]))));
  }

}
