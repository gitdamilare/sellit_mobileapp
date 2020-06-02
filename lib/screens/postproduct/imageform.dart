import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:sellit_mobileapp/data/productrepository.dart';
import 'package:sellit_mobileapp/models/category.dart';
import 'package:sellit_mobileapp/routes/routelinks.dart';

class PostImage extends StatefulWidget {
 //ProductSubCategory({Key key, Category data}) : super(key: key);

  PostImage();
  @override
  _PostImageState createState() => _PostImageState();
}

class _PostImageState extends State<PostImage> {
    List<Asset> images = List<Asset>();
  String _error;
  ProductRepository productRepository = ProductService();
  @override
  void initState() {
    //loadAssets();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: CustomScrollView(
         slivers: <Widget>[
           SliverAppBar(
            backgroundColor: Theme.of(context).canvasColor,
            leading: IconButton(
              icon: Icon(LineAwesomeIcons.arrow_left), 
            onPressed: () => Navigator.of(context).pop()),
            title: Text("Set a Price"),
           ),
         ],
       )
    );
  }


    Widget _buildRow(BuildContext context) {
    return null;
  }

    Future<void> loadAssets() async {
    setState(() {
      images = List<Asset>();
    });

    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        materialOptions: MaterialOptions(
          actionBarColor: "#48ac98",) 
      );
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
}