import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();
    @override
  List<Object> get props => [];

}

class LoginInitialState extends LoginState {}

class LoginLoading extends LoginState {}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({this.error});
  @override
  List<Object> get props => [error];

  @override
  String toString() => "LoginFailare {error : $error}";
}


