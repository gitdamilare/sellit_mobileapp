import 'package:flutter/material.dart';
import 'package:sellit_mobileapp/models/user.dart';
import 'package:sellit_mobileapp/services/coredata.dart';

class Account extends StatefulWidget {
  Account({Key key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  User account;
  @override
  void initState() {
    super.initState();
    account = CoreData.coreDataObject.userInfo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                brightness: Brightness.light,
                backgroundColor: Theme.of(context).canvasColor,
                title: Text("My Account")),
            SliverList(
                delegate: SliverChildListDelegate([
                                 Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 3.5, 15.0, 0.0),
            child: SingleChildScrollView(
              child: ListBody(mainAxis: Axis.vertical,
              children: <Widget>[
                _nameLayer(),
                SizedBox(
                  height: 25.0,
                ),
                _cardLayer(),
                SizedBox(
                  height: 30.0,
                ),
                _manage()
              ],
            ), )
          ),
            ])),
                  ], 
   
        ),
      ),
    );
  }

  Widget _nameLayer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          account.firstname,
          //"Oluwadamilare",
          style: Theme.of(context).textTheme.title,
          textScaleFactor: 1.5,
        ),
        SizedBox(
          height: 5.0,
        ),
        Text("Standard member")
      ],
    );
  }

  Widget _cardLayer() {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50.0)),
      height: 115,
      width: 100,
      child: Card(
        borderOnForeground: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
        elevation: 3.0,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.account_balance,
                  ),
                  SizedBox(width: 50,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "ADDRESS",
                        style: Theme.of(context).textTheme.caption,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                         account.address,
                        //"Am Kindelsfeld 3, Fulda Hessen 36039",
                        maxLines: 2,
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.phone_iphone,
                  ),
                  SizedBox(width: 50,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "PHONE NO",
                        style: Theme.of(context).textTheme.caption,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        account.phonenumber,
                        //"Am Kindelsfeld 3, Fulda Hessen 36039",
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _manage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Manage",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
        _manageListTile(
            title: "Invite Your Friends",
            subtile: "and help us change shopping for better",
            icon: Icons.card_giftcard),
        SizedBox(
          child: Divider(
            thickness: 1.5,
          ),
        ),
        _manageListTile(
            title: "Settings",
            subtile: "Personal Information, app & security",
            icon: Icons.settings),
        SizedBox(
          child: Divider(
            thickness: 1.5,
          ),
        ),
        _manageListTile(
            title: "Help & Support",
            subtile: "Get support if you have any problem",
            icon: Icons.help)
      ],
    );
  }

  Widget _manageListTile({String title, String subtile, IconData icon}) {
    return ListTile(
      leading: Icon(
        icon,
        size: 30.0,
      ),
      title: Text(title),
      subtitle: Text(subtile),
    );
  }




}
