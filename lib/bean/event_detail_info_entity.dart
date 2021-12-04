import 'package:mmc/generated/json/base/json_field.dart';
import 'package:mmc/generated/json/event_detail_info_entity.g.dart';


@JsonSerializable()
class EventDetailInfoEntity {

	EventDetailInfoEntity();

	factory EventDetailInfoEntity.fromJson(Map<String, dynamic> json) => $EventDetailInfoEntityFromJson(json);

	Map<String, dynamic> toJson() => $EventDetailInfoEntityToJson(this);

	late int eventId;
	late String eventTitle;
	late String eventDescription;
	late int eventStartTime;
	late int eventEndTime;
	String? eventLocation;
	String? eventMapLink;
	int? eventType;
	int? createId;
	List<EventDetailInfoEventPoster>? eventPoster;
	List<EventDetailInfoGroups>? groups;
	double? attendanceProportion;
	int? approveStatus;
	bool? checkIn;
}

@JsonSerializable()
class EventDetailInfoEventPoster {

	EventDetailInfoEventPoster();

	factory EventDetailInfoEventPoster.fromJson(Map<String, dynamic> json) => $EventDetailInfoEventPosterFromJson(json);

	Map<String, dynamic> toJson() => $EventDetailInfoEventPosterToJson(this);

	late int id;
	late String url;
}

@JsonSerializable()
class EventDetailInfoGroups {

	EventDetailInfoGroups();

	factory EventDetailInfoGroups.fromJson(Map<String, dynamic> json) => $EventDetailInfoGroupsFromJson(json);

	Map<String, dynamic> toJson() => $EventDetailInfoGroupsToJson(this);

	late int groupId;
	late String groupName;
}
