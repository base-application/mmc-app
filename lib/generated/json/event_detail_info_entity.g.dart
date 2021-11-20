import 'package:mmc/generated/json/base/json_convert_content.dart';
import 'package:mmc/bean/event_detail_info_entity.dart';

EventDetailInfoEntity $EventDetailInfoEntityFromJson(Map<String, dynamic> json) {
	EventDetailInfoEntity eventDetailInfoEntity = EventDetailInfoEntity();
	var eventId = jsonConvert.convert<int>(json['eventId']);
	if (eventId != null) {
		eventDetailInfoEntity.eventId = eventId;
	}
	var eventTitle = jsonConvert.convert<String>(json['eventTitle']);
	if (eventTitle != null) {
		eventDetailInfoEntity.eventTitle = eventTitle;
	}
	var eventDescription = jsonConvert.convert<String>(json['eventDescription']);
	if (eventDescription != null) {
		eventDetailInfoEntity.eventDescription = eventDescription;
	}
	var eventStartTime = jsonConvert.convert<int>(json['eventStartTime']);
	if (eventStartTime != null) {
		eventDetailInfoEntity.eventStartTime = eventStartTime;
	}
	var eventEndTime = jsonConvert.convert<int>(json['eventEndTime']);
	if (eventEndTime != null) {
		eventDetailInfoEntity.eventEndTime = eventEndTime;
	}
	var eventLocation = jsonConvert.convert<String>(json['eventLocation']);
	if (eventLocation != null) {
		eventDetailInfoEntity.eventLocation = eventLocation;
	}
	var eventMapLink = jsonConvert.convert<String>(json['eventMapLink']);
	if (eventMapLink != null) {
		eventDetailInfoEntity.eventMapLink = eventMapLink;
	}
	var eventType = jsonConvert.convert<int>(json['eventType']);
	if (eventType != null) {
		eventDetailInfoEntity.eventType = eventType;
	}
	var createId = jsonConvert.convert<int>(json['createId']);
	if (createId != null) {
		eventDetailInfoEntity.createId = createId;
	}
	var eventPoster = jsonConvert.convertListNotNull<EventDetailInfoEventPoster>(json['eventPoster']);
	if (eventPoster != null) {
		eventDetailInfoEntity.eventPoster = eventPoster;
	}
	var groups = jsonConvert.convertListNotNull<EventDetailInfoGroups>(json['groups']);
	if (groups != null) {
		eventDetailInfoEntity.groups = groups;
	}
	var attendanceProportion = jsonConvert.convert<double>(json['attendanceProportion']);
	if (attendanceProportion != null) {
		eventDetailInfoEntity.attendanceProportion = attendanceProportion;
	}
	var approveStatus = jsonConvert.convert<int>(json['approveStatus']);
	if (approveStatus != null) {
		eventDetailInfoEntity.approveStatus = approveStatus;
	}
	var checkIn = jsonConvert.convert<bool>(json['checkIn']);
	if (checkIn != null) {
		eventDetailInfoEntity.checkIn = checkIn;
	}
	return eventDetailInfoEntity;
}

Map<String, dynamic> $EventDetailInfoEntityToJson(EventDetailInfoEntity entity) {
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
	data['eventPoster'] =  entity.eventPoster?.map((v) => v.toJson()).toList();
	data['groups'] =  entity.groups?.map((v) => v.toJson()).toList();
	data['attendanceProportion'] = entity.attendanceProportion;
	data['approveStatus'] = entity.approveStatus;
	data['checkIn'] = entity.checkIn;
	return data;
}

EventDetailInfoEventPoster $EventDetailInfoEventPosterFromJson(Map<String, dynamic> json) {
	EventDetailInfoEventPoster eventDetailInfoEventPoster = EventDetailInfoEventPoster();
	var id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		eventDetailInfoEventPoster.id = id;
	}
	var url = jsonConvert.convert<String>(json['url']);
	if (url != null) {
		eventDetailInfoEventPoster.url = url;
	}
	return eventDetailInfoEventPoster;
}

Map<String, dynamic> $EventDetailInfoEventPosterToJson(EventDetailInfoEventPoster entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['url'] = entity.url;
	return data;
}

EventDetailInfoGroups $EventDetailInfoGroupsFromJson(Map<String, dynamic> json) {
	EventDetailInfoGroups eventDetailInfoGroups = EventDetailInfoGroups();
	var groupId = jsonConvert.convert<int>(json['groupId']);
	if (groupId != null) {
		eventDetailInfoGroups.groupId = groupId;
	}
	var groupName = jsonConvert.convert<String>(json['groupName']);
	if (groupName != null) {
		eventDetailInfoGroups.groupName = groupName;
	}
	return eventDetailInfoGroups;
}

Map<String, dynamic> $EventDetailInfoGroupsToJson(EventDetailInfoGroups entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['groupId'] = entity.groupId;
	data['groupName'] = entity.groupName;
	return data;
}