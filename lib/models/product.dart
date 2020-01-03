import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sellit_mobileapp/models/image.dart';

part 'product.g.dart';

@JsonSerializable(explicitToJson: true)
class Product extends Equatable {
  final int productid;
  final String name;
  final String slug;
  final String description;
  final String price;
  final int sellerid;
  final String moredetails;
  final int status;
  final int categoryid;
  final int brandid;
  final int productcondition;
  final List<Image> images;

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
      this.images});

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
        images
      ];

  @override
  String toString() => "Product {id : $productid}";
}
