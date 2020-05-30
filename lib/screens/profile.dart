import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sellit_mobileapp/bloc/bloc.dart';
import 'package:sellit_mobileapp/models/product.dart';
import 'package:sellit_mobileapp/models/user.dart';
import 'package:sellit_mobileapp/routes/routelinks.dart';
import 'package:sellit_mobileapp/services/coredata.dart';
import 'package:sellit_mobileapp/utilis/urlLinks.dart';
import 'package:sellit_mobileapp/utilis/utili.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User account;
  UserproductBloc _userproductBloc;
  List<Product> _userProduct;
  @override
  void initState() {
    super.initState();
    account = CoreData.coreDataObject.userInfo;
    _userproductBloc = BlocProvider.of<UserproductBloc>(context);
    _userproductBloc.add(FetchUserProduct(userId: account.matrikelnumber));
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(body: BlocBuilder<UserproductBloc, UserproductState>(
      builder: (context, state) {
        if (state is UserProductLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is UserProductLoaded) {
          _userProduct = state.productResult;
          if (state.productResult.isEmpty) {
            return Container(
              height: 10,
            );
          } else {
            //var _text = _getApprovedProduct(_userProduct);
            return SafeArea(
                child: Stack(
              children: <Widget>[
                Container(
                    height: 225.0,
                    color: Colors.grey.shade200,
                    child: Container(
                      child: ListView(
                        padding: EdgeInsets.fromLTRB(40.0, 30.0, 40.0, 0.0),
                        children: <Widget>[
                          topLevel(_userProduct.length.toString()),
                          SizedBox(
                            height: 20.0,
                          ),
                          showCount(),
                        ],
                      ),
                    )),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      color: Colors.grey.shade300,
                      onPressed: () {
                        // Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
                Positioned(
                    top: 190.0,
                    child: Container(
                        height: screenHeight - 190,
                        width: screenWidth,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40.0),
                                topRight: Radius.circular(40.0))),
                        child: ListView(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 20.0,
                                  left: 20.0,
                                  right: 20.0,
                                  bottom: 10.0),
                              child: Container(
                                width: screenWidth - 40.0,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text("Posted Product",
                                        style:
                                            Theme.of(context).textTheme.title),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20.0,
                                  right: 20.0,
                                  bottom: 10.0,
                                  top: 5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  // _buildStaggeredGridView()
                                  // _buildProductRow('Kiwi', 'assets/kiwi.png', 'Approved', screenWidth),
                                  Container(
                                    height: 450,
                                    //color: Colors.grey.withOpacity(0.2),
                                    child: _buildStaggeredGridView(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )))
              ],
            ));
          }
        }
      },
    ));
  }

  Widget topLevel(String totalPostedProduct) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(totalPostedProduct, style: Theme.of(context).textTheme.title),
        Text("Total Posted Product", style: Theme.of(context).textTheme.caption)
      ],
    );
  }

  Widget showCount() {
    /* 'Approved': 1,'Sold': 2,'Under_Review': 3,"Inactive": 4,"Deleted" : 5*/
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      direction: Axis.horizontal,
      children: <Widget>[
        counterWidget("Approved", _getStatusCount(_userProduct, 1)),
        counterWidget("Sold", _getStatusCount(_userProduct, 2)),
        counterWidget("Pending ", _getStatusCount(_userProduct, 3)),
        counterWidget("Inactive", _getStatusCount(_userProduct, 4)),
      ],
    );
  }

  Widget counterWidget(String text, String count) {
    return Column(
      children: <Widget>[
        Container(
            height: 60.0,
            width: 60.0,
            child: Center(
                child: Text(
              count,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.body1,
            )),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0))),
        SizedBox(
          height: 2.5,
        ),
        Text(text, style: Theme.of(context).textTheme.caption)
      ],
    );
  }

  Widget _buildStaggeredGridView() {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      itemCount: _userProduct.length,
      itemBuilder: (BuildContext context, int index) =>
          _getProductCard(false, false, context, _userProduct[index]),
      staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }

  Widget _getProductCard(
      bool added, bool isFavorite, context, Product product) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ProductDetailsRoute, arguments: product);
      },
      child: Padding(
        padding:
            EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
        child: Container(
          height: 200.0,
          width: (MediaQuery.of(context).size.width / 2) - 20.0,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                    blurRadius: 2.0,
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2.0)
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: 150.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0)),
                        image: DecorationImage(
                            image: product.images.isEmpty
                                ? NetworkImage(NoImageURL)
                                : NetworkImage(product.images.first.url),
                            fit: BoxFit.cover)),
                  ),
                  /*Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.bottomRight,
                        child: isFavorite
                            ? Icon(Icons.favorite, color: Colors.red)
                            : Icon(Icons.favorite_border, color: Colors.red)),
                  )*/
                ],
              ),
              SizedBox(height: 5.0),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: UtilityWidget.getProductStatusText(product.status),
              ),
              /*Text(
                '\$' + "800",
                style: TextStyle(
                    fontFamily: 'Montserrat', fontSize: 14.0, color: Colors.grey),
              )*/
            ],
          ),
        ),
      ),
    );
  }

  String _getStatusCount(List<Product> input, int status) {
    int result = 0;
    input.forEach((f) {
      if (f.status == status) {
        result += 1;
      }
    });
    return result.toString();
  }
}
