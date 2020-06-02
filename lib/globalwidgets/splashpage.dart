import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 60.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0)),
              image: DecorationImage(
                
                  image: AssetImage("assets/images/logo_01.jpg"),
                  fit: BoxFit.cover)),
        ),
      ),
    );
  }
}
