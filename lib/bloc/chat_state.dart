import 'package:equatable/equatable.dart';
import 'package:sellit_mobileapp/models/chat.dart';
import 'package:sellit_mobileapp/models/user.dart';

abstract class ChatState extends Equatable {
  const ChatState();
    @override
  List<Object> get props => [];
}

class InitialChatState extends ChatState {

}

class ContactListLoading extends ChatState{}

class ContactListLoaded extends ChatState{
  final List<User> chatContacts;

  ContactListLoaded({this.chatContacts});
}

class ContactError extends ChatState{
  
}

class MessagesLoading extends ChatState{}

class MessagesLoaded extends ChatState{
  final List<Chat> chatMessages;
  MessagesLoaded({this.chatMessages});
}

class MessageError extends ChatState{ 
}

class SendingMessage extends ChatState{}

class SentMessage extends ChatState{
}

