// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chatoutputDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatOutputDto _$ChatOutputDtoFromJson(Map<String, dynamic> json) {
  return ChatOutputDto(
    message: json['message'] as String,
    productid: json['product_id'] as String,
    senderid: json['sender_id'] as String,
    receiverid: json['receiver_id'] as String,
  );
}

Map<String, dynamic> _$ChatOutputDtoToJson(ChatOutputDto instance) =>
    <String, dynamic>{
      'token': instance.message,
      'product_id': instance.productid,
      'sender_id': instance.senderid,
      'receiver_id': instance.receiverid,
    };
