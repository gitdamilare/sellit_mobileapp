import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';
import 'package:sellit_mobileapp/data/categoryrepository.dart';
import 'package:sellit_mobileapp/data/productrepository.dart';
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
          final products = await productRepository.getAllProducts(0, 4);
          final categories = await categoryRepository.getAllCategories();
          yield ProductLoaded(products: products, hasReachedMax: false, categories:categories);
        }

        if (currentState is ProductLoaded) {
          final products = await productRepository.getAllProducts(
              currentState.products.length, 4);
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
  }

  bool _hasReachedMax(ProductState state) {
    return state is ProductLoaded && state.hasReachedMax;
  }
}
