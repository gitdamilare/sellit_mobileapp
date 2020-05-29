import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sellit_mobileapp/models/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:sellit_mobileapp/utilis/urlLinks.dart';

abstract class ProductRepository {
  Future<List<Product>> getAllProducts(int startIndex, int limit);
  Future<String> postImage(String image);
  Future<String> postProduct(Product product);
  Future<List<Product>> getAllUserProducts(int userId);
}

class ProductService extends ProductRepository {
  @override
  Future<List<Product>> getAllProducts(int startIndex, int limit) async {
    List<Product> products = List<Product>();
    try {
      var response = await http.get(GetProductApi + "$startIndex/$limit");
      if (response.statusCode == 200) {
        var jsonbody = convert.jsonDecode(response.body);
        var jsonmap = jsonbody["products"];
        if (jsonmap != null) {
          jsonmap.forEach((e) {
            products.add(Product.fromJson(e));
          });
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return products;
  }

  /*Function to Send Post Image to ImgBB API */
  @override
  Future<String> postImage(image) async {
    try {
      var response = await http.post(ImgBBAPI, body: {"image": image});
      if (response.statusCode == 200) {
        var jsonBody = response.body;
        var output = convert.jsonDecode(jsonBody);
        var result = output["data"];
        String imgUrl = result["display_url"];
        return imgUrl;
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  @override
  Future<String> postProduct(Product product) async {
    try {
      var encodedBody = convert.jsonEncode(product);
      print(encodedBody);
        String result = await Future<String>.delayed(Duration.zero, () {
            return "Hello";
              });
      /*var response = await http.post(PostProductAPI,
          body: encodedBody,
          headers: {HttpHeaders.contentTypeHeader: "application/json"});
      if(response.statusCode == 200){
        var jsonBody = response.body;
        var mappedJson = convert.jsonDecode(jsonBody);
        var result = mappedJson["status"];
        return result;
      }*/
      return result;
    } catch (e) {
        print(e);
    }
    return null;
  }

  @override
  Future<List<Product>> getAllUserProducts(int userId) async{
    List<Product> products = new List<Product>();
    try{ 
      var response = await http.get(GetUserProductAPI + "$userId");
      if(response.statusCode == 200){
        var jsonBody = convert.jsonDecode(response.body);
        var jsonMap = jsonBody["products"];
        if(jsonMap != null){
          jsonMap.forEach((e){
            products.add(Product.fromJson(e));
          });
        }
      }
    }catch(e){
      debugPrint(e.toString());
    }
    return products;
  }



}
