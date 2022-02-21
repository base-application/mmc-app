import 'package:mmc/generated/json/base/json_convert_content.dart';
import 'package:mmc/bean/master_category_entity.dart';

MasterCategoryEntity $MasterCategoryEntityFromJson(Map<String, dynamic> json) {
	final MasterCategoryEntity masterCategoryEntity = MasterCategoryEntity();
	final int? categoryId = jsonConvert.convert<int>(json['categoryId']);
	if (categoryId != null) {
		masterCategoryEntity.categoryId = categoryId;
	}
	final String? categoryName = jsonConvert.convert<String>(json['categoryName']);
	if (categoryName != null) {
		masterCategoryEntity.categoryName = categoryName;
	}
	final int? categorySerial = jsonConvert.convert<int>(json['categorySerial']);
	if (categorySerial != null) {
		masterCategoryEntity.categorySerial = categorySerial;
	}
	final int? createTime = jsonConvert.convert<int>(json['createTime']);
	if (createTime != null) {
		masterCategoryEntity.createTime = createTime;
	}
	final List<MasterCategoryCourses>? courses = jsonConvert.convertListNotNull<MasterCategoryCourses>(json['courses']);
	if (courses != null) {
		masterCategoryEntity.courses = courses;
	}
	return masterCategoryEntity;
}

Map<String, dynamic> $MasterCategoryEntityToJson(MasterCategoryEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['categoryId'] = entity.categoryId;
	data['categoryName'] = entity.categoryName;
	data['categorySerial'] = entity.categorySerial;
	data['createTime'] = entity.createTime;
	data['courses'] =  entity.courses?.map((v) => v.toJson()).toList();
	return data;
}

MasterCategoryCourses $MasterCategoryCoursesFromJson(Map<String, dynamic> json) {
	final MasterCategoryCourses masterCategoryCourses = MasterCategoryCourses();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		masterCategoryCourses.id = id;
	}
	final String? coursePhoto = jsonConvert.convert<String>(json['coursePhoto']);
	if (coursePhoto != null) {
		masterCategoryCourses.coursePhoto = coursePhoto;
	}
	final String? courseName = jsonConvert.convert<String>(json['courseName']);
	if (courseName != null) {
		masterCategoryCourses.courseName = courseName;
	}
	final int? parentCourse = jsonConvert.convert<int>(json['parentCourse']);
	if (parentCourse != null) {
		masterCategoryCourses.parentCourse = parentCourse;
	}
	final int? courseCategory = jsonConvert.convert<int>(json['courseCategory']);
	if (courseCategory != null) {
		masterCategoryCourses.courseCategory = courseCategory;
	}
	final String? courseDescription = jsonConvert.convert<String>(json['courseDescription']);
	if (courseDescription != null) {
		masterCategoryCourses.courseDescription = courseDescription;
	}
	final String? concatUs = jsonConvert.convert<String>(json['concatUs']);
	if (concatUs != null) {
		masterCategoryCourses.concatUs = concatUs;
	}
	final int? courseSerial = jsonConvert.convert<int>(json['courseSerial']);
	if (courseSerial != null) {
		masterCategoryCourses.courseSerial = courseSerial;
	}
	final int? type = jsonConvert.convert<int>(json['type']);
	if (type != null) {
		masterCategoryCourses.type = type;
	}
	return masterCategoryCourses;
}

Map<String, dynamic> $MasterCategoryCoursesToJson(MasterCategoryCourses entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['coursePhoto'] = entity.coursePhoto;
	data['courseName'] = entity.courseName;
	data['parentCourse'] = entity.parentCourse;
	data['courseCategory'] = entity.courseCategory;
	data['courseDescription'] = entity.courseDescription;
	data['concatUs'] = entity.concatUs;
	data['courseSerial'] = entity.courseSerial;
	data['type'] = entity.type;
	return data;
}