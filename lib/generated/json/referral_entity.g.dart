import 'package:mmc/generated/json/base/json_convert_content.dart';
import 'package:mmc/bean/referral_entity.dart';
import 'package:mmc/bean/image_vo_entity.dart';


ReferralEntity $ReferralEntityFromJson(Map<String, dynamic> json) {
	final ReferralEntity referralEntity = ReferralEntity();
	final String? fromPicture = jsonConvert.convert<String>(json['fromPicture']);
	if (fromPicture != null) {
		referralEntity.fromPicture = fromPicture;
	}
	final int? fromGroupId = jsonConvert.convert<int>(json['fromGroupId']);
	if (fromGroupId != null) {
		referralEntity.fromGroupId = fromGroupId;
	}
	final String? fromName = jsonConvert.convert<String>(json['fromName']);
	if (fromName != null) {
		referralEntity.fromName = fromName;
	}
	final String? fromGroup = jsonConvert.convert<String>(json['fromGroup']);
	if (fromGroup != null) {
		referralEntity.fromGroup = fromGroup;
	}
	final String? toPicture = jsonConvert.convert<String>(json['toPicture']);
	if (toPicture != null) {
		referralEntity.toPicture = toPicture;
	}
	final int? toGroupId = jsonConvert.convert<int>(json['toGroupId']);
	if (toGroupId != null) {
		referralEntity.toGroupId = toGroupId;
	}
	final String? toGroup = jsonConvert.convert<String>(json['toGroup']);
	if (toGroup != null) {
		referralEntity.toGroup = toGroup;
	}
	final String? toName = jsonConvert.convert<String>(json['toName']);
	if (toName != null) {
		referralEntity.toName = toName;
	}
	final int? referralId = jsonConvert.convert<int>(json['referralId']);
	if (referralId != null) {
		referralEntity.referralId = referralId;
	}
	final String? reason = jsonConvert.convert<String>(json['reason']);
	if (reason != null) {
		referralEntity.reason = reason;
	}
	final int? receivedUser = jsonConvert.convert<int>(json['receivedUser']);
	if (receivedUser != null) {
		referralEntity.receivedUser = receivedUser;
	}
	final String? sendUser = jsonConvert.convert<String>(json['sendUser']);
	if (sendUser != null) {
		referralEntity.sendUser = sendUser;
	}
	final String? failMessage = jsonConvert.convert<String>(json['failMessage']);
	if (failMessage != null) {
		referralEntity.failMessage = failMessage;
	}
	final int? sendTime = jsonConvert.convert<int>(json['sendTime']);
	if (sendTime != null) {
		referralEntity.sendTime = sendTime;
	}
	final int? receivedTime = jsonConvert.convert<int>(json['receivedTime']);
	if (receivedTime != null) {
		referralEntity.receivedTime = receivedTime;
	}
	final int? status = jsonConvert.convert<int>(json['status']);
	if (status != null) {
		referralEntity.status = status;
	}
	final String? remark = jsonConvert.convert<String>(json['remark']);
	if (remark != null) {
		referralEntity.remark = remark;
	}
	final bool? thank = jsonConvert.convert<bool>(json['thank']);
	if (thank != null) {
		referralEntity.thank = thank;
	}
	final List<ImageVoEntity>? picture = jsonConvert.convertListNotNull<ImageVoEntity>(json['picture']);
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