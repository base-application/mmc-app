import 'dart:convert';
import 'package:mmc/generated/json/base/json_field.dart';
import 'package:mmc/generated/json/master_category_entity.g.dart';

@JsonSerializable()
class MasterCategoryEntity {

	int? categoryId;
	String? categoryName;
	int? categorySerial;
	int? createTime;
	List<MasterCategoryCourses>? courses;
  
  MasterCategoryEntity();

  factory MasterCategoryEntity.fromJson(Map<String, dynamic> json) => $MasterCategoryEntityFromJson(json);

  Map<String, dynamic> toJson() => $MasterCategoryEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class MasterCategoryCourses {

	int? id;
	String? coursePhoto;
	String? courseName;
	int? parentCourse;
	int? courseCategory;
	String? courseDescription;
	String? concatUs;
	int? courseSerial;
	int? type;
  
  MasterCategoryCourses();

  factory MasterCategoryCourses.fromJson(Map<String, dynamic> json) => $MasterCategoryCoursesFromJson(json);

  Map<String, dynamic> toJson() => $MasterCategoryCoursesToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}