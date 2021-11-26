import 'package:mmc/generated/json/base/json_field.dart';
import 'package:mmc/generated/json/event_data_item_info_entity.g.dart';


@JsonSerializable()
class EventDataItemInfoEntity {

	EventDataItemInfoEntity();

	factory EventDataItemInfoEntity.fromJson(Map<String, dynamic> json) => $EventDataItemInfoEntityFromJson(json);

	Map<String, dynamic> toJson() => $EventDataItemInfoEntityToJson(this);

	late int eventId;
	late String eventTitle;
	late String eventDescription;
	int? eventStartTime;
	int? eventEndTime;
	String? eventLocation;
	String? eventMapLink;
	int? eventType;
	int? createId;
	int? checkInTime;
	int? checkOutTime;
	List<EventDataItemInfoEventPoster>? eventPoster;
	List<EventDataItemInfoGroups>? groups;
	List<EventDataItemInfoAttendance>? attendance;
	double? attendanceProportion;
	int? approveStatus;
	bool? checkIn; // null 为未加入    true 已加入 已签到     false 已加入 未签到
  bool? attend;
  bool? join;
}

@JsonSerializable()
class EventDataItemInfoEventPoster {

	EventDataItemInfoEventPoster();

	factory EventDataItemInfoEventPoster.fromJson(Map<String, dynamic> json) => $EventDataItemInfoEventPosterFromJson(json);

	Map<String, dynamic> toJson() => $EventDataItemInfoEventPosterToJson(this);

	int? id;
	late String url;
}

@JsonSerializable()
class EventDataItemInfoGroups {

	EventDataItemInfoGroups();

	factory EventDataItemInfoGroups.fromJson(Map<String, dynamic> json) => $EventDataItemInfoGroupsFromJson(json);

	Map<String, dynamic> toJson() => $EventDataItemInfoGroupsToJson(this);

	int? groupId;
	late String groupName;
}

@JsonSerializable()
class EventDataItemInfoAttendance {

	EventDataItemInfoAttendance();

	factory EventDataItemInfoAttendance.fromJson(Map<String, dynamic> json) => $EventDataItemInfoAttendanceFromJson(json);

	Map<String, dynamic> toJson() => $EventDataItemInfoAttendanceToJson(this);

	late int userId;
	late int eventId;
	int? checkInTime;
	int? checkOutTime;
	bool? attendance;
	String? remark;
	String? name;
	String? picture;
	String? gradeName;
	String? concatNumber;
	String? absentReason;
	bool? facebookComment;
}
