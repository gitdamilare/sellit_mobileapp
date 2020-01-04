// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authoutputDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthOutputDto _$AuthOutputDtoFromJson(Map<String, dynamic> json) {
  return AuthOutputDto(
    token: json['token'] as String,
    status: json['status'] as String,
    userid: json['userid'] as String,
    userinfo: json['user_info'] == null
        ? null
        : User.fromJson(json['user_info'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AuthOutputDtoToJson(AuthOutputDto instance) =>
    <String, dynamic>{
      'token': instance.token,
      'status': instance.status,
      'userid': instance.userid,
      'user_info': instance.userinfo?.toJson(),
    };
