import 'package:mmc/generated/json/base/json_convert_content.dart';
import 'package:mmc/bean/home_index_info_entity.dart';
import 'package:mmc/bean/personal_profile_info_entity.dart';

import 'package:mmc/bean/newest_item_info_entity.dart';

import 'package:mmc/bean/event_data_item_info_entity.dart';


HomeIndexInfoEntity $HomeIndexInfoEntityFromJson(Map<String, dynamic> json) {
	HomeIndexInfoEntity homeIndexInfoEntity = HomeIndexInfoEntity();
	var slider = jsonConvert.convertListNotNull<HomeIndexInfoSlider>(json['slider']);
	if (slider != null) {
		homeIndexInfoEntity.slider = slider;
	}
	var user = jsonConvert.convert<PersonalProfileInfoEntity>(json['user']);
	if (user != null) {
		homeIndexInfoEntity.user = user;
	}
	var newset = jsonConvert.convertListNotNull<NewestItemInfoEntity>(json['newset']);
	if (newset != null) {
		homeIndexInfoEntity.newset = newset;
	}
	var upcoming = jsonConvert.convertListNotNull<EventDataItemInfoEntity>(json['upcoming']);
	if (upcoming != null) {
		homeIndexInfoEntity.upcoming = upcoming;
	}
	return homeIndexInfoEntity;
}

Map<String, dynamic> $HomeIndexInfoEntityToJson(HomeIndexInfoEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['slider'] =  entity.slider?.map((v) => v.toJson()).toList();
	data['user'] = entity.user?.toJson();
	data['newset'] =  entity.newset.map((v) => v.toJson()).toList();
	data['upcoming'] =  entity.upcoming?.map((v) => v.toJson()).toList();
	return data;
}

HomeIndexInfoSlider $HomeIndexInfoSliderFromJson(Map<String, dynamic> json) {
	HomeIndexInfoSlider homeIndexInfoSlider = HomeIndexInfoSlider();
	var sliderId = jsonConvert.convert<int>(json['sliderId']);
	if (sliderId != null) {
		homeIndexInfoSlider.sliderId = sliderId;
	}
	var sliderPoster = jsonConvert.convert<String>(json['sliderPoster']);
	if (sliderPoster != null) {
		homeIndexInfoSlider.sliderPoster = sliderPoster;
	}
	var createTime = jsonConvert.convert<int>(json['createTime']);
	if (createTime != null) {
		homeIndexInfoSlider.createTime = createTime;
	}
	var group = jsonConvert.convertListNotNull<HomeIndexInfoSliderGroup>(json['group']);
	if (group != null) {
		homeIndexInfoSlider.group = group;
	}
	var grades = jsonConvert.convertListNotNull<HomeIndexInfoSliderGrades>(json['grades']);
	if (grades != null) {
		homeIndexInfoSlider.grades = grades;
	}
	return homeIndexInfoSlider;
}

Map<String, dynamic> $HomeIndexInfoSliderToJson(HomeIndexInfoSlider entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['sliderId'] = entity.sliderId;
	data['sliderPoster'] = entity.sliderPoster;
	data['createTime'] = entity.createTime;
	data['group'] =  entity.group.map((v) => v.toJson()).toList();
	data['grades'] =  entity.grades.map((v) => v.toJson()).toList();
	return data;
}

HomeIndexInfoSliderGroup $HomeIndexInfoSliderGroupFromJson(Map<String, dynamic> json) {
	HomeIndexInfoSliderGroup homeIndexInfoSliderGroup = HomeIndexInfoSliderGroup();
	var groupId = jsonConvert.convert<int>(json['groupId']);
	if (groupId != null) {
		homeIndexInfoSliderGroup.groupId = groupId;
	}
	var groupName = jsonConvert.convert<String>(json['groupName']);
	if (groupName != null) {
		homeIndexInfoSliderGroup.groupName = groupName;
	}
	return homeIndexInfoSliderGroup;
}

Map<String, dynamic> $HomeIndexInfoSliderGroupToJson(HomeIndexInfoSliderGroup entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['groupId'] = entity.groupId;
	data['groupName'] = entity.groupName;
	return data;
}

HomeIndexInfoSliderGrades $HomeIndexInfoSliderGradesFromJson(Map<String, dynamic> json) {
	HomeIndexInfoSliderGrades homeIndexInfoSliderGrades = HomeIndexInfoSliderGrades();
	var gradeId = jsonConvert.convert<int>(json['gradeId']);
	if (gradeId != null) {
		homeIndexInfoSliderGrades.gradeId = gradeId;
	}
	var gradeName = jsonConvert.convert<String>(json['gradeName']);
	if (gradeName != null) {
		homeIndexInfoSliderGrades.gradeName = gradeName;
	}
	return homeIndexInfoSliderGrades;
}

Map<String, dynamic> $HomeIndexInfoSliderGradesToJson(HomeIndexInfoSliderGrades entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['gradeId'] = entity.gradeId;
	data['gradeName'] = entity.gradeName;
	return data;
}