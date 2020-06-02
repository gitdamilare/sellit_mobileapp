import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:sellit_mobileapp/data/chatrepository.dart';
import 'package:sellit_mobileapp/models/outputDtos/chatoutputDto.dart';
import './bloc.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository chatRepository;
  ChatBloc({this.chatRepository});
  @override
  ChatState get initialState => ContactListLoading();

  @override
  Stream<ChatState> mapEventToState(
    ChatEvent event,
  ) async* {
    if(event is FetchChatContact){
        yield ContactListLoading();
        try{
            final result = await chatRepository.getAllChatContact();
            yield ContactListLoaded(chatContacts: result);
        }catch(e){
          yield ContactError();
        }
    }
    else if(event is FetchChatMessages){
      yield MessagesLoading();
      try{
        ChatOutputDto input = ChatOutputDto.fromMessage(senderid: event.chatOutputDto.senderid, 
                                                        receiverid: event.chatOutputDto.receiverid);
        final result = await chatRepository.getAllChatMessages(input);
        yield MessagesLoaded(chatMessages: result);
      }catch(e){
         yield MessageError();
      }
    }else if(event is SendMessage){
      yield MessagesLoading();
            try{
        ChatOutputDto input = event.chatOutputDto;
        final _messager = await chatRepository.sendMessage(input);
        input = ChatOutputDto.fromMessage(senderid: event.chatOutputDto.senderid, 
                                                        receiverid: event.chatOutputDto.receiverid);
        final result = await chatRepository.getAllChatMessages(input);
        yield MessagesLoaded(chatMessages: result);
      }catch(e){
         yield MessageError();
      }
    }
  }
}
