import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sellit_mobileapp/models/outputDtos/authoutputDto.dart';
import 'package:sellit_mobileapp/models/product.dart';
import 'package:sellit_mobileapp/services/root.dart';

class JsonRepo {
  JsonRepo._();
  static final JsonRepo jsonRepoObject = JsonRepo._();

  Future<File> writeAccountDataToJson(AuthOutputDto input) async {
    try {
      if (input != null) {
        var data = input.toJson();
        var jsonData = json.encode(data);
        File jsonFile = await Root.rootObject.localFile();
        return jsonFile.writeAsString(jsonData);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(e);
      return null;
    }
  }

  Future<AuthOutputDto> getDatafromJsonFile() async {
    try {
      //final file = Root.rootObject.localPath;
      final file = await Root.rootObject.localFile();
      dynamic reading = await file.readAsString();
      dynamic decoding = json.decode(reading);
      AuthOutputDto application = AuthOutputDto.fromJson(decoding);
      return application;
    } catch (e) {
      return null;
    }
  }

   Future<File> writeUserProductDataToJson(List<Product> input) async {
   File jsonFile = await Root.rootObject.localProductFile();
    try {
      if (input != null) {
        input.forEach((e)  {
                  var data = e.toJson();
        var jsonData = json.encode(data);     
        return jsonFile.writeAsString(jsonData);
        });
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(e);
      return null;
    }
  }

   Future<List<Product>> getProductDataJsonFile() async {
     List<Product> result = new List<Product>();
    try {
      final file = await Root.rootObject.localProductFile();
      dynamic reading = await file.readAsString();
      dynamic decoding = json.decode(reading);
      decoding.forEach((e)  {
        Product application = Product.fromJson(decoding);
        result.add(application);
      });
      
      return result;
    } catch (e) {
      return null;
    }
  }
}
