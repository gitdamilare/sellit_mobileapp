import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat.g.dart';

@JsonSerializable(explicitToJson: true)
class Chat extends Equatable{
  int matrikelnumber;
  String message;
  int productid;
  String createddate;
  String modifieddate;

  Chat({this.matrikelnumber,this.message,this.productid, this.createddate, this.modifieddate});

   factory Chat.fromJson(Map<String, dynamic> json) =>
      _$ChatFromJson(json);

  Map<String, dynamic> toJson() => _$ChatToJson(this);

  @override
  List<Object> get props => null;

}