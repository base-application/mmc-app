import 'package:mmc/generated/json/base/json_convert_content.dart';
import 'package:mmc/bean/course_detail_entity.dart';

CourseDetailEntity $CourseDetailEntityFromJson(Map<String, dynamic> json) {
	final CourseDetailEntity courseDetailEntity = CourseDetailEntity();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		courseDetailEntity.id = id;
	}
	final String? coursePhoto = jsonConvert.convert<String>(json['coursePhoto']);
	if (coursePhoto != null) {
		courseDetailEntity.coursePhoto = coursePhoto;
	}
	final String? courseName = jsonConvert.convert<String>(json['courseName']);
	if (courseName != null) {
		courseDetailEntity.courseName = courseName;
	}
	final int? parentCourse = jsonConvert.convert<int>(json['parentCourse']);
	if (parentCourse != null) {
		courseDetailEntity.parentCourse = parentCourse;
	}
	final int? courseCategory = jsonConvert.convert<int>(json['courseCategory']);
	if (courseCategory != null) {
		courseDetailEntity.courseCategory = courseCategory;
	}
	final String? courseDescription = jsonConvert.convert<String>(json['courseDescription']);
	if (courseDescription != null) {
		courseDetailEntity.courseDescription = courseDescription;
	}
	final String? concatUs = jsonConvert.convert<String>(json['concatUs']);
	if (concatUs != null) {
		courseDetailEntity.concatUs = concatUs;
	}
	final int? courseSerial = jsonConvert.convert<int>(json['courseSerial']);
	if (courseSerial != null) {
		courseDetailEntity.courseSerial = courseSerial;
	}
	final int? type = jsonConvert.convert<int>(json['type']);
	if (type != null) {
		courseDetailEntity.type = type;
	}
	final String? categoryName = jsonConvert.convert<dynamic>(json['categoryName']);
	if (categoryName != null) {
		courseDetailEntity.categoryName = categoryName;
	}
	final CourseDetailParentCourseDetail? parentCourseDetail = jsonConvert.convert<CourseDetailParentCourseDetail>(json['parentCourseDetail']);
	if (parentCourseDetail != null) {
		courseDetailEntity.parentCourseDetail = parentCourseDetail;
	}
	final List<CourseDetailVideos>? videos = jsonConvert.convertListNotNull<CourseDetailVideos>(json['videos']);
	if (videos != null) {
		courseDetailEntity.videos = videos;
	}
	final List<CourseDetailFiles>? files = jsonConvert.convertListNotNull<CourseDetailFiles>(json['files']);
	if (files != null) {
		courseDetailEntity.files = files;
	}
	final List<CourseDetailSchedules>? schedules = jsonConvert.convertListNotNull<CourseDetailSchedules>(json['schedules']);
	if (schedules != null) {
		courseDetailEntity.schedules = schedules;
	}
	return courseDetailEntity;
}

Map<String, dynamic> $CourseDetailEntityToJson(CourseDetailEntity entity) {
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
	data['categoryName'] = entity.categoryName;
	data['parentCourseDetail'] = entity.parentCourseDetail?.toJson();
	data['videos'] =  entity.videos?.map((v) => v.toJson()).toList();
	data['files'] =  entity.files?.map((v) => v.toJson()).toList();
	data['schedules'] =  entity.schedules?.map((v) => v.toJson()).toList();
	return data;
}

CourseDetailParentCourseDetail $CourseDetailParentCourseDetailFromJson(Map<String, dynamic> json) {
	final CourseDetailParentCourseDetail courseDetailParentCourseDetail = CourseDetailParentCourseDetail();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		courseDetailParentCourseDetail.id = id;
	}
	final String? coursePhoto = jsonConvert.convert<String>(json['coursePhoto']);
	if (coursePhoto != null) {
		courseDetailParentCourseDetail.coursePhoto = coursePhoto;
	}
	final String? courseName = jsonConvert.convert<String>(json['courseName']);
	if (courseName != null) {
		courseDetailParentCourseDetail.courseName = courseName;
	}
	final int? parentCourse = jsonConvert.convert<int>(json['parentCourse']);
	if (parentCourse != null) {
		courseDetailParentCourseDetail.parentCourse = parentCourse;
	}
	final int? courseCategory = jsonConvert.convert<int>(json['courseCategory']);
	if (courseCategory != null) {
		courseDetailParentCourseDetail.courseCategory = courseCategory;
	}
	final String? courseDescription = jsonConvert.convert<String>(json['courseDescription']);
	if (courseDescription != null) {
		courseDetailParentCourseDetail.courseDescription = courseDescription;
	}
	final String? concatUs = jsonConvert.convert<String>(json['concatUs']);
	if (concatUs != null) {
		courseDetailParentCourseDetail.concatUs = concatUs;
	}
	final int? courseSerial = jsonConvert.convert<int>(json['courseSerial']);
	if (courseSerial != null) {
		courseDetailParentCourseDetail.courseSerial = courseSerial;
	}
	final int? type = jsonConvert.convert<int>(json['type']);
	if (type != null) {
		courseDetailParentCourseDetail.type = type;
	}
	return courseDetailParentCourseDetail;
}

