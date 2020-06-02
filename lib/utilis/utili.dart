import 'dart:math';

import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UtilityWidget {
  static CircleAvatar categoryAvatarCreator(String categoryname) {
    switch (categoryname.toLowerCase()) {
      case "electronics":
        //return circleAvatarSelector(Colors.amber, Icons.phone_iphone);
        return circleAvatarSelector(
            Colors.grey.shade200, LineAwesomeIcons.mobile_phone);
        break;
      case "furniture":
        //return circleAvatarSelector(Colors.cyan, Icons.event_seat);
        return circleAvatarSelector(
            Colors.grey.shade200, LineAwesomeIcons.chair);
        break;
      case "fashion":
        //return circleAvatarSelector(Colors.brown, LineAwesomeIcons.t_shirt);
        return circleAvatarSelector(
            Colors.grey.shade200, LineAwesomeIcons.t_shirt);
        break;
      case "vehicles":
        //return circleAvatarSelector(Colors.lightBlueAccent, Icons.directions_car);
        return circleAvatarSelector(Colors.grey.shade200, LineAwesomeIcons.car);
        break;
      case "textbook":
        // return circleAvatarSelector(Colors.redAccent, Icons.library_books);
        return circleAvatarSelector(
            Colors.grey.shade200, LineAwesomeIcons.book);
        break;
      default:
        //return circleAvatarSelector(Colors.indigo, Icons.library_books);
        return circleAvatarSelector(
            Colors.grey.shade200, LineAwesomeIcons.alternate_compress_arrows);
    }
  }

  static CircleAvatar circleAvatarSelector(
      Color avatarColor, IconData avatarIcon) {
    return CircleAvatar(
        backgroundColor: avatarColor,
        radius: 30,
        child: Center(
            child: Icon(
          avatarIcon,
          color: Color(0xFF676E79),
          size: 30,
        )));
  }

  static Icon categoryIconCreator(String categoryname, double iconsize) {
    switch (categoryname.toLowerCase()) {
      case "electronics":
        return Icon(
          LineAwesomeIcons.mobile_phone,
          size: iconsize,
        );
        break;
      case "furniture":
        return Icon(
          LineAwesomeIcons.chair,
          size: iconsize,
        );
        break;
      case "fashion":
        return Icon(
          LineAwesomeIcons.t_shirt,
          size: iconsize,
        );
        break;
      case "vehicles":
        return Icon(
          LineAwesomeIcons.car,
          size: iconsize,
        );
        break;
      case "textbook":
        return Icon(
          LineAwesomeIcons.book,
          size: iconsize,
        );
        break;
      default:
        return Icon(
          LineAwesomeIcons.alternate_compress_arrows,
          size: iconsize,
        );
    }
  }

  static void showExistDialog(
      BuildContext pageContext, String title, String body) {
    showGeneralDialog(
        barrierDismissible: false,
        barrierColor: Colors.black.withOpacity(0.75),
        context: pageContext,
        transitionDuration: const Duration(milliseconds: 50),
        pageBuilder: (BuildContext context, Animation animation,
            Animation secondAnimation) {
          return Center(
              child: Container(
                  width: MediaQuery.of(context).size.width - 50,
                  height: MediaQuery.of(context).size.width - 250.0,
                  color: Colors.white,
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 15.0),
                          child: Text(title,
                              style: Theme.of(context).textTheme.body1)),
                      Padding(
                          padding: EdgeInsets.fromLTRB(24.0, 3.5, 24.0, 24.0),
                          child: Text(body,
                              style: Theme.of(context).textTheme.caption)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        //crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          FlatButton(
                            child: Text("CANCEL",
                                style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                )),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          FlatButton(
                            child: Text("DISCARD",
                                style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                )),
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(pageContext).pop();
                            },
                          ),
                        ],
                      )
                    ],
                  )));
        });
  }

  static MaterialButton materialButton(BuildContext context, String title,
      {VoidCallback onPress}) {
    return MaterialButton(
      height: 50.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1.0)),
      child: Text(
        title,
        textScaleFactor: 1.5,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      color: Theme.of(context).accentColor,
      elevation: 2.0,
      onPressed: onPress,
    );
  }

  static MaterialColor white = const MaterialColor(
    0xFFFFFFFF,
    const <int, Color>{
      50: const Color(0xFFFFFFFF),
      100: const Color(0xFFFFFFFF),
      200: const Color(0xFFFFFFFF),
      300: const Color(0xFFFFFFFF),
      400: const Color(0xFFFFFFFF),
      500: const Color(0xFFFFFFFF),
      600: const Color(0xFFFFFFFF),
      700: const Color(0xFFFFFFFF),
      800: const Color(0xFFFFFFFF),
      900: const Color(0xFFFFFFFF),
    },
  );

  static Text getProductStatusText(int status) {
    /* 'Approved': 1,'Sold': 2,'Under_Review': 3,"Inactive": 4,"Deleted" : 5*/
    switch (status) {
      case 1:
        return _productStatusText("Approved", Color(0xFF48AC98));
      case 2:
        return _productStatusText("Sold", Color(0xFF48AC98));
      case 3:
        return _productStatusText("Pending", Colors.amber);
      case 4:
        return _productStatusText("Inactive", Colors.redAccent);
    }
  }

  static Text _productStatusText(String text, Color textColor) {
    return Text(
      text.toUpperCase(),
      style: TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
          color: textColor),
    );
  }

  static String getSearchText(String text) {
    /* 'Approved': 1,'Sold': 2,'Under_Review': 3,"Inactive": 4,"Deleted" : 5*/
    var result = ""; 
    text = text.toLowerCase();
    if(text == "vehicle") result = "Car";
    if(text == "mobile phone") result = "Phone";
    if(text == "computer") result = "Phone";
        

    return result;
  }
}

/*
  p: theme.textTheme.body1,
  h1 theme.textTheme.headline,
  h2: theme.textTheme.title,
  h3: theme.textTheme.subhead,
  h4: theme.textTheme.body2,
  h5: theme.textTheme.body2,
  h6: theme.textTheme.body2,
*/
