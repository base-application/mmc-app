import 'dart:convert';
import 'package:mmc/generated/json/base/json_field.dart';
import 'package:mmc/generated/json/image_vo_entity.g.dart';

@JsonSerializable()
class ImageVoEntity {

  int? id;
	late String url;
  
  ImageVoEntity();

  factory ImageVoEntity.fromJson(Map<String, dynamic> json) => $ImageVoEntityFromJson(json);

  Map<String, dynamic> toJson() => $ImageVoEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}