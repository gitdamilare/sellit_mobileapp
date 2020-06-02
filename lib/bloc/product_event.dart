import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class FetchProduct extends ProductEvent{}


/*class FetchUserProduct extends ProductEvent{
   final int userId;

  const FetchUserProduct({this.userId});

  @override
  List<Object> get props => [userId];

  @override
  String toString() => 'UserID { user: $userId }';
}*/
