import 'package:equatable/equatable.dart';
import 'package:sellit_mobileapp/models/product.dart';

abstract class SearchState extends Equatable {
  const SearchState();
    @override
  List<Object> get props => [];
}

class InitialSearchState extends SearchState {

}

class SearchLoading extends SearchState{}

class SearchLoaded extends SearchState{
  final List<Product> searchresult;
  SearchLoaded({this.searchresult});
}

class SearchFailure extends SearchState{}