Map<String, dynamic> $CourseDetailParentCourseDetailToJson(CourseDetailParentCourseDetail entity) {
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

CourseDetailVideos $CourseDetailVideosFromJson(Map<String, dynamic> json) {
	final CourseDetailVideos courseDetailVideos = CourseDetailVideos();
	final int? videoId = jsonConvert.convert<int>(json['videoId']);
	if (videoId != null) {
		courseDetailVideos.videoId = videoId;
	}
	final int? courseId = jsonConvert.convert<int>(json['courseId']);
	if (courseId != null) {
		courseDetailVideos.courseId = courseId;
	}
	final String? videoTitle = jsonConvert.convert<String>(json['videoTitle']);
	if (videoTitle != null) {
		courseDetailVideos.videoTitle = videoTitle;
	}
	final String? videoUrl = jsonConvert.convert<String>(json['videoUrl']);
	if (videoUrl != null) {
		courseDetailVideos.videoUrl = videoUrl;
	}
	return courseDetailVideos;
}

Map<String, dynamic> $CourseDetailVideosToJson(CourseDetailVideos entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['videoId'] = entity.videoId;
	data['courseId'] = entity.courseId;
	data['videoTitle'] = entity.videoTitle;
	data['videoUrl'] = entity.videoUrl;
	return data;
}

CourseDetailFiles $CourseDetailFilesFromJson(Map<String, dynamic> json) {
	final CourseDetailFiles courseDetailFiles = CourseDetailFiles();
	final int? fileId = jsonConvert.convert<int>(json['fileId']);
	if (fileId != null) {
		courseDetailFiles.fileId = fileId;
	}
	final String? fileTitle = jsonConvert.convert<String>(json['fileTitle']);
	if (fileTitle != null) {
		courseDetailFiles.fileTitle = fileTitle;
	}
	final String? fileUrl = jsonConvert.convert<String>(json['fileUrl']);
	if (fileUrl != null) {
		courseDetailFiles.fileUrl = fileUrl;
	}
	final int? courseId = jsonConvert.convert<int>(json['courseId']);
	if (courseId != null) {
		courseDetailFiles.courseId = courseId;
	}
	return courseDetailFiles;
}

Map<String, dynamic> $CourseDetailFilesToJson(CourseDetailFiles entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['fileId'] = entity.fileId;
	data['fileTitle'] = entity.fileTitle;
	data['fileUrl'] = entity.fileUrl;
	data['courseId'] = entity.courseId;
	return data;
}

CourseDetailSchedules $CourseDetailSchedulesFromJson(Map<String, dynamic> json) {
	final CourseDetailSchedules courseDetailSchedules = CourseDetailSchedules();
	final int? scheduleId = jsonConvert.convert<int>(json['scheduleId']);
	if (scheduleId != null) {
		courseDetailSchedules.scheduleId = scheduleId;
	}
	final int? courseId = jsonConvert.convert<int>(json['courseId']);
	if (courseId != null) {
		courseDetailSchedules.courseId = courseId;
	}
	final String? scheduleUrl = jsonConvert.convert<String>(json['scheduleUrl']);
	if (scheduleUrl != null) {
		courseDetailSchedules.scheduleUrl = scheduleUrl;
	}
	final int? scheduleTime = jsonConvert.convert<dynamic>(json['scheduleTime']);
	if (scheduleTime != null) {
		courseDetailSchedules.scheduleTime = scheduleTime;
	}
	final String? scheduleTitle = jsonConvert.convert<String>(json['scheduleTitle']);
	if (scheduleTitle != null) {
		courseDetailSchedules.scheduleTitle = scheduleTitle;
	}
	final String? scheduleVenue = jsonConvert.convert<String>(json['scheduleVenue']);
	if (scheduleVenue != null) {
		courseDetailSchedules.scheduleVenue = scheduleVenue;
	}
	return courseDetailSchedules;
}

Map<String, dynamic> $CourseDetailSchedulesToJson(CourseDetailSchedules entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['scheduleId'] = entity.scheduleId;
	data['courseId'] = entity.courseId;
	data['scheduleUrl'] = entity.scheduleUrl;
	data['scheduleTime'] = entity.scheduleTime;
	data['scheduleTitle'] = entity.scheduleTitle;
	data['scheduleVenue'] = entity.scheduleVenue;
	return data;
}