
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************



Chat _$ChatFromJson(Map<String, dynamic> json) {
  return Chat(
    matrikelnumber: json['matrikel_number'] as int,
    message: json['message'] as String,
    productid: json['product_id'] as int,
    createddate: json['created_date'] as String,
    modifieddate: json['modified_date'] as String,
  );
}

Map<String, dynamic> _$ChatToJson(Chat instance) => <String, dynamic>{
      'matrikel_number': instance.matrikelnumber,
      'message': instance.message,
      'product_id': instance.productid,
      'created_date': instance.createddate,
      'modified_date': instance.modifieddate,
    };
