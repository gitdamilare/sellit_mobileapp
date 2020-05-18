import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:sellit_mobileapp/data/productrepository.dart';

class TestScreen extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<TestScreen> {
  List<Asset> images = List<Asset>();
  String _error;
  ProductRepository productRepository = ProductService();
  @override
  void initState() {
    super.initState();
  }

  Widget buildGridView() {
    if (images != null){
    // images.length > 0 ? _upload(images[0]) : null;
      return GridView.count(
        crossAxisCount: 4,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 5.0,
        scrollDirection: Axis.vertical,
        children: List.generate(images.length, (index) {
          Asset asset = images[index];
          //_upload(asset);
          return Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                          child: AssetThumb(
                  asset: asset,
                  width: 300,
                  height: 300,
                ),
              ),
            ],
          );
        }),
      );
    }
    else{
      return Container(color: Colors.white);
    }

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

  Future<String> _upload(Asset image) async{
    String imgUrl = "";
    var byteData = await image.getByteData();
    List<int> imageData = byteData.buffer.asUint8List();
    String result = base64.encode(imageData);
    productRepository.postImage(result).then((data) {
      setState((){
        imgUrl = data;
      });
      return imgUrl;
    });
    return imgUrl;
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: <Widget>[
            Center(child: Text('Error: $_error')),
            RaisedButton(
              child: Text("Pick images"),
              onPressed: loadAssets,
            ),
            Expanded(
              child: buildGridView(),
            )
          ],
        ),
      ),
    );
  }
}
