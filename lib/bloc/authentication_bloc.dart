import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:sellit_mobileapp/data/userrepository.dart';
import 'package:sellit_mobileapp/services/coredata.dart';
import 'package:sellit_mobileapp/services/jsonrepo.dart';
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
              //Once the App is Opened , Fetch Save User Record
      var userData = await JsonRepo.jsonRepoObject.getDatafromJsonFile();
      if(userData != null)
      CoreData.coreDataObject.userInfo = userData.userinfo; //Store it into a singleton variable
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
