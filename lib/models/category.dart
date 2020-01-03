import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable(explicitToJson: true)
class Category extends Equatable {
  String name;
  String description;
  int parent_id;

  Category({this.name, this.description, this.parent_id});

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  @override
  // TODO: implement props
  List<Object> get props => [name, description, parent_id];
}
