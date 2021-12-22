import 'package:mmc/generated/json/base/json_convert_content.dart';
import 'package:mmc/bean/event_data_item_info_entity.dart';
import 'package:mmc/bean/grade_level_info_entity.dart';

import 'package:mmc/bean/group_item_entity.dart';


EventDataItemInfoEntity $EventDataItemInfoEntityFromJson(Map<String, dynamic> json) {
	final EventDataItemInfoEntity eventDataItemInfoEntity = EventDataItemInfoEntity();
	final int? eventId = jsonConvert.convert<int>(json['eventId']);
	if (eventId != null) {
		eventDataItemInfoEntity.eventId = eventId;
	}
	final String? eventTitle = jsonConvert.convert<String>(json['eventTitle']);
	if (eventTitle != null) {
		eventDataItemInfoEntity.eventTitle = eventTitle;
	}
	final String? eventDescription = jsonConvert.convert<String>(json['eventDescription']);
	if (eventDescription != null) {
		eventDataItemInfoEntity.eventDescription = eventDescription;
	}
	final int? eventStartTime = jsonConvert.convert<int>(json['eventStartTime']);
	if (eventStartTime != null) {
		eventDataItemInfoEntity.eventStartTime = eventStartTime;
	}
	final int? eventEndTime = jsonConvert.convert<int>(json['eventEndTime']);
	if (eventEndTime != null) {
		eventDataItemInfoEntity.eventEndTime = eventEndTime;
	}
	final String? eventLocation = jsonConvert.convert<String>(json['eventLocation']);
	if (eventLocation != null) {
		eventDataItemInfoEntity.eventLocation = eventLocation;
	}
	final String? eventMapLink = jsonConvert.convert<String>(json['eventMapLink']);
	if (eventMapLink != null) {
		eventDataItemInfoEntity.eventMapLink = eventMapLink;
	}
	final int? eventType = jsonConvert.convert<int>(json['eventType']);
	if (eventType != null) {
		eventDataItemInfoEntity.eventType = eventType;
	}
	final int? createId = jsonConvert.convert<int>(json['createId']);
	if (createId != null) {
		eventDataItemInfoEntity.createId = createId;
	}
	final int? checkInTime = jsonConvert.convert<int>(json['checkInTime']);
	if (checkInTime != null) {
		eventDataItemInfoEntity.checkInTime = checkInTime;
	}
	final int? checkOutTime = jsonConvert.convert<int>(json['checkOutTime']);
	if (checkOutTime != null) {
		eventDataItemInfoEntity.checkOutTime = checkOutTime;
	}
	final List<EventDataItemInfoEventPoster>? eventPoster = jsonConvert.convertListNotNull<EventDataItemInfoEventPoster>(json['eventPoster']);
	if (eventPoster != null) {
		eventDataItemInfoEntity.eventPoster = eventPoster;
	}
	final List<GroupItemEntity>? groups = jsonConvert.convertListNotNull<GroupItemEntity>(json['groups']);
	if (groups != null) {
		eventDataItemInfoEntity.groups = groups;
	}
	final List<GradeLevelInfoEntity>? grades = jsonConvert.convertListNotNull<GradeLevelInfoEntity>(json['grades']);
	if (grades != null) {
		eventDataItemInfoEntity.grades = grades;
	}
	final List<EventDataItemInfoAttendance>? attendance = jsonConvert.convertListNotNull<EventDataItemInfoAttendance>(json['attendance']);
	if (attendance != null) {
		eventDataItemInfoEntity.attendance = attendance;
	}
	final double? attendanceProportion = jsonConvert.convert<double>(json['attendanceProportion']);
	if (attendanceProportion != null) {
		eventDataItemInfoEntity.attendanceProportion = attendanceProportion;
	}
	final int? approveStatus = jsonConvert.convert<int>(json['approveStatus']);
	if (approveStatus != null) {
		eventDataItemInfoEntity.approveStatus = approveStatus;
	}
	final bool? checkIn = jsonConvert.convert<bool>(json['checkIn']);
	if (checkIn != null) {
		eventDataItemInfoEntity.checkIn = checkIn;
	}
	final bool? attend = jsonConvert.convert<bool>(json['attend']);
	if (attend != null) {
		eventDataItemInfoEntity.attend = attend;
	}
	final bool? join = jsonConvert.convert<bool>(json['join']);
	if (join != null) {
		eventDataItemInfoEntity.join = join;
	}
	return eventDataItemInfoEntity;
}

