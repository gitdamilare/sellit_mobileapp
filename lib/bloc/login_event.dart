import 'package:equatable/equatable.dart';
import 'package:sellit_mobileapp/models/inputDtos/auth.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
    @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent{
  final Auth authInput;

  LoginButtonPressed({this.authInput});

  @override
  List<Object> get props => [authInput];

  @override
  String toString() => 'LoginButtonPressed { authInput : $authInput }';
}

