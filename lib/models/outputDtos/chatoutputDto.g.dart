// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chatoutputDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatOutputDto _$ChatOutputDtoFromJson(Map<String, dynamic> json) {
  return ChatOutputDto(
    message: json['message'] as String,
    productid: json['product_id'] as int,
    senderid: json['sender_id'] as int,
    receiverid: json['receiver_id'] as int,
  );
}

Map<String, dynamic> _$ChatOutputDtoToJson(ChatOutputDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'product_id': instance.productid,
      'sender_id': instance.senderid,
      'receiver_id': instance.receiverid,
    };
