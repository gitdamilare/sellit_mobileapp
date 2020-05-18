import 'dart:io';
import 'dart:math';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sellit_mobileapp/models/category.dart';
import 'package:sellit_mobileapp/routes/routelinks.dart';
import 'package:sellit_mobileapp/services/coredata.dart';
import 'package:sellit_mobileapp/utilis/utili.dart';

class PostProduct extends StatefulWidget {
  PostProduct({Key key}) : super(key: key);

  @override
  _PostProductState createState() => _PostProductState();
}

class _PostProductState extends State<PostProduct> {
  List<Category> appCategories = List<Category>();
  @override
  void initState() {
    // TODO: implement initState
    appCategories = CoreData.coreDataObject.appCategories;
    print(appCategories.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => _exitApp(context, "QUIT WITHOUT SAVING ?", "Your progress on this post will be lost",true),
            child: Scaffold(
              backgroundColor: UtilityWidget.white,
          body: CustomScrollView(
            
            slivers: <Widget>[
              SliverAppBar(             
                brightness: Brightness.light,
                pinned: true,
                backgroundColor: UtilityWidget.white,
                leading: IconButton(
                    icon: Icon(
                      LineAwesomeIcons.times,
                      color: Colors.black,
                    ),
                    onPressed: () =>
                        _exitApp(context, "QUIT WITHOUT SAVING ?", "Your progress on this post will be lost",false) //Navigator.of(context).pop(),
                    ),
                title: Text(
                  "WHAT ARE YOU SELLING ?",
                  style: Theme.of(context).textTheme.subtitle,
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                  )
                ]),
              ),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                delegate: SliverChildBuilderDelegate((BuildContext context, index) {
                  return _buildRow(
                      appCategories[index], index, appCategories.length);
                }, childCount: appCategories.length),
              )
            ],
          ),
        ),
      );
  }

  Widget _buildRow(Category category, int index, int length) {
    return GestureDetector(
      onTap: () {
        if (category.subCategories.length > 0) {
          Navigator.of(context)
              .pushNamed(PostSubCategoryRoute, arguments: category);
        }
      },
      child: Container(
        width: 100,
        height: 200,
        decoration: _boxDecoration(index, length),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            UtilityWidget.categoryIconCreator(category.name, 40),
            Text(category.name, style: TextStyle(fontSize: 12.5)),
          ],
        )),
      ),
    );
  }

  BoxDecoration _boxDecoration(int index, int length) {
    BorderSide _borderSide() {
      return BorderSide(width: 0.5, color: Colors.grey);
    }

    if (index.isOdd) {
      /* Check if this is the last odd number */
      if ((length - index == 1) || (length - index == 2)) {
        return BoxDecoration(border: Border(left: _borderSide()));
      }
      return BoxDecoration(
          border: Border(bottom: _borderSide(), left: _borderSide()));
    } else {
      /* Check if this is the last even number */
      if ((length - index == 1) || (length - index == 2)) {
        return BoxDecoration(border: Border(left: _borderSide()));
      }
      return BoxDecoration(
          border: Border(
        bottom: _borderSide(),
      ));
    }
    //return BoxDecoration(border: Border.all(width: 0.2,color: Colors.grey));
  }

  Future<bool> _exitApp(BuildContext pageContext, String title, String body, bool backButton){
        return showGeneralDialog(
        barrierDismissible: false,
        barrierColor: Colors.black.withOpacity(0.75),
        context: context,
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
                          child: Text(
                              body,
                              style: Theme.of(context).textTheme.caption)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        //crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          FlatButton(
                            child: Text("CANCEL", style: TextStyle(color:Theme.of(context).accentColor,)),
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                          ),
                          FlatButton(
                            child: Text("DISCARD", style: TextStyle(color:Theme.of(context).accentColor,)),
                            onPressed: () {
                              //Navigator.of(context).pop(false);
                              if(!backButton){
                                //Navigator.of(context).pop();
                                Navigator.of(pageContext).pop();
                              }
                              Navigator.of(pageContext).pop(true);
                            },
                          ),
                        ],
                      )
                    ],
                  )));
        }) ?? false;
  }
}
