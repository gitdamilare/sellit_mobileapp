import 'package:json_annotation/json_annotation.dart';
import 'package:sellit_mobileapp/models/image.dart';

part 'product.g.dart';

@JsonSerializable(explicitToJson: true)
class Product{
  int product_id;
  String name;
  String slug;
  String description;
  String price;
  int seller_id;
  String more_details;
  int status;
  int category_id;
  int brand_id;
  int product_condition;
  List<Image> images;


  Product({
    this.product_id,
    this.name,
    this.slug,
    this.description,
    this.price,
    this.seller_id,
    this.more_details,
    this.status,
    this.category_id,
    this.brand_id,
    this.product_condition,
    this.images
  });

    factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
      
  Map<String, dynamic> toJson() => _$ProductToJson(this);

}

