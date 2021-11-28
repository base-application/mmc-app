import 'dart:convert';
import 'package:mmc/generated/json/base/json_field.dart';
import 'package:mmc/generated/json/notification_entity.g.dart';

@JsonSerializable()
class NotificationEntity {

	late String notificationTitle;
	late int notificationId;
	String? registrationName;
	String? registrationLink;
	late String notificationContent;
	int? createId;
	late int notificationTime;
	late int notificationType;
	int? linkId;
	int? linkType;
	int? status;
	bool? check;
  
  NotificationEntity();

  factory NotificationEntity.fromJson(Map<String, dynamic> json) => $NotificationEntityFromJson(json);

  Map<String, dynamic> toJson() => $NotificationEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}