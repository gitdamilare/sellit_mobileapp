import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable(explicitToJson: true)
class Category{
  
  String name;
  String description;
  int parent_id;

  Category({this.name, this.description, this.parent_id});

    factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
      
  Map<String, dynamic> toJson() => _$CategoryToJson(this);

}