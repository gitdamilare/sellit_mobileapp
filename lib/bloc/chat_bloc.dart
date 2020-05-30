import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:sellit_mobileapp/data/chatrepository.dart';
import './bloc.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository chatRepository;
  ChatBloc({this.chatRepository});
  @override
  ChatState get initialState => InitialChatState();

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
  }
}
