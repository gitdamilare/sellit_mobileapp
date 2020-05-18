import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "My ADS",
          style: Theme.of(context).textTheme.body1,
        ),
        backgroundColor: Colors.white,
      ),
       body: Column(
         children: <Widget>[
          
       ],),
    );
  }

  Widget _firstLayer(){
    return Row(children: <Widget>[
      
    ],);
  }
}