Map<String, dynamic> $EventDataItemInfoEntityToJson(EventDataItemInfoEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['eventId'] = entity.eventId;
	data['eventTitle'] = entity.eventTitle;
	data['eventDescription'] = entity.eventDescription;
	data['eventStartTime'] = entity.eventStartTime;
	data['eventEndTime'] = entity.eventEndTime;
	data['eventLocation'] = entity.eventLocation;
	data['eventMapLink'] = entity.eventMapLink;
	data['eventType'] = entity.eventType;
	data['createId'] = entity.createId;
	data['checkInTime'] = entity.checkInTime;
	data['checkOutTime'] = entity.checkOutTime;
	data['eventPoster'] =  entity.eventPoster?.map((v) => v.toJson()).toList();
	data['groups'] =  entity.groups?.map((v) => v.toJson()).toList();
	data['grades'] =  entity.grades?.map((v) => v.toJson()).toList();
	data['attendance'] =  entity.attendance?.map((v) => v.toJson()).toList();
	data['attendanceProportion'] = entity.attendanceProportion;
	data['approveStatus'] = entity.approveStatus;
	data['checkIn'] = entity.checkIn;
	data['attend'] = entity.attend;
	data['join'] = entity.join;
	return data;
}

EventDataItemInfoEventPoster $EventDataItemInfoEventPosterFromJson(Map<String, dynamic> json) {
	final EventDataItemInfoEventPoster eventDataItemInfoEventPoster = EventDataItemInfoEventPoster();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		eventDataItemInfoEventPoster.id = id;
	}
	final String? url = jsonConvert.convert<String>(json['url']);
	if (url != null) {
		eventDataItemInfoEventPoster.url = url;
	}
	return eventDataItemInfoEventPoster;
}

Map<String, dynamic> $EventDataItemInfoEventPosterToJson(EventDataItemInfoEventPoster entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['url'] = entity.url;
	return data;
}

EventDataItemInfoGroups $EventDataItemInfoGroupsFromJson(Map<String, dynamic> json) {
	final EventDataItemInfoGroups eventDataItemInfoGroups = EventDataItemInfoGroups();
	final int? groupId = jsonConvert.convert<int>(json['groupId']);
	if (groupId != null) {
		eventDataItemInfoGroups.groupId = groupId;
	}
	final String? groupName = jsonConvert.convert<String>(json['groupName']);
	if (groupName != null) {
		eventDataItemInfoGroups.groupName = groupName;
	}
	return eventDataItemInfoGroups;
}

Map<String, dynamic> $EventDataItemInfoGroupsToJson(EventDataItemInfoGroups entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['groupId'] = entity.groupId;
	data['groupName'] = entity.groupName;
	return data;
}

EventDataItemInfoAttendance $EventDataItemInfoAttendanceFromJson(Map<String, dynamic> json) {
	final EventDataItemInfoAttendance eventDataItemInfoAttendance = EventDataItemInfoAttendance();
	final int? userId = jsonConvert.convert<int>(json['userId']);
	if (userId != null) {
		eventDataItemInfoAttendance.userId = userId;
	}
	final int? eventId = jsonConvert.convert<int>(json['eventId']);
	if (eventId != null) {
		eventDataItemInfoAttendance.eventId = eventId;
	}
	final int? checkInTime = jsonConvert.convert<int>(json['checkInTime']);
	if (checkInTime != null) {
		eventDataItemInfoAttendance.checkInTime = checkInTime;
	}
	final int? checkOutTime = jsonConvert.convert<int>(json['checkOutTime']);
	if (checkOutTime != null) {
		eventDataItemInfoAttendance.checkOutTime = checkOutTime;
	}
	final bool? attendance = jsonConvert.convert<bool>(json['attendance']);
	if (attendance != null) {
		eventDataItemInfoAttendance.attendance = attendance;
	}
	final String? remark = jsonConvert.convert<String>(json['remark']);
	if (remark != null) {
		eventDataItemInfoAttendance.remark = remark;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		eventDataItemInfoAttendance.name = name;
	}
	final String? picture = jsonConvert.convert<String>(json['picture']);
	if (picture != null) {
		eventDataItemInfoAttendance.picture = picture;
	}
	final String? gradeName = jsonConvert.convert<String>(json['gradeName']);
	if (gradeName != null) {
		eventDataItemInfoAttendance.gradeName = gradeName;
	}
	final String? concatNumber = jsonConvert.convert<String>(json['concatNumber']);
	if (concatNumber != null) {
		eventDataItemInfoAttendance.concatNumber = concatNumber;
	}
	final String? absentReason = jsonConvert.convert<String>(json['absentReason']);
	if (absentReason != null) {
		eventDataItemInfoAttendance.absentReason = absentReason;
	}
	final bool? facebookComment = jsonConvert.convert<bool>(json['facebookComment']);
	if (facebookComment != null) {
		eventDataItemInfoAttendance.facebookComment = facebookComment;
	}
	return eventDataItemInfoAttendance;
}

Map<String, dynamic> $EventDataItemInfoAttendanceToJson(EventDataItemInfoAttendance entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['userId'] = entity.userId;
	data['eventId'] = entity.eventId;
	data['checkInTime'] = entity.checkInTime;
	data['checkOutTime'] = entity.checkOutTime;
	data['attendance'] = entity.attendance;
	data['remark'] = entity.remark;
	data['name'] = entity.name;
	data['picture'] = entity.picture;
	data['gradeName'] = entity.gradeName;
	data['concatNumber'] = entity.concatNumber;
	data['absentReason'] = entity.absentReason;
	data['facebookComment'] = entity.facebookComment;
	return data;
}