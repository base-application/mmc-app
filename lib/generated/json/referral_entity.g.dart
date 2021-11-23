import 'package:mmc/generated/json/base/json_convert_content.dart';
import 'package:mmc/bean/referral_entity.dart';
import 'package:mmc/bean/image_vo_entity.dart';


ReferralEntity $ReferralEntityFromJson(Map<String, dynamic> json) {
	ReferralEntity referralEntity = ReferralEntity();
	var fromPicture = jsonConvert.convert<String>(json['fromPicture']);
	if (fromPicture != null) {
		referralEntity.fromPicture = fromPicture;
	}
	var fromGroupId = jsonConvert.convert<int>(json['fromGroupId']);
	if (fromGroupId != null) {
		referralEntity.fromGroupId = fromGroupId;
	}
	var fromName = jsonConvert.convert<String>(json['fromName']);
	if (fromName != null) {
		referralEntity.fromName = fromName;
	}
	var fromGroup = jsonConvert.convert<String>(json['fromGroup']);
	if (fromGroup != null) {
		referralEntity.fromGroup = fromGroup;
	}
	var toPicture = jsonConvert.convert<String>(json['toPicture']);
	if (toPicture != null) {
		referralEntity.toPicture = toPicture;
	}
	var toGroupId = jsonConvert.convert<int>(json['toGroupId']);
	if (toGroupId != null) {
		referralEntity.toGroupId = toGroupId;
	}
	var toGroup = jsonConvert.convert<String>(json['toGroup']);
	if (toGroup != null) {
		referralEntity.toGroup = toGroup;
	}
	var toName = jsonConvert.convert<String>(json['toName']);
	if (toName != null) {
		referralEntity.toName = toName;
	}
	var referralId = jsonConvert.convert<int>(json['referralId']);
	if (referralId != null) {
		referralEntity.referralId = referralId;
	}
	var reason = jsonConvert.convert<String>(json['reason']);
	if (reason != null) {
		referralEntity.reason = reason;
	}
	var receivedUser = jsonConvert.convert<int>(json['receivedUser']);
	if (receivedUser != null) {
		referralEntity.receivedUser = receivedUser;
	}
	var sendUser = jsonConvert.convert<String>(json['sendUser']);
	if (sendUser != null) {
		referralEntity.sendUser = sendUser;
	}
	var failMessage = jsonConvert.convert<String>(json['failMessage']);
	if (failMessage != null) {
		referralEntity.failMessage = failMessage;
	}
	var sendTime = jsonConvert.convert<int>(json['sendTime']);
	if (sendTime != null) {
		referralEntity.sendTime = sendTime;
	}
	var receivedTime = jsonConvert.convert<int>(json['receivedTime']);
	if (receivedTime != null) {
		referralEntity.receivedTime = receivedTime;
	}
	var status = jsonConvert.convert<int>(json['status']);
	if (status != null) {
		referralEntity.status = status;
	}
	var remark = jsonConvert.convert<String>(json['remark']);
	if (remark != null) {
		referralEntity.remark = remark;
	}
	var thank = jsonConvert.convert<bool>(json['thank']);
	if (thank != null) {
		referralEntity.thank = thank;
	}
	var picture = jsonConvert.convertListNotNull<ImageVoEntity>(json['picture']);
	if (picture != null) {
		referralEntity.picture = picture;
	}
	return referralEntity;
}

Map<String, dynamic> $ReferralEntityToJson(ReferralEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['fromPicture'] = entity.fromPicture;
	data['fromGroupId'] = entity.fromGroupId;
	data['fromName'] = entity.fromName;
	data['fromGroup'] = entity.fromGroup;
	data['toPicture'] = entity.toPicture;
	data['toGroupId'] = entity.toGroupId;
	data['toGroup'] = entity.toGroup;
	data['toName'] = entity.toName;
	data['referralId'] = entity.referralId;
	data['reason'] = entity.reason;
	data['receivedUser'] = entity.receivedUser;
	data['sendUser'] = entity.sendUser;
	data['failMessage'] = entity.failMessage;
	data['sendTime'] = entity.sendTime;
	data['receivedTime'] = entity.receivedTime;
	data['status'] = entity.status;
	data['remark'] = entity.remark;
	data['thank'] = entity.thank;
	data['picture'] =  entity.picture?.map((v) => v.toJson()).toList();
	return data;
}