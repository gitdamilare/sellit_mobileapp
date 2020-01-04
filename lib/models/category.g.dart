// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return Category(
    categoryid: json['category_id'] as int,
    name: json['name'] as String,
    description: json['description'] as String,
    parentid: json['parent_id'] as int,
    subCategories: (json['sub_category'] as List)
        ?.map((e) =>
            e == null ? null : Category.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'category_id': instance.categoryid,
      'name': instance.name,
      'description': instance.description,
      'parent_id': instance.parentid,
      'sub_category':
          instance.subCategories?.map((e) => e?.toJson())?.toList(),
    };
