// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Auth _$AuthFromJson(Map<String, dynamic> json) {
  return Auth(
    matrikelnumber: json['matrikel_number'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$AuthToJson(Auth instance) => <String, dynamic>{
      'matrikel_number': instance.matrikelnumber,
      'password': instance.password,
    };
