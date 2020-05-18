import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sellit_mobileapp/models/image.dart';
import 'package:sellit_mobileapp/models/user.dart';

part 'product.g.dart';

@JsonSerializable(explicitToJson: true)
class Product extends Equatable {
  int productid;
  String name;
  String slug;
  String description;
  String price;
  int sellerid;
  String moredetails;
  int status;
  int categoryid;
  int brandid;
  int productcondition;
  List<Image> images;
  User sellerinfo;

  Product(
      {this.productid,
      this.name,
      this.slug,
      this.description,
      this.price,
      this.sellerid,
      this.moredetails,
      this.status,
      this.categoryid,
      this.brandid,
      this.productcondition,
      this.images,
      this.sellerinfo});

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  @override
  List<Object> get props => [
        productid,
        name,
        slug,
        description,
        price,
        sellerid,
        moredetails,
        status,
        categoryid,
        brandid,
        productcondition,
        images,
        sellerinfo
      ];

  @override
  String toString() => "Product {id : $productid}";
}
