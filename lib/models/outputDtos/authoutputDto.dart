import 'package:json_annotation/json_annotation.dart';
import 'package:sellit_mobileapp/models/user.dart';

part 'authoutputDto.g.dart';

@JsonSerializable(explicitToJson: true)
class AuthOutputDto {
  String token;
  String status;
  String userid;
  User userinfo;

  AuthOutputDto({this.token, this.status, this.userid, this.userinfo});

  factory AuthOutputDto.fromJson(Map<String, dynamic> json) =>
      _$AuthOutputDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AuthOutputDtoToJson(this);
}
