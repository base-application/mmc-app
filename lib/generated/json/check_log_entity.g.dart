import 'package:mmc/generated/json/base/json_convert_content.dart';
import 'package:mmc/bean/check_log_entity.dart';

CheckLogEntity $CheckLogEntityFromJson(Map<String, dynamic> json) {
	CheckLogEntity checkLogEntity = CheckLogEntity();
	var checkLogId = jsonConvert.convert<int>(json['checkLogId']);
	if (checkLogId != null) {
		checkLogEntity.checkLogId = checkLogId;
	}
	var eventId = jsonConvert.convert<int>(json['eventId']);
	if (eventId != null) {
		checkLogEntity.eventId = eventId;
	}
	var userId = jsonConvert.convert<int>(json['userId']);
	if (userId != null) {
		checkLogEntity.userId = userId;
	}
	var checkType = jsonConvert.convert<int>(json['checkType']);
	if (checkType != null) {
		checkLogEntity.checkType = checkType;
	}
	var createTime = jsonConvert.convert<int>(json['createTime']);
	if (createTime != null) {
		checkLogEntity.createTime = createTime;
	}
	var eventTitle = jsonConvert.convert<String>(json['eventTitle']);
	if (eventTitle != null) {
		checkLogEntity.eventTitle = eventTitle;
	}
	return checkLogEntity;
}

Map<String, dynamic> $CheckLogEntityToJson(CheckLogEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['checkLogId'] = entity.checkLogId;
	data['eventId'] = entity.eventId;
	data['userId'] = entity.userId;
	data['checkType'] = entity.checkType;
	data['createTime'] = entity.createTime;
	data['eventTitle'] = entity.eventTitle;
	return data;
}