import 'package:flutter/material.dart';
import 'package:sellit_mobileapp/models/category.dart';
import 'package:sellit_mobileapp/models/product.dart';
import 'package:sellit_mobileapp/routes/routelinks.dart';
import 'package:sellit_mobileapp/screens/buttomNav.dart';
import 'package:sellit_mobileapp/screens/categoryscreen.dart';
import 'package:sellit_mobileapp/screens/login.dart';
import 'package:sellit_mobileapp/screens/productdetails.dart';
import 'package:sellit_mobileapp/screens/subcategoryscreen.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginRoute:
        return MaterialPageRoute(builder: (context) => Login());
      case ExploreRoute:
        return MaterialPageRoute(builder: (context) => BottomNavWrapper());
      case ProductDetailsRoute:
        var data = settings.arguments as Product;
        return MaterialPageRoute(
            builder: (context) => ProductDetails(
                  product: data,
                ),
            fullscreenDialog: true);
      case CategoryRoute:
        var data = settings.arguments as List<Category>;
        return MaterialPageRoute(
            builder: (context) => CategoryList(
                  categories: data,
                ),
            fullscreenDialog: true);
      case SubCategoryRoute:
        var data = settings.arguments;
        return MaterialPageRoute(
            builder: (context) => SubCategoryList(
                  category: data,
                ),
            fullscreenDialog: true);
    }
  }
}
