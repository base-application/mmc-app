import 'package:mmc/generated/json/base/json_convert_content.dart';
import 'package:mmc/bean/event_detail_info_entity.dart';

EventDetailInfoEntity $EventDetailInfoEntityFromJson(Map<String, dynamic> json) {
	final EventDetailInfoEntity eventDetailInfoEntity = EventDetailInfoEntity();
	final int? eventId = jsonConvert.convert<int>(json['eventId']);
	if (eventId != null) {
		eventDetailInfoEntity.eventId = eventId;
	}
	final String? eventTitle = jsonConvert.convert<String>(json['eventTitle']);
	if (eventTitle != null) {
		eventDetailInfoEntity.eventTitle = eventTitle;
	}
	final String? eventDescription = jsonConvert.convert<String>(json['eventDescription']);
	if (eventDescription != null) {
		eventDetailInfoEntity.eventDescription = eventDescription;
	}
	final int? eventStartTime = jsonConvert.convert<int>(json['eventStartTime']);
	if (eventStartTime != null) {
		eventDetailInfoEntity.eventStartTime = eventStartTime;
	}
	final int? eventEndTime = jsonConvert.convert<int>(json['eventEndTime']);
	if (eventEndTime != null) {
		eventDetailInfoEntity.eventEndTime = eventEndTime;
	}
	final String? eventLocation = jsonConvert.convert<String>(json['eventLocation']);
	if (eventLocation != null) {
		eventDetailInfoEntity.eventLocation = eventLocation;
	}
	final String? eventMapLink = jsonConvert.convert<String>(json['eventMapLink']);
	if (eventMapLink != null) {
		eventDetailInfoEntity.eventMapLink = eventMapLink;
	}
	final int? eventType = jsonConvert.convert<int>(json['eventType']);
	if (eventType != null) {
		eventDetailInfoEntity.eventType = eventType;
	}
	final int? createId = jsonConvert.convert<int>(json['createId']);
	if (createId != null) {
		eventDetailInfoEntity.createId = createId;
	}
	final List<EventDetailInfoEventPoster>? eventPoster = jsonConvert.convertListNotNull<EventDetailInfoEventPoster>(json['eventPoster']);
	if (eventPoster != null) {
		eventDetailInfoEntity.eventPoster = eventPoster;
	}
	final List<EventDetailInfoGroups>? groups = jsonConvert.convertListNotNull<EventDetailInfoGroups>(json['groups']);
	if (groups != null) {
		eventDetailInfoEntity.groups = groups;
	}
	final double? attendanceProportion = jsonConvert.convert<double>(json['attendanceProportion']);
	if (attendanceProportion != null) {
		eventDetailInfoEntity.attendanceProportion = attendanceProportion;
	}
	final int? approveStatus = jsonConvert.convert<int>(json['approveStatus']);
	if (approveStatus != null) {
		eventDetailInfoEntity.approveStatus = approveStatus;
	}
	final bool? checkIn = jsonConvert.convert<bool>(json['checkIn']);
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
	final EventDetailInfoEventPoster eventDetailInfoEventPoster = EventDetailInfoEventPoster();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		eventDetailInfoEventPoster.id = id;
	}
	final String? url = jsonConvert.convert<String>(json['url']);
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
	final EventDetailInfoGroups eventDetailInfoGroups = EventDetailInfoGroups();
	final int? groupId = jsonConvert.convert<int>(json['groupId']);
	if (groupId != null) {
		eventDetailInfoGroups.groupId = groupId;
	}
	final String? groupName = jsonConvert.convert<String>(json['groupName']);
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