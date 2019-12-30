import 'package:json_annotation/json_annotation.dart';

part 'auth.g.dart';

@JsonSerializable()
class Auth {
  String matrikel_number;
  String password;

  Auth(
    {this.matrikel_number,
    this.password,
    }
  );

  factory Auth.fromJson(Map<String, dynamic> json) =>
      _$AuthFromJson(json);
      
  Map<String, dynamic> toJson() => _$AuthToJson(this);


}