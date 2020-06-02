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


  /*File pickedImage;
  var text = '';
  bool isImageLoaded = false;
  FirebaseVisionImage ourImage;

  List _items = [];

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

  Future readText() async {
    //TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    final ImageLabeler labeler = FirebaseVision.instance.imageLabeler();
    ourImage = FirebaseVisionImage.fromFile(pickedImage);
    //VisionText visionText = await recognizeText.processImage(ourImage);
    final List<ImageLabel> labels = await labeler.processImage(ourImage);

    for (ImageLabel label in labels) {
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
    }

    setState(() {});
  }

  /*return Center(
        child: MaterialButton(
      onPressed: pickImage,
      minWidth: 80.0,
      height: 32.0,
      child: Text(
        "Pick Image",
        style: TextStyle(fontSize: 20.0),
      ),
    ));
  }*/ */