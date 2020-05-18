import 'package:flutter/material.dart';
import 'package:sellit_mobileapp/models/category.dart';
import 'package:sellit_mobileapp/models/product.dart';
import 'package:sellit_mobileapp/models/user.dart';

class CoreData{
  CoreData._();
  static final CoreData coreDataObject = CoreData._();

  List<Category> appCategories = List<Category>();

  Product appProduct = Product();

  User userInfo = User();
}