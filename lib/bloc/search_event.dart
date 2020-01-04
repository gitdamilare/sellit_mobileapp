import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

    @override
  List<Object> get props => [];
}

class SearchProduct extends SearchEvent{
  final String productname;
  SearchProduct({this.productname});

  @override
  List<Object> get props => [productname];

  @override
  String toString() {
    return "SearchProduct {productname : $productname}";
  }

}
