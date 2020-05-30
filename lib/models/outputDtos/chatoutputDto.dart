import 'package:json_annotation/json_annotation.dart';
part 'chatoutputDto.g.dart';

@JsonSerializable(explicitToJson: true)
class ChatOutputDto {
  String message;
  String productid;
  String senderid;
  String receiverid;

  ChatOutputDto({this.message, this.productid, this.senderid, this.receiverid});
  ChatOutputDto.fromMessage({this.senderid, this.receiverid});

  factory ChatOutputDto.fromJson(Map<String, dynamic> json) =>
      _$ChatOutputDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ChatOutputDtoToJson(this);
}
