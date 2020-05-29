import 'package:flutter/material.dart';
import 'package:sellit_mobileapp/models/brand.dart';
import 'package:sellit_mobileapp/models/category.dart';
import 'package:sellit_mobileapp/models/product.dart';
import 'package:sellit_mobileapp/models/user.dart';

class CoreData{
  CoreData._();
  static final CoreData coreDataObject = CoreData._();

  List<Category> appCategories = List<Category>();

  Product appProduct = Product();

  User userInfo = User();

  List<Brand> appBrands =  List<Brand>();

  List<ProductCondition> appProductCondition = [
    ProductCondition(id: 1, name: "Very Good"),
     ProductCondition(id: 2, name: "Good"),
      ProductCondition(id: 3, name: "Poor")
  ];
}