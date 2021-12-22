import 'package:mmc/generated/json/base/json_convert_content.dart';
import 'package:mmc/bean/home_index_info_entity.dart';
import 'package:mmc/bean/personal_profile_info_entity.dart';

import 'package:mmc/bean/newest_item_info_entity.dart';

import 'package:mmc/bean/event_data_item_info_entity.dart';


HomeIndexInfoEntity $HomeIndexInfoEntityFromJson(Map<String, dynamic> json) {
	final HomeIndexInfoEntity homeIndexInfoEntity = HomeIndexInfoEntity();
	final List<HomeIndexInfoSlider>? slider = jsonConvert.convertListNotNull<HomeIndexInfoSlider>(json['slider']);
	if (slider != null) {
		homeIndexInfoEntity.slider = slider;
	}
	final PersonalProfileInfoEntity? user = jsonConvert.convert<PersonalProfileInfoEntity>(json['user']);
	if (user != null) {
		homeIndexInfoEntity.user = user;
	}
	final List<NewestItemInfoEntity>? newset = jsonConvert.convertListNotNull<NewestItemInfoEntity>(json['newset']);
	if (newset != null) {
		homeIndexInfoEntity.newset = newset;
	}
	final List<EventDataItemInfoEntity>? upcoming = jsonConvert.convertListNotNull<EventDataItemInfoEntity>(json['upcoming']);
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
	final HomeIndexInfoSlider homeIndexInfoSlider = HomeIndexInfoSlider();
	final int? sliderId = jsonConvert.convert<int>(json['sliderId']);
	if (sliderId != null) {
		homeIndexInfoSlider.sliderId = sliderId;
	}
	final String? sliderPoster = jsonConvert.convert<String>(json['sliderPoster']);
	if (sliderPoster != null) {
		homeIndexInfoSlider.sliderPoster = sliderPoster;
	}
	final int? createTime = jsonConvert.convert<int>(json['createTime']);
	if (createTime != null) {
		homeIndexInfoSlider.createTime = createTime;
	}
	final List<HomeIndexInfoSliderGroup>? group = jsonConvert.convertListNotNull<HomeIndexInfoSliderGroup>(json['group']);
	if (group != null) {
		homeIndexInfoSlider.group = group;
	}
	final List<HomeIndexInfoSliderGrades>? grades = jsonConvert.convertListNotNull<HomeIndexInfoSliderGrades>(json['grades']);
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
	final HomeIndexInfoSliderGroup homeIndexInfoSliderGroup = HomeIndexInfoSliderGroup();
	final int? groupId = jsonConvert.convert<int>(json['groupId']);
	if (groupId != null) {
		homeIndexInfoSliderGroup.groupId = groupId;
	}
	final String? groupName = jsonConvert.convert<String>(json['groupName']);
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
	final HomeIndexInfoSliderGrades homeIndexInfoSliderGrades = HomeIndexInfoSliderGrades();
	final int? gradeId = jsonConvert.convert<int>(json['gradeId']);
	if (gradeId != null) {
		homeIndexInfoSliderGrades.gradeId = gradeId;
	}
	final String? gradeName = jsonConvert.convert<String>(json['gradeName']);
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