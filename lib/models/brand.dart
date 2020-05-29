import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'brand.g.dart';

@JsonSerializable(explicitToJson: true)
class Brand extends Equatable{
  int brandid;
  int categoryid;
  String brandname;

  Brand({this.brandid,this.brandname,this.categoryid});

   factory Brand.fromJson(Map<String, dynamic> json) =>
      _$BrandFromJson(json);

  Map<String, dynamic> toJson() => _$BrandToJson(this);

  @override
  // TODO: implement props
  List<Object> get props => null;

}