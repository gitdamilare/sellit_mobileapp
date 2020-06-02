import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:sellit_mobileapp/models/category.dart';
import 'package:sellit_mobileapp/routes/routelinks.dart';
import 'package:sellit_mobileapp/utilis/utili.dart';

class CategoryLists extends StatefulWidget {
  final List<Category> categories;

  CategoryLists({this.categories});
  @override
  State<StatefulWidget> createState() {
    return _CategoryListState();
  }
}

class _CategoryListState extends State<CategoryLists> {
  //Application applicationData;
  List<Category> _categories = List<Category>();

  @override
  void initState() {
    super.initState();
    _categories = widget.categories;
  }

  @override
  Widget build(BuildContext context) {
    //var textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        /*appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "Categories",
            style: Theme.of(context).textTheme.title,
          ),
         backgroundColor: Colors.white,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          )),*/
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              brightness: Brightness.light,
              backgroundColor: Colors.white,
              leading: new IconButton(
                icon: new Icon(Icons.arrow_back_ios, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(
                "Categories",
                style: Theme.of(context).textTheme.title,
              ),
              expandedHeight: 40.0,
              pinned: true,
            ),
            SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                return _buildRow(_categories[index], context);
              }, childCount: _categories.length , ),
            )
          ],
        ));
  }

  /*Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(2.5),
        itemCount: _categories.length,
        itemBuilder: (BuildContext _context, int i) {
          return _buildRow(_categories[i], _context);
        });
  }*/

  Widget _buildRow(Category category, BuildContext context) {
    return Card(
      elevation: 6.0,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
        leading: Container(
          padding: EdgeInsets.only(right: 8.0),
          /*decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(width: 1.5, color: Colors.grey),
                ),
              ),*/
          child: UtilityWidget.categoryAvatarCreator(category.name),
        ),
        title: Text(
          category.name,
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500),
        ),
        trailing: _maintrailing(
            category.subCategories.length, context), //_trailing(_data,context),
        onTap: () {
          _navigationLogic(category, context);
        },
      ),
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

void _navigationLogic(Category input, BuildContext context) {
  if (input.subCategories.length > 0) {
    Navigator.pushNamed(context, SubCategoryRoute, arguments: input);
    //Navigator.pushReplacementNamed(context, SubCategoryRoute, arguments: input);
  } else {
    /*UtilityWidget.displaySnackBar(
        context, "There is no Program available under this Category");*/
  }
}
