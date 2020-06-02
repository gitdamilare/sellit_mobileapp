// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Brand _$BrandFromJson(Map<String, dynamic> json) {
  return Brand(
    categoryid: json['category_id'] as int,
    brandid: json['brand_id'] as int,
    brandname: json['brand_name'] as String,
  );
}

Map<String, dynamic> _$BrandToJson(Brand instance) => <String, dynamic>{
      'category_id': instance.categoryid,
      'brand_name': instance.brandname,
      'brand_id': instance.brandid,
    };
