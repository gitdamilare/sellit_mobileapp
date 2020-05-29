import 'package:equatable/equatable.dart';

abstract class UserproductEvent extends Equatable {
  const UserproductEvent();
}

class FetchUserProduct extends UserproductEvent{
   final int userId;

  const FetchUserProduct({this.userId});

  @override
  List<Object> get props => [userId];

  @override
  String toString() => 'UserID { user: $userId }';
}
