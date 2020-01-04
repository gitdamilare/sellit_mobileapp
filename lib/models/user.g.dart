// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    matrikelnumber: json['matrikel_number'] as int,
    firstname: json['first_name'] as String,
    lastname: json['last_name'] as String,
    dob: json['dob'] as String,
    email: json['email'] as String,
    address: json['address'] as String,
    phonenumber: json['phone_number'] as String,
    postalcode: json['postal_code'] as String,
    username: json['username'] as String,
    createddate: json['createddate'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'matrikel_number': instance.matrikelnumber,
      'first_name': instance.firstname,
      'last_name': instance.lastname,
      'dob': instance.dob,
      'email': instance.email,
      'address': instance.address,
      'phone_number': instance.phonenumber,
      'postal_code': instance.postalcode,
      'username': instance.username,
      'createddate': instance.createddate,
    };
