import 'package:mmc/generated/json/base/json_convert_content.dart';
import 'package:mmc/bean/thank_note_entity.dart';

ThankNoteEntity $ThankNoteEntityFromJson(Map<String, dynamic> json) {
	final ThankNoteEntity thankNoteEntity = ThankNoteEntity();
	final int? fromUserId = jsonConvert.convert<int>(json['fromUserId']);
	if (fromUserId != null) {
		thankNoteEntity.fromUserId = fromUserId;
	}
	final String? fromPicture = jsonConvert.convert<String>(json['fromPicture']);
	if (fromPicture != null) {
		thankNoteEntity.fromPicture = fromPicture;
	}
	final int? fromGroupId = jsonConvert.convert<int>(json['fromGroupId']);
	if (fromGroupId != null) {
		thankNoteEntity.fromGroupId = fromGroupId;
	}
	final String? fromName = jsonConvert.convert<String>(json['fromName']);
	if (fromName != null) {
		thankNoteEntity.fromName = fromName;
	}
	final int? toUserId = jsonConvert.convert<int>(json['toUserId']);
	if (toUserId != null) {
		thankNoteEntity.toUserId = toUserId;
	}
	final String? toPicture = jsonConvert.convert<String>(json['toPicture']);
	if (toPicture != null) {
		thankNoteEntity.toPicture = toPicture;
	}
	final int? toGroupId = jsonConvert.convert<int>(json['toGroupId']);
	if (toGroupId != null) {
		thankNoteEntity.toGroupId = toGroupId;
	}
	final String? toName = jsonConvert.convert<String>(json['toName']);
	if (toName != null) {
		thankNoteEntity.toName = toName;
	}
	final int? thankYouNoteId = jsonConvert.convert<int>(json['thankYouNoteId']);
	if (thankYouNoteId != null) {
		thankNoteEntity.thankYouNoteId = thankYouNoteId;
	}
	final int? sendUser = jsonConvert.convert<int>(json['sendUser']);
	if (sendUser != null) {
		thankNoteEntity.sendUser = sendUser;
	}
	final int? receivedUser = jsonConvert.convert<int>(json['receivedUser']);
	if (receivedUser != null) {
		thankNoteEntity.receivedUser = receivedUser;
	}
	final int? sendTime = jsonConvert.convert<int>(json['sendTime']);
	if (sendTime != null) {
		thankNoteEntity.sendTime = sendTime;
	}
	final int? receivedTime = jsonConvert.convert<int>(json['receivedTime']);
	if (receivedTime != null) {
		thankNoteEntity.receivedTime = receivedTime;
	}
	final String? note = jsonConvert.convert<String>(json['note']);
	if (note != null) {
		thankNoteEntity.note = note;
	}
	final int? value = jsonConvert.convert<int>(json['value']);
	if (value != null) {
		thankNoteEntity.value = value;
	}
	final String? fromGroup = jsonConvert.convert<String>(json['fromGroup']);
	if (fromGroup != null) {
		thankNoteEntity.fromGroup = fromGroup;
	}
	final String? toGroup = jsonConvert.convert<String>(json['toGroup']);
	if (toGroup != null) {
		thankNoteEntity.toGroup = toGroup;
	}
	return thankNoteEntity;
}

Map<String, dynamic> $ThankNoteEntityToJson(ThankNoteEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['fromUserId'] = entity.fromUserId;
	data['fromPicture'] = entity.fromPicture;
	data['fromGroupId'] = entity.fromGroupId;
	data['fromName'] = entity.fromName;
	data['toUserId'] = entity.toUserId;
	data['toPicture'] = entity.toPicture;
	data['toGroupId'] = entity.toGroupId;
	data['toName'] = entity.toName;
	data['thankYouNoteId'] = entity.thankYouNoteId;
	data['sendUser'] = entity.sendUser;
	data['receivedUser'] = entity.receivedUser;
	data['sendTime'] = entity.sendTime;
	data['receivedTime'] = entity.receivedTime;
	data['note'] = entity.note;
	data['value'] = entity.value;
	data['fromGroup'] = entity.fromGroup;
	data['toGroup'] = entity.toGroup;
	return data;
}