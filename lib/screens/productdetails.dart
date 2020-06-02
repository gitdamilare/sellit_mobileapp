//import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sellit_mobileapp/models/product.dart';
import 'package:sellit_mobileapp/utilis/urlLinks.dart';
import 'package:sellit_mobileapp/utilis/utili.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductDetails extends StatefulWidget {
  final Product product;
  ProductDetails({Key key, this.product}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  Product _product;
  List<dynamic> _images = List<dynamic>();
  @override
  void initState() {
    super.initState();
    _product = widget.product;
    if(_product.images.isNotEmpty){
          _product.images.forEach((image) {
      _images.add(NetworkImage(image.url));
    });
    }else{
     _images.add(NetworkImage(NoImageURL));
    }



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: UtilityWidget.materialButton(context,"Chat"),
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
             _product.sellerinfo != null ? _sellerDescription() : Container(height: 1.0,)
            ],
          ),
        ],
      ),
    );
  }

  Widget _imageCarousel() {
    return Stack(
      children: <Widget>[
        Hero(
          tag: _product.images,
                  child: Container(
            height: 250,
            child: Carousel(
              boxFit: BoxFit.cover,
              images: _images,
              dotSize: 5.0,
              autoplay: false,
            ),
          ),
        ),
        Positioned(
          child: AppBar(
            //automaticallyImplyLeading: true,
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.transparent,
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
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
            "€ ${_product.price}",
            style: titletextStyle,
          ),
          Text(
            _product.name,
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

  Widget _moreDetails() {
    return ListTile(
      title: Text(
        "Product Details",
        style: Theme.of(context).textTheme.subtitle,
      ),
      subtitle: Text(
        _product.description,
        style: Theme.of(context).textTheme.body1,
        softWrap: true,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _productDescription() {
    return ListTile(
      title: Text(
        "Product Description",
        style: Theme.of(context).textTheme.subtitle,
      ),
      subtitle: Text(
        _product.moredetails != "" ? _product.moredetails : "",
        style: Theme.of(context).textTheme.body1,
        softWrap: true,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _sellerDescription() {
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        child: Text(circleAvatarTitle(
            _product.sellerinfo.firstname, _product.sellerinfo.lastname)),
      ),
      trailing: Icon(Icons.arrow_forward_ios),
      title: Text(
        "${_product.sellerinfo.firstname + " " + _product.sellerinfo.lastname}",
        style: Theme.of(context).textTheme.subtitle,
      ),
      subtitle: Text(
        "Member since Dec 2017",
        style: Theme.of(context).textTheme.body1,
        softWrap: true,
        textAlign: TextAlign.justify,
      ),
    );
  }

  String circleAvatarTitle(String firstname, String lastname) {
    return firstname.substring(0, 1).toUpperCase() +
        lastname.substring(0, 1).toUpperCase();
  }

}
