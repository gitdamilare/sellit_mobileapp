import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sellit_mobileapp/bloc/bloc.dart';
import 'package:sellit_mobileapp/models/category.dart';
import 'package:sellit_mobileapp/models/product.dart';
import 'package:sellit_mobileapp/models/user.dart';
import 'package:sellit_mobileapp/routes/routelinks.dart';
import 'package:sellit_mobileapp/services/coredata.dart';
import 'package:sellit_mobileapp/utilis/datasearch.dart';
import 'package:sellit_mobileapp/utilis/utili.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  ProductBloc _productBloc;
  SearchBloc _searchBloc;
  User _user;
  List<Product> _products = List<Product>();
  FirebaseVisionImage ourImage;
  File pickedImage;
  bool isImageLoaded = false;

  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _productBloc = BlocProvider.of<ProductBloc>(context);
    _searchBloc = BlocProvider.of<SearchBloc>(context);
    _user = CoreData.coreDataObject.userInfo;
  }

  @override
  Widget build(BuildContext context) {
    var textStyle = Theme.of(context).textTheme.subtitle;
    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
        new GlobalKey<RefreshIndicatorState>();
    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKeyPost =
        new GlobalKey<RefreshIndicatorState>();
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Theme.of(context).canvasColor,
          automaticallyImplyLeading: false,
          title: Theme(
            data: ThemeData(primaryColor: Colors.white),
            child: Container(
              height: 50,
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                direction: Axis.horizontal,
                alignment: WrapAlignment.start,
                //crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    //padding: EdgeInsets.all(2.0),
                    height: 50,
                    child: TextField(
                      onTap: () {
                        showSearch(
                            context: context,
                            delegate: DataSearch(bloccontext: context));
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
                          hintText: "Find Cars, Mobile Phones and More...",
                          hintStyle: TextStyle(fontSize: 12.5)),
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        LineAwesomeIcons.camera,
                        size: 10,
                      ))
                ],
              ),
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: IconButton(
                  onPressed: pickImage,
                  icon: Icon(
                    LineAwesomeIcons.camera,
                    size: 30,
                  )),
            )
          ],
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductUninitialized) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ProductError) {
              return Center(
                child: Text('failed to fetch posts'),
              );
            } else if (state is ProductLoaded) {
              if (state.products.isEmpty || state.categories.isEmpty) {
                return RefreshIndicator(
                  key: _refreshIndicatorKeyPost,
                  onRefresh: _refreshProduct,
                  child: Center(
                    child: Text("no posts"),
                  ),
                );
              }
              CoreData.coreDataObject.appCategories = state.categories;
              //Filter Product
              return RefreshIndicator(
                key: _refreshIndicatorKey,
                onRefresh: _refreshProduct,
                child: ListView(
                  controller: _scrollController,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 30, 20, 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Browse Categories",
                                  style: TextStyle(
                                    fontFamily: 'Varela',
                                    fontSize: 18.0,
                                  )),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, CategoryRoute,
                                      arguments: state.categories);
                                },
                                child: Text("SEE ALL",
                                    style: TextStyle(
                                        fontFamily: 'Varela',
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).accentColor)),
                              )
                            ],
                          ),
                        ),
                        _browseCatgeories(state.categories),
                        _recentProduct(state)
                      ],
                    )
                  ],
                ),
              );
            } else {
              return RefreshIndicator(
                key: _refreshIndicatorKeyPost,
                onRefresh: _refreshProduct,
                child: Center(
                  child: Text("no posts"),
                ),
              );
            }
          },
        ),
      ),
    );

    /* ListView(
          children: <Widget>[_browseCatgeories(), _recentProduct()],
        ));*/
  }

  Widget _browseCatgeories(List<Category> categories) {
    return Container(
      // color: Colors.amber,
      padding: EdgeInsets.fromLTRB(20, 0.0, 20, 5.0),
      //width: 500,
      height: 230,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 0.0,
            childAspectRatio: 1.0,
            mainAxisSpacing: 0.0),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int i) {
          return _categoryCard(categories[i]);
        },
        itemCount: categories.length,
      ),
    );
  }

  Widget _recentProduct(ProductLoaded state) {
    var textStyle = Theme.of(context).textTheme.subtitle;

    //Filter Out Product that does not belong to the logged user
    if (_user != null) {
      _products = state.products
          .where((xx) => xx.sellerinfo.matrikelnumber != _user.matrikelnumber)
          .toList();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(20.0, 5.0, 15.0, 0.0),
          child: Text('Fresh Recommendations', style: textStyle),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
            //padding: EdgeInsets.fromLTRB(0.0, 0.0, 5, 0.0),
            width: MediaQuery.of(context).size.width - 30.0,
            //height: MediaQuery.of(context).size.height - 50.0,
            child: GridView.builder(
              //controller: _scrollController,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 2.0,
                  childAspectRatio: 0.8,
                  mainAxisSpacing: 15.0),
              itemCount: state.hasReachedMax
                  ? _products.length //state.products.length
                  : _products.length - 1, //state.products.length - 1,
              itemBuilder: (BuildContext context, int index) {
                var product = _products[index]; //state.products[index];
                return index >= _products.length //state.products.length
                    ? BottomLoader()
                    : getProductCard(false, false, context,
                        product); //_buildCard(false, false, context, product);
              },
            ))
      ],
    );
  }

  Widget _buildCard(bool added, bool isFavorite, context, Product product) {
    return Padding(
        padding: EdgeInsets.only(top: 2.0, bottom: 5.0, left: 5.0, right: 5.0),
        child: InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                ProductDetailsRoute,
                arguments: product,
              );
            },
            child: Card(
                elevation: 5.0,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                          tag: product.images,
                          child: Container(
                            height: 160,
                            width: 180.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0)),
                                image: DecorationImage(
                                    image:
                                        NetworkImage(product.images.first.url),
                                    fit: BoxFit.cover)),
                            /*child: Image.network(
                              product.images.first.url,
                              fit: BoxFit.cover,
                            ),*/
                          )),
                      Padding(
                          padding: EdgeInsets.all(2.0),
                          child:
                              Container(color: Color(0xFFEBEBEB), height: 1.0)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(product.name,
                              softWrap: true,
                              style: TextStyle(
                                  color: Color(0xFF575E67),
                                  fontFamily: 'Varela',
                                  fontSize: 14.0)),
                          Text("€ ${product.price}",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color(0xFFCC8053),
                                  fontFamily: 'Varela',
                                  fontSize: 15.0)),
                        ],
                      ),
                    ]))));
  }

  Widget _categoryCard(Category input) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, SubCategoryRoute, arguments: input);
      },
      child: Column(
        children: <Widget>[
          UtilityWidget.categoryAvatarCreator(input.name),
          SizedBox(
            height: 5.0,
          ),
          Text(
            input.name == null ? "CAR" : input.name.toUpperCase(),
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );
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

  Future<void> _refreshProduct() async {
    _productBloc.add(FetchProduct());
  }

  Widget getProductCard(bool added, bool isFavorite, context, Product product) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ProductDetailsRoute, arguments: product);
      },
      child: Padding(
        padding:
            EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
        child: Container(
          height: 220.0,
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
            //alignment: WrapAlignment.start,
            // runAlignment: WrapAlignment.start,
            //crossAxisAlignment: WrapCrossAlignment.start,
            //direction: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: 160.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0)),
                        image: DecorationImage(
                            image: NetworkImage(product.images.first.url),
                            fit: BoxFit.cover)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.bottomRight,
                        child: isFavorite
                            ? Icon(Icons.favorite, color: Colors.red)
                            : Icon(Icons.favorite_border, color: Colors.red)),
                  )
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
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.55),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    '\€' + "" + product.price,
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 15.0,
                        //color: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future readText() async {
    String result = "";
    final ImageLabeler labeler = FirebaseVision.instance.imageLabeler();
    ourImage = FirebaseVisionImage.fromFile(pickedImage);
    //VisionText visionText = await recognizeText.processImage(ourImage);
    final List<ImageLabel> labels = await labeler.processImage(ourImage);
    if (labels.isNotEmpty) result = labels.first.text;

    setState(() {
      searchQuery = result;
      searchQuery = UtilityWidget.getSearchText(searchQuery);
      if (Platform.isIOS) searchQuery = "Phone";
      _searchBloc.add(SearchProduct(productname: searchQuery));
      showModal();
    });

    // return result;
    /*for (ImageLabel label in labels) {
      final String text = label.text;
      final String entityId = label.entityId;
      final double confidence = label.confidence;
      print("-------------" +
          text +
          " " +
          entityId +
          " " +
          confidence.toString() +
          "-------------");
    }*/
  }

  Future pickImage() async {
    try {
      var tempStore = await ImagePicker.pickImage(
          source: ImageSource.gallery, maxHeight: 2000.0, maxWidth: 2000.0);
      setState(() {
        pickedImage = tempStore;
        isImageLoaded = true;
        readText();
      });
    } catch (e) {
      throw Exception('File is not available');
    }
  }

  showModal() {
    showBarModalBottomSheet(
      expand: false,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context, scrollController) => _brandModal(scrollController),
    );
  }

  Widget _brandModal(ScrollController controller) {
    var productCondition = CoreData.coreDataObject.appProductCondition;
    return Material(
        type: MaterialType.card,
        child: Column(
          children: <Widget>[
            Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: 70.0,
                  height: 70.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.cover, image: FileImage(pickedImage))),
                )),
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        )),
                      ],
                    );
                  }
                  if (state is SearchLoaded) {
                    if (state.searchresult.isEmpty) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            "No Results Found.",
                          ),
                        ],
                      );
                    } else {
                      var results = state.searchresult;
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Expanded(
                            child: StaggeredGridView.countBuilder(
                              shrinkWrap: true,
                              crossAxisCount: 4,
                              itemCount: results.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  getProductCard(
                                      false, false, context, results[index]),
                              staggeredTileBuilder: (int index) =>
                                  new StaggeredTile.fit(2),
                              mainAxisSpacing: 4.0,
                              crossAxisSpacing: 2.0,
                            ),
                          ),
                        ],
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ));
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
          child: GridView(
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1),
              children: <Widget>[
                Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 1.5,
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}

/*
ListView.separated(
          separatorBuilder: (context, index) => Divider(
                color: Colors.black,
              ),
          shrinkWrap: true,
          controller: controller,
          itemCount: productCondition.length,
          itemBuilder: (BuildContext context, int index) {
            var brand = productCondition[index];
            return ListTile(
              enabled: true,
              title: Text(brand.name),
              onTap: () {
                Navigator.of(context).pop();
                CoreData.coreDataObject.appProduct.productcondition = brand.id;
                print(brand.name);
              },
            );
          })
*/
