import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductDetails extends StatefulWidget {
  ProductDetails({Key key}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _materialButton(),
      body: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _imageCarousel(),
              _aboutProducts(),
              Divider(
                thickness: 3.0,
              ),
              _moreDetails(),
             Divider(
                thickness: 3.0,
              ),
              _productDescription(),
                           Divider(
                thickness: 3.0,
              ),
              _sellerDescription()
            ],
          ),
        ],
      ),
    );
  }

  Widget _imageCarousel() {
    return Stack(
      children: <Widget>[
        Container(
          height: 250,
          child: Carousel(
            boxFit: BoxFit.cover,
            images: [
              AssetImage("assets/images/cookiemint.jpg"),
              AssetImage("assets/images/cookiemint.jpg"),
              AssetImage("assets/images/cookiemint.jpg"),
              AssetImage("assets/images/cookiemint.jpg")
            ],
            dotSize: 5.0,
            autoplay: false,
          ),
        ),
        Positioned(
          child: AppBar(          
           //automaticallyImplyLeading: true,
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.transparent,
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            elevation: 0,
            actions: <Widget>[],
          ),
        )
      ],
    );
  }

  Widget _aboutProducts() {
    var titletextStyle = Theme.of(context).textTheme.title;
    var subtextStyle = Theme.of(context).textTheme.subtitle;
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 8.0, 5.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "\$50,0000",
            style: titletextStyle,
          ),
          Text(
            "Ford Ecosport Titanium 2014 AT Service Record Istimewas #aos",
            softWrap: true,
            style: subtextStyle,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.location_on),
                      Text("AM KINDELSFELD 3",
                          style: Theme.of(context).textTheme.caption),
                    ],
                  ),
                ),
                Text("16 DEC", style: Theme.of(context).textTheme.caption)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _moreDetails(){
    return ListTile(
      title: Text("Product Details" , style: Theme.of(context).textTheme.subtitle,),
      subtitle: Text("Sed ut perspiciatis unde omnis iste natus error sit voluptatem" 
      "accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo "
      "inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo."
      "Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit,"
      "sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt."
       "Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur",
       style: Theme.of(context).textTheme.body1,
       softWrap: true,
       textAlign: TextAlign.justify,),
    );
  }

  Widget _productDescription(){
    return ListTile(
      title: Text("Product Description" , style: Theme.of(context).textTheme.subtitle,),
      subtitle: Text("Sed ut perspiciatis unde omnis iste natus error sit voluptatem" 
      "accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo "
      "inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo."
      "Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit,"
      "sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt."
       "Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur",
       style: Theme.of(context).textTheme.body1,
       softWrap: true,
       textAlign: TextAlign.justify,),
    );
  }

   Widget _sellerDescription(){
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        child: Text("MB"),
      ),
      trailing: Icon(Icons.arrow_forward_ios),
      title: Text("Marquise Barrows" , style: Theme.of(context).textTheme.subtitle,),
      subtitle: Text("Member since Dec 2017",
       style: Theme.of(context).textTheme.body1,
       softWrap: true,
       textAlign: TextAlign.justify,),
    );
  }


  MaterialButton _materialButton() {
    return MaterialButton(
      height: 50.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1.0)),
      child: Text(
        "Chat",
        textScaleFactor: 1.5,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      color: Theme.of(context).primaryColor,
      elevation: 2.0,
      onPressed: () {},
    );
  }
}
