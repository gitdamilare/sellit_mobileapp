// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    productid: json['product_id'] as int,
    name: json['name'] as String,
    slug: json['slug'] as String,
    description: json['description'] as String,
    price: json['price'] as String,
    sellerid: json['seller_id'] as int,
    moredetails: json['more_details'] as String,
    status: json['status'] as int,
    categoryid: json['category_id'] as int,
    brandid: json['brand_id'] as int,
    productcondition: json['product_condition'] as int,
    images: (json['image'] as List)
        ?.map(
            (e) => e == null ? null : Image.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    sellerinfo: json['seller_info'] == null
        ? null
        : User.fromJson(json['seller_info'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'product_id': instance.productid,
      'name': instance.name,
      'slug': instance.slug,
      'description': instance.description,
      'price': instance.price,
      'seller_id': instance.sellerid,
      'more_details': instance.moredetails,
      'status': instance.status,
      'category_id': instance.categoryid,
      'brand_id': instance.brandid,
      'product_condition': instance.productcondition,
      'image': instance.images?.map((e) => e?.toJson())?.toList(),
      'seller_info': instance.sellerinfo?.toJson(),
    };
