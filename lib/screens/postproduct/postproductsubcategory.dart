import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sellit_mobileapp/models/category.dart';
import 'package:sellit_mobileapp/routes/routelinks.dart';

class PostProductSubCategory extends StatefulWidget {
 //ProductSubCategory({Key key, Category data}) : super(key: key);
  final Category data;
  PostProductSubCategory({this.data});
  @override
  _PostProductSubCategoryState createState() => _PostProductSubCategoryState();
}

class _PostProductSubCategoryState extends State<PostProductSubCategory> {
  Category _category = Category();
  @override
  void initState() {
    // TODO: implement initState
    _category = widget.data;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: CustomScrollView(
         slivers: <Widget>[
           SliverAppBar(
            backgroundColor: Theme.of(context).canvasColor,
            leading: IconButton(
              icon: Icon(LineAwesomeIcons.arrow_left), 
            onPressed: () => Navigator.of(context).pop()),
            title: Text(_category.name),
           ),
           SliverList(
             delegate: SliverChildBuilderDelegate((BuildContext context,int index){
               //final int itemIndex = index ~/ 2;
                  return _buildRow(_category.subCategories[index], context);
             }, childCount: _category.subCategories.length),)
         ],
       )
    );
  }

    Widget _buildRow(Category category, BuildContext context) {
    return Column(
        children: <Widget>[
          ListTile(
            title: Text(category.name),
            onTap: () => Navigator.of(context).pushNamed(PostFormRoute,arguments: category),
          ),
          Divider(thickness: 1.0,)
        ],
      );
  }
}