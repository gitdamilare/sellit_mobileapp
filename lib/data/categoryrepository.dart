import 'package:flutter/material.dart';
import 'package:sellit_mobileapp/data/genericRepo.dart';
import 'package:sellit_mobileapp/models/category.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:sellit_mobileapp/utilis/urlLinks.dart';

abstract class CategoryRepository {
  Future<List<Category>> getAllCategories();
}

class CategoryService extends CategoryRepository {
  @override
  Future<List<Category>> getAllCategories() async {
    List<Category> result = List<Category>();
    try {
      /*GenericService<List<Category>,Category> genericService = new GenericService<List<Category>,Category>(result,obj);
      result = await genericService.read(GetCategoriesApi, "rows");*/
      var response = await http.get(GetCategoriesApi);
      if (response.statusCode == 200) {
        var jsonbody = convert.jsonDecode(response.body);
        var jsonmap = jsonbody["rows"];
        if (jsonmap != null) {
          jsonmap.forEach((e) {
            result.add(Category.fromJson(e));
          });
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return result;
  }
}
