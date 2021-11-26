import 'package:mmc/generated/json/base/json_convert_content.dart';
import 'package:mmc/bean/event_data_item_info_entity.dart';

EventDataItemInfoEntity $EventDataItemInfoEntityFromJson(Map<String, dynamic> json) {
	EventDataItemInfoEntity eventDataItemInfoEntity = EventDataItemInfoEntity();
	var eventId = jsonConvert.convert<int>(json['eventId']);
	if (eventId != null) {
		eventDataItemInfoEntity.eventId = eventId;
	}
	var eventTitle = jsonConvert.convert<String>(json['eventTitle']);
	if (eventTitle != null) {
		eventDataItemInfoEntity.eventTitle = eventTitle;
	}
	var eventDescription = jsonConvert.convert<String>(json['eventDescription']);
	if (eventDescription != null) {
		eventDataItemInfoEntity.eventDescription = eventDescription;
	}
	var eventStartTime = jsonConvert.convert<int>(json['eventStartTime']);
	if (eventStartTime != null) {
		eventDataItemInfoEntity.eventStartTime = eventStartTime;
	}
	var eventEndTime = jsonConvert.convert<int>(json['eventEndTime']);
	if (eventEndTime != null) {
		eventDataItemInfoEntity.eventEndTime = eventEndTime;
	}
	var eventLocation = jsonConvert.convert<String>(json['eventLocation']);
	if (eventLocation != null) {
		eventDataItemInfoEntity.eventLocation = eventLocation;
	}
	var eventMapLink = jsonConvert.convert<String>(json['eventMapLink']);
	if (eventMapLink != null) {
		eventDataItemInfoEntity.eventMapLink = eventMapLink;
	}
	var eventType = jsonConvert.convert<int>(json['eventType']);
	if (eventType != null) {
		eventDataItemInfoEntity.eventType = eventType;
	}
	var createId = jsonConvert.convert<int>(json['createId']);
	if (createId != null) {
		eventDataItemInfoEntity.createId = createId;
	}
	var checkInTime = jsonConvert.convert<int>(json['checkInTime']);
	if (checkInTime != null) {
		eventDataItemInfoEntity.checkInTime = checkInTime;
	}
	var checkOutTime = jsonConvert.convert<int>(json['checkOutTime']);
	if (checkOutTime != null) {
		eventDataItemInfoEntity.checkOutTime = checkOutTime;
	}
	var eventPoster = jsonConvert.convertListNotNull<EventDataItemInfoEventPoster>(json['eventPoster']);
	if (eventPoster != null) {
		eventDataItemInfoEntity.eventPoster = eventPoster;
	}
	var groups = jsonConvert.convertListNotNull<EventDataItemInfoGroups>(json['groups']);
	if (groups != null) {
		eventDataItemInfoEntity.groups = groups;
	}
	var attendance = jsonConvert.convertListNotNull<EventDataItemInfoAttendance>(json['attendance']);
	if (attendance != null) {
		eventDataItemInfoEntity.attendance = attendance;
	}
	var attendanceProportion = jsonConvert.convert<double>(json['attendanceProportion']);
	if (attendanceProportion != null) {
		eventDataItemInfoEntity.attendanceProportion = attendanceProportion;
	}
	var approveStatus = jsonConvert.convert<int>(json['approveStatus']);
	if (approveStatus != null) {
		eventDataItemInfoEntity.approveStatus = approveStatus;
	}
	var checkIn = jsonConvert.convert<bool>(json['checkIn']);
	if (checkIn != null) {
		eventDataItemInfoEntity.checkIn = checkIn;
	}
	var attend = jsonConvert.convert<bool>(json['attend']);
	if (attend != null) {
		eventDataItemInfoEntity.attend = attend;
	}
	var join = jsonConvert.convert<bool>(json['join']);
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
	data['attendance'] =  entity.attendance?.map((v) => v.toJson()).toList();
	data['attendanceProportion'] = entity.attendanceProportion;
	data['approveStatus'] = entity.approveStatus;
	data['checkIn'] = entity.checkIn;
	data['attend'] = entity.attend;
	data['join'] = entity.join;
	return data;
}

EventDataItemInfoEventPoster $EventDataItemInfoEventPosterFromJson(Map<String, dynamic> json) {
	EventDataItemInfoEventPoster eventDataItemInfoEventPoster = EventDataItemInfoEventPoster();
	var id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		eventDataItemInfoEventPoster.id = id;
	}
	var url = jsonConvert.convert<String>(json['url']);
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
	EventDataItemInfoGroups eventDataItemInfoGroups = EventDataItemInfoGroups();
	var groupId = jsonConvert.convert<int>(json['groupId']);
	if (groupId != null) {
		eventDataItemInfoGroups.groupId = groupId;
	}
	var groupName = jsonConvert.convert<String>(json['groupName']);
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
	EventDataItemInfoAttendance eventDataItemInfoAttendance = EventDataItemInfoAttendance();
	var userId = jsonConvert.convert<int>(json['userId']);
	if (userId != null) {
		eventDataItemInfoAttendance.userId = userId;
	}
	var eventId = jsonConvert.convert<int>(json['eventId']);
	if (eventId != null) {
		eventDataItemInfoAttendance.eventId = eventId;
	}
	var checkInTime = jsonConvert.convert<int>(json['checkInTime']);
	if (checkInTime != null) {
		eventDataItemInfoAttendance.checkInTime = checkInTime;
	}
	var checkOutTime = jsonConvert.convert<int>(json['checkOutTime']);
	if (checkOutTime != null) {
		eventDataItemInfoAttendance.checkOutTime = checkOutTime;
	}
	var attendance = jsonConvert.convert<bool>(json['attendance']);
	if (attendance != null) {
		eventDataItemInfoAttendance.attendance = attendance;
	}
	var remark = jsonConvert.convert<String>(json['remark']);
	if (remark != null) {
		eventDataItemInfoAttendance.remark = remark;
	}
	var name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		eventDataItemInfoAttendance.name = name;
	}
	var picture = jsonConvert.convert<String>(json['picture']);
	if (picture != null) {
		eventDataItemInfoAttendance.picture = picture;
	}
	var gradeName = jsonConvert.convert<String>(json['gradeName']);
	if (gradeName != null) {
		eventDataItemInfoAttendance.gradeName = gradeName;
	}
	var concatNumber = jsonConvert.convert<String>(json['concatNumber']);
	if (concatNumber != null) {
		eventDataItemInfoAttendance.concatNumber = concatNumber;
	}
	var absentReason = jsonConvert.convert<String>(json['absentReason']);
	if (absentReason != null) {
		eventDataItemInfoAttendance.absentReason = absentReason;
	}
	var facebookComment = jsonConvert.convert<bool>(json['facebookComment']);
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