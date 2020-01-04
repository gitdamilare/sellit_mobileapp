import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable(explicitToJson: true)
class Category extends Equatable {
  int categoryid;
  String name;
  String description;
  int parentid;
  List<Category> subCategories;

  Category({this.categoryid,this.name, this.description, this.parentid,this.subCategories});

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  @override
  // TODO: implement props
  List<Object> get props => [categoryid,name, description, parentid,subCategories];
}
