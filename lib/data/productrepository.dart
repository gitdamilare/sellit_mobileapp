import 'package:flutter/material.dart';
import 'package:sellit_mobileapp/models/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:sellit_mobileapp/utilis/urlLinks.dart';
abstract class ProductRepository{
  Future<List<Product>> getAllProducts(int startIndex, int limit);
}

class ProductService extends ProductRepository{
  @override
  Future<List<Product>> getAllProducts(int startIndex, int limit) async {
    List<Product> products = List<Product>();
    try{
        var response = await http.get(GetProductApi + "$startIndex/$limit");
        if(response.statusCode == 200){
          var jsonbody = convert.jsonDecode(response.body);
          var jsonmap = jsonbody["products"];
          if(jsonmap != null){
            jsonmap.forEach((e) {
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

