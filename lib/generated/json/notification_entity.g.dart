import 'package:mmc/generated/json/base/json_convert_content.dart';
import 'package:mmc/bean/notification_entity.dart';

NotificationEntity $NotificationEntityFromJson(Map<String, dynamic> json) {
	NotificationEntity notificationEntity = NotificationEntity();
	var notificationTitle = jsonConvert.convert<String>(json['notificationTitle']);
	if (notificationTitle != null) {
		notificationEntity.notificationTitle = notificationTitle;
	}
	var notificationId = jsonConvert.convert<int>(json['notificationId']);
	if (notificationId != null) {
		notificationEntity.notificationId = notificationId;
	}
	var registrationName = jsonConvert.convert<String>(json['registrationName']);
	if (registrationName != null) {
		notificationEntity.registrationName = registrationName;
	}
	var registrationLink = jsonConvert.convert<String>(json['registrationLink']);
	if (registrationLink != null) {
		notificationEntity.registrationLink = registrationLink;
	}
	var notificationContent = jsonConvert.convert<String>(json['notificationContent']);
	if (notificationContent != null) {
		notificationEntity.notificationContent = notificationContent;
	}
	var createId = jsonConvert.convert<int>(json['createId']);
	if (createId != null) {
		notificationEntity.createId = createId;
	}
	var notificationTime = jsonConvert.convert<int>(json['notificationTime']);
	if (notificationTime != null) {
		notificationEntity.notificationTime = notificationTime;
	}
	var notificationType = jsonConvert.convert<int>(json['notificationType']);
	if (notificationType != null) {
		notificationEntity.notificationType = notificationType;
	}
	var linkId = jsonConvert.convert<dynamic>(json['linkId']);
	if (linkId != null) {
		notificationEntity.linkId = linkId;
	}
	var linkType = jsonConvert.convert<int>(json['linkType']);
	if (linkType != null) {
		notificationEntity.linkType = linkType;
	}
	var status = jsonConvert.convert<int>(json['status']);
	if (status != null) {
		notificationEntity.status = status;
	}
	return notificationEntity;
}

Map<String, dynamic> $NotificationEntityToJson(NotificationEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['notificationTitle'] = entity.notificationTitle;
	data['notificationId'] = entity.notificationId;
	data['registrationName'] = entity.registrationName;
	data['registrationLink'] = entity.registrationLink;
	data['notificationContent'] = entity.notificationContent;
	data['createId'] = entity.createId;
	data['notificationTime'] = entity.notificationTime;
	data['notificationType'] = entity.notificationType;
	data['linkId'] = entity.linkId;
	data['linkType'] = entity.linkType;
	data['status'] = entity.status;
	return data;
}