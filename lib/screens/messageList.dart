import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sellit_mobileapp/bloc/bloc.dart';
import 'package:sellit_mobileapp/models/chat.dart';
import 'package:sellit_mobileapp/models/outputDtos/chatoutputDto.dart';
import 'package:sellit_mobileapp/models/user.dart';
import 'package:sellit_mobileapp/services/coredata.dart';

class ChatMessages extends StatefulWidget {
  final ChatMessagerDto chatMessagerDto;
  ChatMessages({Key key, this.chatMessagerDto}) : super(key: key);

  @override
  _ChatMessagesState createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  User currentUser;
  List<Chat> chatMessages;
  int productId;

  TextEditingController _textMessageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    currentUser = CoreData.coreDataObject.userInfo;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: Theme.of(context).canvasColor,
          leading: IconButton(
              icon: Icon(LineAwesomeIcons.arrow_left),
              onPressed: () {
                BlocProvider.of<ChatBloc>(context).add(FetchChatContact());
                Navigator.of(context).pop();
              }),
          title: Text(widget.chatMessagerDto.name),
          actions: <Widget>[
            IconButton(
                icon: Icon(LineAwesomeIcons.bars),
                onPressed: () => Navigator.of(context).pop())
          ],
        ),
        bottomNavigationBar: _buildInput(),
        body: BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
          if (state is MessagesLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MessagesLoaded) {
            chatMessages = state.chatMessages.reversed.toList();
            //chatMessages.reversed
            return ListView.builder(
                itemCount: chatMessages.length,
                reverse: true,
                itemBuilder: (context, index) {
                  var chatMessage = chatMessages[index];
                  var lastMessage = chatMessages.last;
                  productId = chatMessage.productid;
                  return Row(
                    mainAxisAlignment: chatMessage.matrikelnumber != currentUser.matrikelnumber
                                  ? MainAxisAlignment.start : MainAxisAlignment.end,
                    children: <Widget>[
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 6.0,),
                       child:  chatMessage.matrikelnumber != currentUser.matrikelnumber ? Container(
                                width: 30,
                                height: 30,
                                child: CircleAvatar(
                                  maxRadius: 25,
                                  backgroundColor: Colors.grey.shade400,
                                  child: chatMessage.matrikelnumber == currentUser.matrikelnumber ? Text(
                                    currentUser.firstname[0].toUpperCase(),
                                    style: TextStyle(color: Colors.white),
                                  ) : Text(
                                    widget.chatMessagerDto.name[0].toUpperCase(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ) : Container(),
                     ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 6,horizontal:  12),
                        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .7),
                        padding: EdgeInsets.symmetric(vertical: 6,horizontal:  12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          color: chatMessage.matrikelnumber != currentUser.matrikelnumber
                                  ? Color(0xFF48AC98) : Colors.grey.shade300
                        ),
                        child: Text(chatMessage.message , style: TextStyle(color:Colors.black54,fontSize: 16),)),
                    ],
                  );
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
    );
  }

  Widget _buildInput() {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        margin: EdgeInsets.all(12),
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.grey.shade400,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: _textMessageController,
                decoration: InputDecoration(
                  border: InputBorder.none,               
                  hintText: "Type something...",
                  hintStyle: TextStyle(
                    color: Colors.white30,
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.attach_file,
                color: Colors.black,
              ),
              onPressed: null,
            ),
            IconButton(
              icon: Icon(
                Icons.send,
                color: Colors.black,
              ),
              onPressed: (){
                if(_textMessageController.text != ""){
                  var chatmessage = ChatOutputDto(message: _textMessageController.text,
                                                  productid: productId,
                                                  senderid: currentUser.matrikelnumber,
                                                  receiverid: widget.chatMessagerDto.receiverid);
                   BlocProvider.of<ChatBloc>(context).add(SendMessage(chatOutputDto: chatmessage));
                   _textMessageController.text = "";
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  bool _isLastMessage(List<Chat> chatMessages){

  }

}
