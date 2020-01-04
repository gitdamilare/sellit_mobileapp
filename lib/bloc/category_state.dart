import 'package:equatable/equatable.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

    @override
  List<Object> get props => [];
}

class InitialCategoryState extends CategoryState {

}

class CatagoryLoaded extends CategoryState{

}
