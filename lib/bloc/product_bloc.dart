import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';
import 'package:sellit_mobileapp/data/categoryrepository.dart';
import 'package:sellit_mobileapp/data/productrepository.dart';
import 'package:sellit_mobileapp/models/brand.dart';
import 'package:sellit_mobileapp/services/coredata.dart';
import './bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;
  final CategoryRepository categoryRepository;

  ProductBloc({this.productRepository, this.categoryRepository});

 /* @override
  Stream<ProductState> transformEvents(
    Stream<ProductEvent> events,
    Stream<ProductState> Function(ProductEvent event) next,
  ) {
    return super.transformEvents(
      events.debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }*/


  @override
  ProductState get initialState => ProductUninitialized();

  @override
  Stream<ProductState> mapEventToState(
    ProductEvent event,
  ) async* {
    final currentState = state;
    if (event is FetchProduct && !_hasReachedMax(currentState)) {
      try {
        if (currentState is ProductUninitialized) {
          var products = await productRepository.getAllProducts(0, 20);
          //products = products.where((xx) => xx.sellerinfo.matrikelnumber != CoreDa)
          final categories = await categoryRepository.getAllCategories();
          CoreData.coreDataObject.appBrands = await getAppBrand();
          yield ProductLoaded(products: products, hasReachedMax: false, categories:categories);
        }

        if (currentState is ProductLoaded) {
          final products = await productRepository.getAllProducts(
              currentState.products.length, 20);
          yield products.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : ProductLoaded(
                  products: currentState.products + products,
                  hasReachedMax: false,
                  categories: currentState.categories);
        }
      } catch (e) {
        yield ProductError();
      }
    }

   /* if(event is FetchUserProduct){
      yield UserProductLoading();
      try{
        final products = await productRepository.getAllUserProducts(event.userId);
        yield UserProductLoaded(productResult: products);
      }catch(e){
        debugPrint(e.toString());
        yield ProductError();
      }
    }*/
  }

  bool _hasReachedMax(ProductState state) {
    return state is ProductLoaded && state.hasReachedMax;
  }

  Future<List<Brand>> getAppBrand() async {
    try{
      List<Brand> brands = await categoryRepository.getAllBrands();
      return brands;
    }catch(e){   
      print(e);
      return null;
    }
  }   
}
