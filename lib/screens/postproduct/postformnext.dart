import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:sellit_mobileapp/data/productrepository.dart';
import 'package:sellit_mobileapp/models/product.dart';
import 'package:sellit_mobileapp/routes/routelinks.dart';
import 'package:sellit_mobileapp/services/coredata.dart';
import 'package:sellit_mobileapp/utilis/utili.dart';

class PostFormNext extends StatefulWidget {
  PostFormNext({Key key}) : super(key: key);

  @override
  _PostFormNextState createState() => _PostFormNextState();
}

class _PostFormNextState extends State<PostFormNext> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldPostProductKey = GlobalKey<ScaffoldState>();

  String _error;
  List<Asset> images = List<Asset>();
  ProductRepository productRepository = ProductService();

  TextEditingController _priceController = TextEditingController();
  TextEditingController _productCondController = TextEditingController();
  TextEditingController _moreDetailController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldPostProductKey,
      bottomNavigationBar: UtilityWidget.materialButton(context, "Post Product",
          onPress: () => _postProduct()),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
                brightness: Brightness.light,
                backgroundColor: Theme.of(context).canvasColor,
                leading: IconButton(
                    icon: Icon(LineAwesomeIcons.arrow_left),
                    onPressed: () => Navigator.of(context).pop()),
                title: Text("Set a Price")),
            SliverList(delegate: SliverChildListDelegate([_postForm()]))
          ],
        ),
      ),
    );
  }

  _postForm() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 0.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: ListBody(mainAxis: Axis.vertical, children: <Widget>[
            _formField(
              "Price *",
              TextFormField(
                autofocus: true,
                keyboardType: TextInputType.number,
                controller: _priceController,
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    prefixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          LineAwesomeIcons.euro_sign,
                          size: 20.0,
                          color: Colors.black,
                        ),
                        Text(
                          "|",
                          textScaleFactor: 1.5,
                        )
                      ],
                    )),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please Enter Some Text";
                  }
                  return null;
                },
                onChanged: (value) {
                  CoreData.coreDataObject.appProduct.price =
                      _priceController.text;
                },
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            _formField(
                "Product Condition *",
                TextFormField(
                    //autofocus: true,
                    controller: _productCondController,
                    decoration: InputDecoration(
                        hintText: "Select Product Condition",
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        suffixIcon: Icon(
                          LineAwesomeIcons.sort_down__descending_,
                          color: Colors.black,
                        )),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please Enter Some Text";
                      }
                      return null;
                    },
                    readOnly: true,
                    onTap: () {
                      showBarModalBottomSheet(
                        expand: false,
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context, scrollController) =>
                            _brandModal(scrollController),
                      );
                    },
                    onChanged: (value) {
                      //CoreData.coreDataObject.appProduct.productcondition = 1;
                    })),
            SizedBox(
              height: 20.0,
            ),
            _formField(
                "More Details ",
                TextFormField(
                    autofocus: true,
                    controller: _moreDetailController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      hintText: "",
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please Enter Some Text";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      CoreData.coreDataObject.appProduct.moredetails =
                          _moreDetailController.text;
                    })),
          ]),
        ),
      ),
    );
  }

  Widget _formField(String formTitle, Widget formField) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          formTitle,
          style: TextStyle(color: Colors.grey, fontSize: 11.5),
        ),
        formField,
      ],
    );
  }

  _postProduct() {
    try {
      Product _productToPost = CoreData.coreDataObject.appProduct;
      _productToPost.sellerid = CoreData.coreDataObject.userInfo.matrikelnumber;
      _productToPost.status = 3; //Under_Review
      setState(() {
        if (_formKey.currentState.validate()) {
          productRepository.postProduct(_productToPost).then((v) async {
            if (v.isNotEmpty) {
              print(v);
              await Future<Null>.delayed(Duration(seconds: 5), () {
                _scaffoldPostProductKey.currentState.removeCurrentSnackBar();
                _scaffoldPostProductKey.currentState.showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.fixed,
                    duration: Duration(seconds: 5),
                    content: Text(
                        'Your Product has Successfully been Received. Please Wait For Approval'),
                    backgroundColor: Colors.green,
                  ),
                );
                print("vvvvvvvvvvvvvvvvvvvvvvvvvv");
              });

              //print("vvvvvvvvvvvvvvvvvvvvvvvvvv");
               Navigator.of(context).pushNamed(
                ExploreRoute,
              );
            }
          });
        }
      });

      //_productToPost.status = 3;
      //_productToPost.categoryid = 2;
      // 932624;

    } catch (e) {
      print(e);
    }
  }

  Widget _brandModal(ScrollController controller) {
    var productCondition = CoreData.coreDataObject.appProductCondition;
    return Material(
      type: MaterialType.card,
      child: ListView.separated(
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
                _productCondController.text = brand.name;
                Navigator.of(context).pop();
                CoreData.coreDataObject.appProduct.productcondition = brand.id;
                print(brand.name);
              },
            );
          }),
    );
  }
}
