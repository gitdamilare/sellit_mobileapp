import 'package:flutter/material.dart';
import 'package:sellit_mobileapp/routes/router.dart';
import 'package:sellit_mobileapp/screens/buttomNav.dart';
import 'package:sellit_mobileapp/screens/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
          textTheme: TextTheme(
              title: TextStyle(
                  fontSize: 22.5,
                  fontFamily: "Varela",
                  fontWeight: FontWeight.w700,
                  color: Colors.black87),
              subtitle: TextStyle(
                fontSize: 20.5,
                fontFamily: "Varela",
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              body1: TextStyle(              
                fontSize: 16,
                fontFamily: "Varela",
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
                color: Colors.black),
              caption: TextStyle(
                  fontSize: 12.5,
                  fontFamily: "Varela",
                  fontStyle: FontStyle.normal,
                  color: Colors.black))),
      onGenerateRoute: Router.generateRoute,
      home: Login(),
    );
  }
}