import 'dart:convert';
import 'package:mmc/bean/personal_profile_info_entity.dart';
import 'package:mmc/generated/json/base/json_field.dart';
import 'package:mmc/generated/json/home_index_info_entity.g.dart';

import 'package:mmc/bean/newest_item_info_entity.dart';
import 'package:mmc/bean/event_data_item_info_entity.dart';

@JsonSerializable()
class HomeIndexInfoEntity {

	late List<HomeIndexInfoSlider> slider;
	late PersonalProfileInfoEntity user;
	late List<NewestItemInfoEntity> newset;
	late List<EventDataItemInfoEntity> upcoming;

  HomeIndexInfoEntity();

  factory HomeIndexInfoEntity.fromJson(Map<String, dynamic> json) => $HomeIndexInfoEntityFromJson(json);

  Map<String, dynamic> toJson() => $HomeIndexInfoEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class HomeIndexInfoSlider {

	late int sliderId;
	late String sliderPoster;
	late int createTime;
	late List<HomeIndexInfoSliderGroup> group;
	late List<HomeIndexInfoSliderGrades> grades;
  
  HomeIndexInfoSlider();

  factory HomeIndexInfoSlider.fromJson(Map<String, dynamic> json) => $HomeIndexInfoSliderFromJson(json);

  Map<String, dynamic> toJson() => $HomeIndexInfoSliderToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class HomeIndexInfoSliderGroup {

	late int groupId;
	late String groupName;
  
  HomeIndexInfoSliderGroup();

  factory HomeIndexInfoSliderGroup.fromJson(Map<String, dynamic> json) => $HomeIndexInfoSliderGroupFromJson(json);

  Map<String, dynamic> toJson() => $HomeIndexInfoSliderGroupToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class HomeIndexInfoSliderGrades {

	late int gradeId;
	late String gradeName;
  
  HomeIndexInfoSliderGrades();

  factory HomeIndexInfoSliderGrades.fromJson(Map<String, dynamic> json) => $HomeIndexInfoSliderGradesFromJson(json);

  Map<String, dynamic> toJson() => $HomeIndexInfoSliderGradesToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}