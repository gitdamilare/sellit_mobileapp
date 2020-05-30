import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellit_mobileapp/bloc/bloc.dart';
import 'package:sellit_mobileapp/models/user.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<User> chatContacts;
  ChatBloc _chatBloc;

  @override
  void initState() {
    super.initState();
    _chatBloc = BlocProvider.of<ChatBloc>(context);
    _chatBloc.add(FetchChatContact());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: SafeArea(
            child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                brightness: Brightness.light,
                elevation: 0.0,
                backgroundColor: Theme.of(context).canvasColor,
                //title: Text("Chats"),
                expandedHeight: 200,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text("Messages"),
                  titlePadding: EdgeInsets.only(left: 20.0),
                  background: Container(
                    color: Colors.grey.shade200,
                  ),
                ),
              ),
              /* SliverFillRemaining(
                  child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0))),
                child: ListView(
                  children: List<int>.generate(12, (index) => index)
                      .map((index) => Container(
                            height: 40,
                            margin: EdgeInsets.symmetric(vertical: 10),
                            color: Colors.grey[300],
                            alignment: Alignment.center,
                            child: Text('$index item'),
                          ))
                      .toList(),
                ),
              ))*/
            ];
          },
          body: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0))),
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is ContactListLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is ContactListLoaded) {
                  chatContacts = state.chatContacts;
                  if (chatContacts.isNotEmpty) {
                    return ListView.separated(
                        separatorBuilder: (context, index) => Divider(
                              color: Colors.grey.shade400,
                            ),
                        padding: EdgeInsets.fromLTRB(16, 50, 0, 0),
                        shrinkWrap: true,
                        itemCount: chatContacts.length,
                        itemBuilder: (context, index) {
                          var chatContact = chatContacts[index];
                          return ListTile(
                            leading: Container(
                              width: 50,
                              height: 50,
                              child: CircleAvatar(
                                maxRadius: 25,
                                backgroundColor: Colors.grey.shade400,
                                child: Text(
                                 chatContact.firstname[0].toUpperCase() + chatContact.lastname[0].toUpperCase(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            title: Text(chatContact.firstname + " " + chatContact.lastname),
                            subtitle: Row(
                              children: <Widget>[
                                Text("Last Seen", style: Theme.of(context).textTheme.caption),
                                SizedBox(
                                  width: 50,
                                ),
                                Text(chatDateDiff(chatContact.createddate) + " days ago", 
                                overflow: TextOverflow.ellipsis, 
                                style: Theme.of(context).textTheme.caption),
                              ],
                            ),
                          );
                        });
                  }
                }
              },
            ),
          ),
        )));
  }

  String chatDateDiff(String messageCreatedDate){
    var result = "";
    try{
        var parsedDate = DateTime.parse(messageCreatedDate);
        var currentDate = DateTime.now();
        var diff = currentDate.difference(parsedDate).inDays;
        if(diff > 60){
          
        }
        result = diff.toString();
        /*if(diff > 60){
          diff = currentDate.difference(parsedDate).inHours;
  
        }*/

    }catch(e){
      print(e);
    }
   return result;
  }
}
