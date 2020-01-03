import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:sellit_mobileapp/data/userrepository.dart';
import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({this.userRepository,this.authenticationBloc});
  @override
  LoginState get initialState => LoginInitialState();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
   if(event is LoginButtonPressed){
     yield LoginLoading();
     try{
       final result = await userRepository.authenticate(event.authInput);
       if(result.status == "failed"){
         yield LoginFailure(error : "Invalid Username or Password");
       }else{
         authenticationBloc.add(LoggedIn(authOutputDto: result));
         yield LoginInitialState();
       }    
     }catch(e){
       yield LoginFailure(error: e.toString());
     }
   }
  }
}
