import 'package:equatable/equatable.dart';
import 'package:sellit_mobileapp/models/outputDtos/chatoutputDto.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

}

class FetchChatContact extends ChatEvent{
   // final int userId;
  //FetchChatContact({this.userId});
  FetchChatContact();
  @override
  // TODO: implement props
  List<Object> get props => [];

    @override
  String toString() => 'UserID { user:  }';
}

class FetchChatMessages extends ChatEvent{
    final ChatOutputDto chatOutputDto;
  FetchChatMessages({this.chatOutputDto});
  @override
  // TODO: implement props
  List<Object> get props => [chatOutputDto];

    @override
  String toString() => 'ChatOutputDto { sender_id: ${chatOutputDto.senderid},receiver_id: ${chatOutputDto.receiverid} }';
}
