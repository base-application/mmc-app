import 'dart:convert';
import 'package:mmc/generated/json/base/json_field.dart';
import 'package:mmc/generated/json/newest_item_info_entity.g.dart';

@JsonSerializable()
class NewestItemInfoEntity {

	late String description;
	late int storyId;
	String? link;
	late String title;
	late int pushTime;
	late List<NewestItemInfoPoster> poster;
	String? cover;
  
  NewestItemInfoEntity();

  factory NewestItemInfoEntity.fromJson(Map<String, dynamic> json) => $NewestItemInfoEntityFromJson(json);

  Map<String, dynamic> toJson() => $NewestItemInfoEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class NewestItemInfoPoster {

	late int id;
	late String url;
  
  NewestItemInfoPoster();

  factory NewestItemInfoPoster.fromJson(Map<String, dynamic> json) => $NewestItemInfoPosterFromJson(json);

  Map<String, dynamic> toJson() => $NewestItemInfoPosterToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}