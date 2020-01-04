import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellit_mobileapp/bloc/bloc.dart';
import 'package:sellit_mobileapp/screens/account.dart';
import 'package:sellit_mobileapp/screens/chat.dart';
import 'package:sellit_mobileapp/screens/home.dart';
import 'package:sellit_mobileapp/screens/login.dart';
import 'package:sellit_mobileapp/screens/profile.dart';

class BottomNavWrapper extends StatefulWidget {
  //final ScreenArguments data;
  //BottomNavWrapper({this.data});
  @override
  _BottomNavWrapperState createState() => _BottomNavWrapperState();
}

class _BottomNavWrapperState extends State<BottomNavWrapper> {
  PageController _myPage = PageController(initialPage: 0);
  var pageOptions = [];
  //int _selectedPage = 0;

  void initState() {
    pageOptions = [Home(), Login()];
    super.initState();
  }

  void onTappedBar(int index) {
    print(index);
    setState(() {
      //_selectedPage = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _myPage,
        onPageChanged: (int) {
          print("Page Changes to index $int");
        },
        children: <Widget>[Home(), Chat(), Profile(), Account()],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 4.0,
          color: Colors.transparent,
          elevation: 9.0,
          clipBehavior: Clip.antiAlias,
          child: Container(
              height: 50.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0)),
                  color: Colors.white),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        height: 50.0,
                        width: MediaQuery.of(context).size.width / 2 - 40.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            /*Icon(Icons.home, color: Color(0xFFEF7532))*/
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _myPage.jumpToPage(0);
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(Icons.home, color: Color(0xFFEF7532)),
                                  Text("EXPLORE")
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                                  //_myPage.jumpToPage(1);
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(Icons.chat_bubble_outline,
                                      color: Color(0xFF676E79)),
                                  Text("CHATS")
                                ],
                              ),
                            ),
                          ],
                        )),
                    Expanded(
                      child: Container(
                        height: 60.0,
                        width: MediaQuery.of(context).size.width / 2 - 40.0,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[Text("SELL")],
                        ),
                      ),
                    ),
                    Container(
                        height: 50.0,
                        width: MediaQuery.of(context).size.width / 2 - 40.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _myPage.jumpToPage(2);
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(Icons.layers, color: Color(0xFF676E79)),
                                  Text("MY ADS")
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _myPage.jumpToPage(3);
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(Icons.person, color: Color(0xFF676E79)),
                                  Text("PROFILE")
                                ],
                              ),
                            ),
                          ],
                        )),
                  ]))),
    );
  }
}

class ScreenArguments {
  final int selected;
  ScreenArguments({this.selected});
}
