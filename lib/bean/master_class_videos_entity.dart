import 'dart:convert';
import 'package:mmc/generated/json/base/json_field.dart';
import 'package:mmc/generated/json/master_class_videos_entity.g.dart';

@JsonSerializable()
class MasterClassVideosEntity {

	String? title;
	String? url;


  MasterClassVideosEntity({this.title, this.url});

  factory MasterClassVideosEntity.fromJson(Map<String, dynamic> json) => $MasterClassVideosEntityFromJson(json);

  Map<String, dynamic> toJson() => $MasterClassVideosEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}