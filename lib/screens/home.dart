import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sellit_mobileapp/bloc/bloc.dart';
import 'package:sellit_mobileapp/models/product.dart';
import 'package:sellit_mobileapp/routes/routelinks.dart';
import 'package:sellit_mobileapp/screens/productdetails.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  ProductBloc _productBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _productBloc = BlocProvider.of<ProductBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
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
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductUninitialized) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ProductError) {
            return Center(
              child: Text('failed to fetch posts'),
            );
          }
          if (state is ProductLoaded) {
            if (state.products.isEmpty) {
              return Center(
                child: Text("no posts"),
              );
            }
            return ListView(
              controller: _scrollController,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    _browseCatgeories(),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: double.infinity),
                      child: _recentProduct(state),
                    )
                    
                  ],
                )
              ],
            );
          }
        },
      ),
    );

    /* ListView(
          children: <Widget>[_browseCatgeories(), _recentProduct()],
        ));*/
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

  Widget _recentProduct(ProductLoaded state) {
    var textStyle = Theme.of(context).textTheme.subtitle;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(30.0, 0.0, 15.0, 0.0),
          child: Text('Fresh Recommendations', style: textStyle),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
            padding: EdgeInsets.fromLTRB(5, 0.0, 5, 0.0),
            width: MediaQuery.of(context).size.width - 30.0,
            height: MediaQuery.of(context).size.height - 50.0,
            child: GridView.builder(
              //controller: _scrollController,
              //physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 2.0,
                  childAspectRatio: 0.8,
                  mainAxisSpacing: 15.0),
              itemCount: state.hasReachedMax
                  ? state.products.length
                  : state.products.length + 1,
              itemBuilder: (BuildContext context, int index) {
                return index >= state.products.length
                    ? BottomLoader()
                    : _buildCard(
                        state.products[index].name,
                        state.products[index].price,
                        state.products[index].images.first.url,
                        false,
                        false,
                        context);
              },
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
                          tag: name,
                          child: Container(
                            height: 160,
                            width: 180.0,
                            child: Image.network(
                              imgPath,
                              fit: BoxFit.cover,
                            ),
                          )),
                      Padding(
                          padding: EdgeInsets.all(2.0),
                          child:
                              Container(color: Color(0xFFEBEBEB), height: 1.0)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("€ $price",
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
                        ],
                      ),
                    ]))));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      debugPrint((maxScroll - currentScroll).toString());
      _productBloc.add(FetchProduct());
    }
    // debugPrint((maxScroll - currentScroll).toString());
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
