import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Chat extends StatefulWidget {
  Chat({Key key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  File pickedImage;
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

  @override
  Widget build(BuildContext context) {
    return Center(
        child: MaterialButton(
      onPressed: pickImage,
      minWidth: 80.0,
      height: 32.0,
      child: Text(
        "Pick Image",
        style: TextStyle(fontSize: 20.0),
      ),
    ));
  }
}
