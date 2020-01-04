import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:sellit_mobileapp/data/searchrepository.dart';
import './bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository searchRepository;

  SearchBloc({this.searchRepository});
  @override
  SearchState get initialState => InitialSearchState();

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if(event is SearchProduct){
      yield SearchLoading();
      try{
        final result = await searchRepository.searchProducts(event.productname);
        yield SearchLoaded(searchresult: result);
      }catch(e){
        debugPrint(e.toString());
        yield SearchFailure();
      }
    }
  }
}
