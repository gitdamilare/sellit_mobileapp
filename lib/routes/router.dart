import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sellit_mobileapp/routes/routelinks.dart';
import 'package:sellit_mobileapp/screens/buttomNav.dart';
import 'package:sellit_mobileapp/screens/login.dart';
import 'package:sellit_mobileapp/screens/productdetails.dart';

class Router{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case LoginRoute:
        return MaterialPageRoute(builder: (context) => Login());
      case ExploreRoute:
        return MaterialPageRoute(builder: (context)=> BottomNavWrapper());
      case ProductDetailsRoute:
        return MaterialPageRoute(builder: (context)=> ProductDetails() , fullscreenDialog: true);
    }
  }
}