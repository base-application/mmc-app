import 'package:mmc/generated/json/base/json_convert_content.dart';
import 'package:mmc/bean/check_log_entity.dart';

CheckLogEntity $CheckLogEntityFromJson(Map<String, dynamic> json) {
	final CheckLogEntity checkLogEntity = CheckLogEntity();
	final int? checkLogId = jsonConvert.convert<int>(json['checkLogId']);
	if (checkLogId != null) {
		checkLogEntity.checkLogId = checkLogId;
	}
	final int? eventId = jsonConvert.convert<int>(json['eventId']);
	if (eventId != null) {
		checkLogEntity.eventId = eventId;
	}
	final int? userId = jsonConvert.convert<int>(json['userId']);
	if (userId != null) {
		checkLogEntity.userId = userId;
	}
	final int? checkType = jsonConvert.convert<int>(json['checkType']);
	if (checkType != null) {
		checkLogEntity.checkType = checkType;
	}
	final int? createTime = jsonConvert.convert<int>(json['createTime']);
	if (createTime != null) {
		checkLogEntity.createTime = createTime;
	}
	final String? eventTitle = jsonConvert.convert<String>(json['eventTitle']);
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