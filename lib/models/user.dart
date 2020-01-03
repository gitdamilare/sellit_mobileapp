import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  int matrikelnumber;
  String firstname;
  String lastname;
  String dob;
  String email;
  String address;
  String phonenumber;
  String postalcode;
  String username;
  String createddate;

  User(
      {this.matrikelnumber,
      this.firstname,
      this.lastname,
      this.dob,
      this.email,
      this.address,
      this.phonenumber,
      this.postalcode,
      this.username,
      this.createddate});

      factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);
      
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
