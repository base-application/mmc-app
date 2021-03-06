import 'package:mmc/generated/json/base/json_convert_content.dart';
import 'package:mmc/bean/notification_entity.dart';

NotificationEntity $NotificationEntityFromJson(Map<String, dynamic> json) {
	final NotificationEntity notificationEntity = NotificationEntity();
	final String? notificationTitle = jsonConvert.convert<String>(json['notificationTitle']);
	if (notificationTitle != null) {
		notificationEntity.notificationTitle = notificationTitle;
	}
	final int? notificationId = jsonConvert.convert<int>(json['notificationId']);
	if (notificationId != null) {
		notificationEntity.notificationId = notificationId;
	}
	final String? registrationName = jsonConvert.convert<String>(json['registrationName']);
	if (registrationName != null) {
		notificationEntity.registrationName = registrationName;
	}
	final String? registrationLink = jsonConvert.convert<String>(json['registrationLink']);
	if (registrationLink != null) {
		notificationEntity.registrationLink = registrationLink;
	}
	final String? notificationContent = jsonConvert.convert<String>(json['notificationContent']);
	if (notificationContent != null) {
		notificationEntity.notificationContent = notificationContent;
	}
	final int? createId = jsonConvert.convert<int>(json['createId']);
	if (createId != null) {
		notificationEntity.createId = createId;
	}
	final int? notificationTime = jsonConvert.convert<int>(json['notificationTime']);
	if (notificationTime != null) {
		notificationEntity.notificationTime = notificationTime;
	}
	final int? notificationType = jsonConvert.convert<int>(json['notificationType']);
	if (notificationType != null) {
		notificationEntity.notificationType = notificationType;
	}
	final int? linkId = jsonConvert.convert<int>(json['linkId']);
	if (linkId != null) {
		notificationEntity.linkId = linkId;
	}
	final int? linkType = jsonConvert.convert<int>(json['linkType']);
	if (linkType != null) {
		notificationEntity.linkType = linkType;
	}
	final int? status = jsonConvert.convert<int>(json['status']);
	if (status != null) {
		notificationEntity.status = status;
	}
	final bool? check = jsonConvert.convert<bool>(json['check']);
	if (check != null) {
		notificationEntity.check = check;
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
	data['check'] = entity.check;
	return data;
}