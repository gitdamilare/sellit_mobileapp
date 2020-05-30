import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sellit_mobileapp/bloc/bloc.dart';
import 'package:sellit_mobileapp/routes/routelinks.dart';
import 'package:sellit_mobileapp/screens/account.dart';
import 'package:sellit_mobileapp/screens/chatscreen.dart';
import 'package:sellit_mobileapp/screens/home.dart';
import 'package:sellit_mobileapp/screens/login.dart';
//import 'package:sellit_mobileapp/screens/postproduct/postproduct.dart';
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
        children: <Widget>[Home(), ChatScreen(), Profile(), Account()],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, PostProductRoute);
        },
        child: Icon(LineAwesomeIcons.camera, size: 30,),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          
          //shape: CircularNotchedRectangle(),
          notchMargin: 4.0,
          color: Colors.white,
          elevation: 9.0,
          clipBehavior: Clip.antiAlias,
          child: Container(
              height: 70.0,
              //color: Colors.white,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0)),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      color: Colors.transparent,
                      height: 60.0,
                      //width: MediaQuery.of(context).size.width / 2 - 40.0
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _myPage.jumpToPage(0);
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              LineAwesomeIcons.icons,//LineAwesomeIcons.grip_vertical,
                              color: Color(0xFF676E79),
                              size: 35,
                            ),
                            Text(
                              "Explore",
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                        color: Colors.transparent,
                        height: 60.0,
                        //width: MediaQuery.of(context).size.width / 2 - 40.0
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              BlocProvider.of<AuthenticationBloc>(context)
                                  .add(LoggedOut());
                              //_myPage.jumpToPage(1);
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                LineAwesomeIcons.comments,
                                color: Color(0xFF676E79),
                                size: 35,
                              ),
                              Text("Chats",
                                  style: Theme.of(context).textTheme.caption)
                            ],
                          ),
                        )),
                    Container(
                        color: Colors.transparent,
                        height: 60.0,
                        //width: MediaQuery.of(context).size.width / 2 - 40.0
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _myPage.jumpToPage(2);
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                LineAwesomeIcons.buffer,
                                color: Color(0xFF676E79),
                                size: 35,
                              ),
                              Text("ADS",
                                  style: Theme.of(context).textTheme.caption)
                            ],
                          ),
                        )),
                    Container(
                        color: Colors.transparent,
                        height: 60.0,
                        //width: MediaQuery.of(context).size.width / 2 - 40.0
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _myPage.jumpToPage(3);
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(LineAwesomeIcons.user_1,
                                  color: Color(0xFF676E79), size: 35),
                              Text("Profile",
                                  style: Theme.of(context).textTheme.caption)
                            ],
                          ),
                        )),
                    /*Expanded(
                      child: Container(
                        height: 60.0,
                        width: MediaQuery.of(context).size.width / 2 - 40.0,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[Text("")],
                        ),
                      ),
                    ),*/
                  ]))),
    );
  }
}

class ScreenArguments {
  final int selected;
  ScreenArguments({this.selected});
}
