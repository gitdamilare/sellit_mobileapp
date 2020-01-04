import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:sellit_mobileapp/models/category.dart';

/*abstract class GenericRepository{
  Future<T> read<T extends List,K extends dynamic>(String url, String key);
  //Future<T> read(String url, String key);
}*/

/*class GenericService extends GenericRepository{
  @override
  Future<T> read<T extends List, K extends dynamic>(String url, String key) async {
    T objs;
    K obj;
    try{
      var response = await http.get(url);
      if(response.statusCode == 200){
        var jsonBody = response.body;
        var result = convert.jsonDecode(jsonBody);
        var output = result[key];
        if(output != null){
          var outputList = output.toList();
          outputList.forEach((e) {
            objs.add(obj.fromJson(e));
          });
        }
      }
    }catch(e){
      debugPrint(e.toString());
    }

    return objs;
  }
  
}*/

class GenericService<T extends List, K extends dynamic> {
  T objs;
  K obj;

  GenericService(T objs , K obj){
    this.objs = objs;
    this.obj = obj;
  }
  Future<T> read(String url, String key) async {
        try{
      var response = await http.get(url);
      if(response.statusCode == 200){
        var jsonBody = response.body;
        var result = convert.jsonDecode(jsonBody);
        var output = result[key];
        if(output != null){
          var outputList = output.toList();
          outputList.forEach((e) {
            if(obj is Category){
              objs.add(Category.fromJson(e));
            }
          });
        }
      }
    }catch(e){
      debugPrint(e.toString());
    }

    return this.objs;
  }

}