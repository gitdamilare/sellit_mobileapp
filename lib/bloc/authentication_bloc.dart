import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:sellit_mobileapp/data/userrepository.dart';
import './bloc.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({this.userRepository});
  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if(event is AppStarted){
      bool hasToken = await userRepository.hasToken();
      if(hasToken){
        yield AuthenticationAuthenticated();
      }else{
        yield AuthenticationUnauthenticated();
      }
    }

    if(event is LoggedIn){
      yield AuthenticationLoading();
      await userRepository.persistToken(event.authOutputDto);
      yield AuthenticationAuthenticated();
    }

    if(event is LoggedOut){
      yield AuthenticationLoading();
      await userRepository.deleteToken();
      yield AuthenticationUnauthenticated();
    }
  }
}
