import 'package:flutter/material.dart';
//import 'package:path/path.dart';
import 'package:sellit_mobileapp/models/category.dart';
import 'package:sellit_mobileapp/models/outputDtos/chatoutputDto.dart';
import 'package:sellit_mobileapp/models/product.dart';
import 'package:sellit_mobileapp/routes/routelinks.dart';
import 'package:sellit_mobileapp/screens/buttomNav.dart';
//import 'package:sellit_mobileapp/screens/categoryscreen.dart';
import 'package:sellit_mobileapp/screens/cats.dart';
import 'package:sellit_mobileapp/screens/login.dart';
import 'package:sellit_mobileapp/screens/messageList.dart';
import 'package:sellit_mobileapp/screens/postproduct/imageform.dart';
import 'package:sellit_mobileapp/screens/postproduct/postform.dart';
import 'package:sellit_mobileapp/screens/postproduct/postformnext.dart';
import 'package:sellit_mobileapp/screens/postproduct/postproductcategory.dart';
import 'package:sellit_mobileapp/screens/postproduct/postproductsubcategory.dart';
import 'package:sellit_mobileapp/screens/productdetails.dart';
import 'package:sellit_mobileapp/screens/subcategoryscreen.dart';
import 'package:sellit_mobileapp/screens/testScreen/test.dart';

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
            builder: (context) => CategoryLists(
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
      case PostProductRoute:
        return MaterialPageRoute(
            builder: (context) => PostProductCategory(),
            fullscreenDialog: true);
      case PostSubCategoryRoute:
        var data = settings.arguments as Category;
        return MaterialPageRoute(
            builder: (context) => PostProductSubCategory(data: data),
            fullscreenDialog: true);
      case PostFormRoute:
        var data = settings.arguments;
        return MaterialPageRoute(
            builder: (context) => PostForm(
                  category: data,
                ),
            fullscreenDialog: true);
      case PostFormNextRoute:
        return MaterialPageRoute(
            builder: (context) => PostFormNext(), fullscreenDialog: true);
      case TestRoute:
        //var data = settings.arguments as Category;
        return MaterialPageRoute(
            builder: (context) => TestScreen(), fullscreenDialog: true);
      case PostImageRoute:
        //var data = settings.arguments as Category;
        return MaterialPageRoute(
            builder: (context) => PostImage(), fullscreenDialog: true);
      case ChatMessagesRoute:
         var data = settings.arguments as ChatMessagerDto;
        return MaterialPageRoute(
            builder: (context) => ChatMessages(chatMessagerDto: data,), fullscreenDialog: true , );
    }
  }
}
