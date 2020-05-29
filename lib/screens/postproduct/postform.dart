import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:sellit_mobileapp/data/productrepository.dart';
import 'package:sellit_mobileapp/models/brand.dart';
import 'package:sellit_mobileapp/models/category.dart';
import 'package:sellit_mobileapp/routes/routelinks.dart';
import 'package:sellit_mobileapp/services/coredata.dart';
import 'package:sellit_mobileapp/utilis/utili.dart';
import 'package:sellit_mobileapp/models/image.dart' as img;

class PostForm extends StatefulWidget {
  // PostForm({Key key}) : super(key: key);
  final Category category;
  PostForm({this.category});

  @override
  _PostFormState createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  final _formKey = GlobalKey<FormState>();

  String _error;
  List<Asset> images = List<Asset>();
  ProductRepository productRepository = ProductService();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _brandController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  String postImageURL = "";
  List<Brand> brandCategories;
  bool isUploading = false;

  @override
  void initState() {
    super.initState();
    if (widget.category != null)
      brandCategories = getBrandByCategory(widget.category.categoryid);
    brandCategories.sort((a, b) => a.brandname.compareTo(b.brandname));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton.extended(
              heroTag: null,
              onPressed: loadAssets,
              icon: Icon(LineAwesomeIcons.upload),
              label: Text("Add Image")),
          SizedBox(
            height: 7,
          ),
          FloatingActionButton.extended(
              heroTag: null,
              onPressed: () => _next(),
              icon: Icon(LineAwesomeIcons.arrow_right),
              label: Text("Next"))
        ],
      ),
     // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      //bottomNavigationBar: UtilityWidget.materialButton(context, "Next", onPress: () => _next()),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
                brightness: Brightness.light,
                backgroundColor: Theme.of(context).canvasColor,
                leading: IconButton(
                    icon: Icon(LineAwesomeIcons.arrow_left),
                    onPressed: () => Navigator.of(context).pop()),
                title: Text("Post Information")),
            SliverList(
                delegate: SliverChildListDelegate([
              _postForm(),
            ])),
            buildGridView(),
            _isUploadingView()
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
              "Post Title *",
              TextFormField(
                autofocus: true,
                controller: _titleController,
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please Enter Some Text";
                  }
                  return null;
                },
                onChanged: (value) {
                  print(_titleController.text);
                  CoreData.coreDataObject.appProduct.name =
                      _titleController.text;
                },
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            _formField(
                "Brand *",
                TextFormField(
                  //autofocus: true,
                  controller: _brandController,
                  //focusNode: FocusNode(),
                  readOnly: true,
                  // enableInteractiveSelection: false,
                  //enabled: false,
                  decoration: InputDecoration(
                      hintText: "Select Brand",
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      suffixIcon: Icon(
                        LineAwesomeIcons.sort,
                        color: Colors.black,
                      )),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please Enter Some Text";
                    }
                    return null;
                  },
                  onTap: () {
                    //print("hello Tapped");
                    showBarModalBottomSheet(
                      expand: false,
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context, scrollController) =>
                          _brandModal(scrollController),
                    );
                  },
                  onChanged: (value) {
                    //CoreData.coreDataObject.appProduct.brandid = 1;
                  },
                )),
            SizedBox(
              height: 20.0,
            ),
            _formField(
                "Describe what you are selling *",
                TextFormField(
                  autofocus: true,
                  controller: _descriptionController,
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
                    CoreData.coreDataObject.appProduct.description =
                        _descriptionController.text;
                  },
                )),
            SizedBox(
              height: 10.0,
            )
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

  Future<void> loadAssets() async {
    List<Asset> resultList;
    String error;
    setState(() {
      images = List<Asset>();
    });
    try {
      resultList = await MultiImagePicker.pickImages(
          maxImages: 300,
          enableCamera: true,
          materialOptions: MaterialOptions(
            actionBarColor: "#48ac98",
            statusBarColor: "#48ac98",
          ));
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      if (error == null) _error = 'No Error Dectected';
    });
  }

  Widget buildGridView() {
    if (images != null && images.length > 0) {
      if (postImageURL.isEmpty)
        setState(() {
          isUploading = true;
        });
      return SliverGrid(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            Asset asset = images[index];
            _upload(asset);
            return Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 0.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: AssetThumb(
                  quality: 100,
                  asset: asset,
                  width: 300,
                  height: 300,
                ),
              ),
            );
          }, childCount: images.length),
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5));
    } else {
      return SliverList(
        delegate: SliverChildListDelegate(
          [Container(color: Colors.white)],
        ),
      );
    }
  }

  Widget _isUploadingView() {
    if (isUploading) {
      return SliverList(
        delegate: SliverChildListDelegate(
          [
            Container(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "Image is Uploading ...",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return SliverList(
        delegate: SliverChildListDelegate(
          [Container(color: Colors.white)],
        ),
      );
    }
  }

  //TODO: Refactor this code
  void _next() {
    setState(() {
      if (_formKey.currentState.validate() && (postImageURL != null)) {
        List<img.Image> _images = List<img.Image>();
        img.Image _image = img.Image(url: postImageURL);
        _images.add(_image);
        CoreData.coreDataObject.appProduct.images = _images;
        Navigator.of(context).pushNamed(PostFormNextRoute);
      }
    });
  }

  _upload(Asset image) async {
    String imgUrl = "";
    var byteData = await image.getByteData();
    List<int> imageData = byteData.buffer.asUint8List();
    String result = base64.encode(imageData);
    imgUrl = await productRepository.postImage(result);
    setState(() {
      postImageURL = imgUrl;
      isUploading = false;
      // _isUploadingView();
    });
    //return imgUrl;
  }

  Widget _buttomAppButton() {
    return BottomAppBar(
      child: Container(
        color: Theme.of(context).canvasColor,
        child: Row(
          //crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                    iconSize: 35,
                    icon: Icon(LineAwesomeIcons.alternate_long_arrow_right),
                    onPressed: () =>
                        Navigator.of(context).pushNamed(PostImageRoute)),
                Text("Next")
              ],
            )
          ],
        ),
      ),
    );
    //UtilityWidget.materialButton(context, "Next",onPress: () => Navigator.of(context).pushNamed(PostImageRoute))
  }

  List<Brand> getBrandByCategory(int categoryID) {
    List<Brand> result = new List<Brand>();
    var appBrands = CoreData.coreDataObject.appBrands;
    if (appBrands.isNotEmpty) {
      result = appBrands.where((xx) => xx.categoryid == categoryID).toList();
    }
    return result;
  }

  Widget _brandModal(ScrollController controller) {
    return Material(
      type: MaterialType.card,
      child: ListView.separated(
          separatorBuilder: (context, index) => Divider(
                color: Colors.black,
              ),
          shrinkWrap: true,
          controller: controller,
          itemCount: brandCategories.length,
          itemBuilder: (BuildContext context, int index) {
            var brand = brandCategories[index];
            return ListTile(
              enabled: true,
              title: Text(brand.brandname),
              onTap: () {
                _brandController.text = brand.brandname;
                Navigator.of(context).pop();
                CoreData.coreDataObject.appProduct.brandid = brand.brandid;
                CoreData.coreDataObject.appProduct.categoryid =
                    brand.categoryid;
                print(brand.brandname);
              },
            );
          }),
    );
  }

  /*Widget _brandModall(BuildContext contextt, ScrollController controller) {
    return Material(
        child: SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: brandCategories.map((xx) {
          return ListTile(
            title: Text(xx.brandname),
          );
        }).toList(),
      ),
    ));
  }*/
}

/*GridView.count(


        crossAxisCount: 4,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 5.0,
        scrollDirection: Axis.vertical,
        children: List.generate(images.length, (index) {
          Asset asset = images[index];
          return ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
                      child: AssetThumb(
              asset: asset,
              width: 300,
              height: 300,
            ),
          );
        }),
      );*/
