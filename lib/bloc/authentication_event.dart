import 'package:equatable/equatable.dart';
import 'package:sellit_mobileapp/models/outputDtos/authoutputDto.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {
  final AuthOutputDto authOutputDto;

  const LoggedIn({this.authOutputDto});

  @override
  List<Object> get props => [authOutputDto];

  @override
  String toString() => 'LoggedIn { token: $authOutputDto }';
}

class LoggedOut extends AuthenticationEvent {}
