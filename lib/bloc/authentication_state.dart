import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  //const AuthenticationState();
    @override
  List<Object> get props => [];
}

//class InitialAuthenticationState extends AuthenticationState {}

class AuthenticationUninitialized extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState{}

class AuthenticationUnauthenticated extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

