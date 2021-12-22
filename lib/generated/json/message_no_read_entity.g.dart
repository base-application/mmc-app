import 'package:mmc/generated/json/base/json_convert_content.dart';
import 'package:mmc/bean/message_no_read_entity.dart';

MessageNoReadEntity $MessageNoReadEntityFromJson(Map<String, dynamic> json) {
	final MessageNoReadEntity messageNoReadEntity = MessageNoReadEntity();
	final int? count = jsonConvert.convert<int>(json['count']);
	if (count != null) {
		messageNoReadEntity.count = count;
	}
	final int? event = jsonConvert.convert<int>(json['event']);
	if (event != null) {
		messageNoReadEntity.event = event;
	}
	final int? newset = jsonConvert.convert<int>(json['newset']);
	if (newset != null) {
		messageNoReadEntity.newset = newset;
	}
	final int? notification = jsonConvert.convert<int>(json['notification']);
	if (notification != null) {
		messageNoReadEntity.notification = notification;
	}
	final int? referral = jsonConvert.convert<int>(json['referral']);
	if (referral != null) {
		messageNoReadEntity.referral = referral;
	}
	final int? thank = jsonConvert.convert<int>(json['thank']);
	if (thank != null) {
		messageNoReadEntity.thank = thank;
	}
	return messageNoReadEntity;
}

Map<String, dynamic> $MessageNoReadEntityToJson(MessageNoReadEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['count'] = entity.count;
	data['event'] = entity.event;
	data['newset'] = entity.newset;
	data['notification'] = entity.notification;
	data['referral'] = entity.referral;
	data['thank'] = entity.thank;
	return data;
}