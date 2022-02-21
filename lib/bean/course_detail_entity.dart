import 'dart:convert';
import 'package:mmc/generated/json/base/json_field.dart';
import 'package:mmc/generated/json/course_detail_entity.g.dart';

@JsonSerializable()
class CourseDetailEntity {

	int? id;
	String? coursePhoto;
	String? courseName;
	int? parentCourse;
	int? courseCategory;
	String? courseDescription;
	String? concatUs;
	int? courseSerial;
	int? type;
	String? categoryName;
	CourseDetailParentCourseDetail? parentCourseDetail;
	List<CourseDetailVideos>? videos;
	List<CourseDetailFiles>? files;
	List<CourseDetailSchedules>? schedules;
  
  CourseDetailEntity();

  factory CourseDetailEntity.fromJson(Map<String, dynamic> json) => $CourseDetailEntityFromJson(json);

  Map<String, dynamic> toJson() => $CourseDetailEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class CourseDetailParentCourseDetail {

	int? id;
	String? coursePhoto;
	String? courseName;
	int? parentCourse;
	int? courseCategory;
	String? courseDescription;
	String? concatUs;
	int? courseSerial;
	int? type;
  
  CourseDetailParentCourseDetail();

  factory CourseDetailParentCourseDetail.fromJson(Map<String, dynamic> json) => $CourseDetailParentCourseDetailFromJson(json);

  Map<String, dynamic> toJson() => $CourseDetailParentCourseDetailToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class CourseDetailVideos {

	int? videoId;
	int? courseId;
	String? videoTitle;
	String? videoUrl;
  
  CourseDetailVideos();

  factory CourseDetailVideos.fromJson(Map<String, dynamic> json) => $CourseDetailVideosFromJson(json);

  Map<String, dynamic> toJson() => $CourseDetailVideosToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class CourseDetailFiles {

	int? fileId;
	String? fileTitle;
	String? fileUrl;
	int? courseId;
  
  CourseDetailFiles();

  factory CourseDetailFiles.fromJson(Map<String, dynamic> json) => $CourseDetailFilesFromJson(json);

  Map<String, dynamic> toJson() => $CourseDetailFilesToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class CourseDetailSchedules {

	int? scheduleId;
	int? courseId;
	String? scheduleUrl;
	int? scheduleTime;
	String? scheduleTitle;
	String? scheduleVenue;
  
  CourseDetailSchedules();

  factory CourseDetailSchedules.fromJson(Map<String, dynamic> json) => $CourseDetailSchedulesFromJson(json);

  Map<String, dynamic> toJson() => $CourseDetailSchedulesToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}