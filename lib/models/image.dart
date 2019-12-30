
import 'package:json_annotation/json_annotation.dart';
part 'image.g.dart';

@JsonSerializable()
class Image {
  String url;

  Image({this.url});

  factory Image.fromJson(Map<String, dynamic> json) =>
      _$ImageFromJson(json);
      
  Map<String, dynamic> toJson() => _$ImageToJson(this);


         
}