import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:sellit_mobileapp/data/productrepository.dart';
import './bloc.dart';

class UserproductBloc extends Bloc<UserproductEvent, UserproductState> {
  final ProductRepository productRepository;
  
  UserproductBloc({this.productRepository});
  @override
  UserproductState get initialState => UserProductLoading();

  @override
  Stream<UserproductState> mapEventToState(
    UserproductEvent event,
  ) async* {
    if(event is FetchUserProduct){
      yield UserProductLoading();
      try{
        final products = await productRepository.getAllUserProducts(event.userId);
        yield UserProductLoaded(productResult: products);
      }catch(e){
        debugPrint(e.toString());
        yield UserProductError();
      }
    }
  }
}
