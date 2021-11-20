import 'package:mmc/generated/json/base/json_convert_content.dart';
import 'package:mmc/bean/network_item_info_entity.dart';

NetworkItemInfoEntity $NetworkItemInfoEntityFromJson(Map<String, dynamic> json) {
	NetworkItemInfoEntity networkItemInfoEntity = NetworkItemInfoEntity();
	var userId = jsonConvert.convert<int>(json['userId']);
	if (userId != null) {
		networkItemInfoEntity.userId = userId;
	}
	var picture = jsonConvert.convert<String>(json['picture']);
	if (picture != null) {
		networkItemInfoEntity.picture = picture;
	}
	var groupId = jsonConvert.convert<int>(json['groupId']);
	if (groupId != null) {
		networkItemInfoEntity.groupId = groupId;
	}
	var name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		networkItemInfoEntity.name = name;
	}
	var concatNumber = jsonConvert.convert<String>(json['concatNumber']);
	if (concatNumber != null) {
		networkItemInfoEntity.concatNumber = concatNumber;
	}
	var industry = jsonConvert.convert<String>(json['industry']);
	if (industry != null) {
		networkItemInfoEntity.industry = industry;
	}
	var country = jsonConvert.convert<int>(json['country']);
	if (country != null) {
		networkItemInfoEntity.country = country;
	}
	var state = jsonConvert.convert<int>(json['state']);
	if (state != null) {
		networkItemInfoEntity.state = state;
	}
	var birthday = jsonConvert.convert<int>(json['birthday']);
	if (birthday != null) {
		networkItemInfoEntity.birthday = birthday;
	}
	var occupation = jsonConvert.convert<String>(json['occupation']);
	if (occupation != null) {
		networkItemInfoEntity.occupation = occupation;
	}
	var introduction = jsonConvert.convert<String>(json['introduction']);
	if (introduction != null) {
		networkItemInfoEntity.introduction = introduction;
	}
	var whatsapp = jsonConvert.convert<String>(json['whatsapp']);
	if (whatsapp != null) {
		networkItemInfoEntity.whatsapp = whatsapp;
	}
	var facebook = jsonConvert.convert<String>(json['facebook']);
	if (facebook != null) {
		networkItemInfoEntity.facebook = facebook;
	}
	var linkedin = jsonConvert.convert<String>(json['linkedin']);
	if (linkedin != null) {
		networkItemInfoEntity.linkedin = linkedin;
	}
	var youtube = jsonConvert.convert<String>(json['youtube']);
	if (youtube != null) {
		networkItemInfoEntity.youtube = youtube;
	}
	var instagram = jsonConvert.convert<String>(json['instagram']);
	if (instagram != null) {
		networkItemInfoEntity.instagram = instagram;
	}
	var gradeId = jsonConvert.convert<int>(json['gradeId']);
	if (gradeId != null) {
		networkItemInfoEntity.gradeId = gradeId;
	}
	var gradeName = jsonConvert.convert<String>(json['gradeName']);
	if (gradeName != null) {
		networkItemInfoEntity.gradeName = gradeName;
	}
	var attendance = jsonConvert.convert<double>(json['attendance']);
	if (attendance != null) {
		networkItemInfoEntity.attendance = attendance;
	}
	var referralSend = jsonConvert.convert<int>(json['referralSend']);
	if (referralSend != null) {
		networkItemInfoEntity.referralSend = referralSend;
	}
	var referralReceived = jsonConvert.convert<int>(json['referralReceived']);
	if (referralReceived != null) {
		networkItemInfoEntity.referralReceived = referralReceived;
	}
	var thankUouNote = jsonConvert.convert<int>(json['thankUouNote']);
	if (thankUouNote != null) {
		networkItemInfoEntity.thankUouNote = thankUouNote;
	}
	var enable = jsonConvert.convert<bool>(json['enable']);
	if (enable != null) {
		networkItemInfoEntity.enable = enable;
	}
	var isFriend = jsonConvert.convert<bool>(json['isFriend']);
	if (isFriend != null) {
		networkItemInfoEntity.isFriend = isFriend;
	}
	return networkItemInfoEntity;
}

Map<String, dynamic> $NetworkItemInfoEntityToJson(NetworkItemInfoEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['userId'] = entity.userId;
	data['picture'] = entity.picture;
	data['groupId'] = entity.groupId;
	data['name'] = entity.name;
	data['concatNumber'] = entity.concatNumber;
	data['industry'] = entity.industry;
	data['country'] = entity.country;
	data['state'] = entity.state;
	data['birthday'] = entity.birthday;
	data['occupation'] = entity.occupation;
	data['introduction'] = entity.introduction;
	data['whatsapp'] = entity.whatsapp;
	data['facebook'] = entity.facebook;
	data['linkedin'] = entity.linkedin;
	data['youtube'] = entity.youtube;
	data['instagram'] = entity.instagram;
	data['gradeId'] = entity.gradeId;
	data['gradeName'] = entity.gradeName;
	data['attendance'] = entity.attendance;
	data['referralSend'] = entity.referralSend;
	data['referralReceived'] = entity.referralReceived;
	data['thankUouNote'] = entity.thankUouNote;
	data['enable'] = entity.enable;
	data['isFriend'] = entity.isFriend;
	return data;
}