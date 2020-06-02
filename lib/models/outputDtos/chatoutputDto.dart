import 'package:json_annotation/json_annotation.dart';
part 'chatoutputDto.g.dart';

@JsonSerializable(explicitToJson: true)
class ChatOutputDto {
  String message;
  int productid;
  int senderid;
  int receiverid;

  ChatOutputDto({this.message, this.productid, this.senderid, this.receiverid});
  ChatOutputDto.fromMessage({this.senderid, this.receiverid});

  factory ChatOutputDto.fromJson(Map<String, dynamic> json) =>
      _$ChatOutputDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ChatOutputDtoToJson(this);
}

class ChatMessagerDto{
  String name;
  int receiverid;
    ChatMessagerDto({this.name, this.receiverid});
}
