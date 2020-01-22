import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UtilityWidget {
 static   CircleAvatar categoryAvatarCreator(String categoryname) {
    switch (categoryname.toLowerCase()) {
      case "electronics":
        return circleAvatarSelector(Colors.amber,Icons.phone_iphone);
        break;
      case "furniture":
        return circleAvatarSelector(Colors.cyan,Icons.event_seat);
        break;
      case "fashion":
        return circleAvatarSelector(Colors.brown,Icons.people);
        break;
            case "vehicles":
        return circleAvatarSelector(Colors.lightBlueAccent,Icons.directions_car);
        break;
            case "textbook":
        return circleAvatarSelector(Colors.redAccent,Icons.library_books);
        break;
      default:
        return circleAvatarSelector(Colors.indigo,Icons.library_books);
    }
  }

  static CircleAvatar circleAvatarSelector(Color avatarColor, IconData avatarIcon){
    return  CircleAvatar(
          backgroundColor: avatarColor,
          radius: 30,
          child: Center(child: Icon(avatarIcon,color: Colors.black,size: 30,))
        );
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
