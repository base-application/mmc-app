import 'dart:convert';
import 'package:mmc/bean/master_class_videos_entity.dart';
import 'package:mmc/generated/json/base/json_field.dart';
import 'package:mmc/generated/json/master_class_entity.g.dart';

@JsonSerializable()
class MasterClassEntity {

	String? category;
	String? title;
	String? poster;
	String? introduction;
	int? type;
	List<MasterClassVideosEntity>? videos;

  MasterClassEntity({this.category, this.title, this.poster, this.introduction, this.videos, this.type});

  factory MasterClassEntity.fromJson(Map<String, dynamic> json) => $MasterClassEntityFromJson(json);

  Map<String, dynamic> toJson() => $MasterClassEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}