import 'package:equatable/equatable.dart';
import 'package:sellit_mobileapp/models/product.dart';

abstract class ProductState extends Equatable {
  const ProductState();
    @override
  List<Object> get props => [];
}

class ProductUninitialized  extends ProductState {
}

class ProductError extends ProductState{}

class ProductLoaded extends ProductState{
  final List<Product> products;
  final bool hasReachedMax;

  ProductLoaded({this.products,this.hasReachedMax});

  ProductLoaded copyWith({
    List<Product> products,
    bool hasReachedMax
  }){
    return ProductLoaded(
      products: products ?? this.products,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

    @override
  List<Object> get props => [products, hasReachedMax];

    @override
  String toString() =>
      'ProductLoaded { posts: ${products.length}, hasReachedMax: $hasReachedMax }';
}


