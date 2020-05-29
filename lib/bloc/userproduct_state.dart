import 'package:equatable/equatable.dart';
import 'package:sellit_mobileapp/models/product.dart';

abstract class UserproductState extends Equatable {
  const UserproductState();
    @override
  List<Object> get props => [];
}

class InitialUserproductState extends UserproductState {

}

class UserProductLoading extends UserproductState{}

class UserProductLoaded extends UserproductState{
  final List<Product> productResult;
  UserProductLoaded({this.productResult});
}

class UserProductError extends UserproductState{}


