import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:sellit_mobileapp/models/category.dart';
import 'package:sellit_mobileapp/utilis/utili.dart';

class SubCategoryList extends StatefulWidget {
  //final List<Category> categories;
  final Category category;

  SubCategoryList({this.category});
  @override
  State<StatefulWidget> createState() {
    return _SubCategoryListState();
  }
}

class _SubCategoryListState extends State<SubCategoryList> {
  //Application applicationData;
  //List<Category> _categories = List<Category>();
 Category _category = Category();

  @override
  void initState() {
    super.initState();
    _category = widget.category;
  }

  @override
  Widget build(BuildContext context) {
    var textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(_category.name,
            style: Theme.of(context).textTheme.title,
          ),
         backgroundColor: Colors.white,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          )),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(0.0),
          child: _buildSuggestions(),
        ),
      ),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(2.5),
        itemCount: _category.subCategories.length,
        itemBuilder: (BuildContext _context, int i) {
          return _buildRow(_category.subCategories[i], _context);  
        }
        );
  }

  Widget _buildRow(Category category, BuildContext context) {
    return  ListTile(
            
            contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            /*leading: Container(
              padding: EdgeInsets.only(right: 8.0),
              child: UtilityWidget.categoryAvatarCreator(category.name),
            ),*/
            title: Text(
              category.name,
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w400),
            ), //_trailing(_data,context),
            onTap: () {
              // _navigationLogic(category.id, _data, context);
            },
          );
    
   /* Card(
        //elevation: 6.0,
        //margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: 
        );*/
  }
}

Widget _maintrailing(int count, BuildContext context) {
  return SizedBox(
    width: 100,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Badge(
          elevation: 0,
          shape: BadgeShape.circle,
          padding: EdgeInsets.all(7),
          badgeContent: Text(
            count.toString(),
            style: TextStyle(color: Colors.white),
          ),
        ),
        _showIcon(count),
      ],
    ),
  );
}

Widget _showIcon(int data) {
  if (data > 0) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Icon(
        Icons.arrow_forward_ios,
        size: 20,
        color: Colors.black,
      ),
    );
  } else {
    return Container(
      width: 0,
      height: 0,
    );
  }
}

/*void _navigationLogic(int categoryId, List<Program> programs, BuildContext context) {
  if (programs.length > 0) {
    //Navigator.pop(context);
    Navigator.pushReplacementNamed(context, NavWrapper, arguments: ScreenArguments(
      programs: programs ,selected: 0 , categoryId: categoryId
    ));
    
  } else {
    UtilityWidget.displaySnackBar(
        context, "There is no Program available under this Category");
  }
}*/
