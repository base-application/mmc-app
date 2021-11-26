import 'package:mmc/generated/json/base/json_convert_content.dart';
import 'package:mmc/bean/thank_note_entity.dart';

ThankNoteEntity $ThankNoteEntityFromJson(Map<String, dynamic> json) {
	ThankNoteEntity thankNoteEntity = ThankNoteEntity();
	var fromUserId = jsonConvert.convert<int>(json['fromUserId']);
	if (fromUserId != null) {
		thankNoteEntity.fromUserId = fromUserId;
	}
	var fromPicture = jsonConvert.convert<String>(json['fromPicture']);
	if (fromPicture != null) {
		thankNoteEntity.fromPicture = fromPicture;
	}
	var fromGroupId = jsonConvert.convert<int>(json['fromGroupId']);
	if (fromGroupId != null) {
		thankNoteEntity.fromGroupId = fromGroupId;
	}
	var fromName = jsonConvert.convert<String>(json['fromName']);
	if (fromName != null) {
		thankNoteEntity.fromName = fromName;
	}
	var toUserId = jsonConvert.convert<int>(json['toUserId']);
	if (toUserId != null) {
		thankNoteEntity.toUserId = toUserId;
	}
	var toPicture = jsonConvert.convert<String>(json['toPicture']);
	if (toPicture != null) {
		thankNoteEntity.toPicture = toPicture;
	}
	var toGroupId = jsonConvert.convert<int>(json['toGroupId']);
	if (toGroupId != null) {
		thankNoteEntity.toGroupId = toGroupId;
	}
	var toName = jsonConvert.convert<String>(json['toName']);
	if (toName != null) {
		thankNoteEntity.toName = toName;
	}
	var thankYouNoteId = jsonConvert.convert<int>(json['thankYouNoteId']);
	if (thankYouNoteId != null) {
		thankNoteEntity.thankYouNoteId = thankYouNoteId;
	}
	var sendUser = jsonConvert.convert<int>(json['sendUser']);
	if (sendUser != null) {
		thankNoteEntity.sendUser = sendUser;
	}
	var receivedUser = jsonConvert.convert<int>(json['receivedUser']);
	if (receivedUser != null) {
		thankNoteEntity.receivedUser = receivedUser;
	}
	var sendTime = jsonConvert.convert<int>(json['sendTime']);
	if (sendTime != null) {
		thankNoteEntity.sendTime = sendTime;
	}
	var receivedTime = jsonConvert.convert<int>(json['receivedTime']);
	if (receivedTime != null) {
		thankNoteEntity.receivedTime = receivedTime;
	}
	var note = jsonConvert.convert<String>(json['note']);
	if (note != null) {
		thankNoteEntity.note = note;
	}
	var value = jsonConvert.convert<int>(json['value']);
	if (value != null) {
		thankNoteEntity.value = value;
	}
	var fromGroup = jsonConvert.convert<String>(json['fromGroup']);
	if (fromGroup != null) {
		thankNoteEntity.fromGroup = fromGroup;
	}
	var toGroup = jsonConvert.convert<String>(json['toGroup']);
	if (toGroup != null) {
		thankNoteEntity.toGroup = toGroup;
	}
	var picture = jsonConvert.convert<String>(json['picture']);
	if (picture != null) {
		thankNoteEntity.picture = picture;
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
	data['picture'] = entity.picture;
	return data;
}