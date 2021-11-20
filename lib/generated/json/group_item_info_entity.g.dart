import 'package:mmc/generated/json/base/json_convert_content.dart';
import 'package:mmc/bean/group_item_info_entity.dart';

GroupItemInfoEntity $GroupItemInfoEntityFromJson(Map<String, dynamic> json) {
	GroupItemInfoEntity groupItemInfoEntity = GroupItemInfoEntity();
	var groupId = jsonConvert.convert<int>(json['groupId']);
	if (groupId != null) {
		groupItemInfoEntity.groupId = groupId;
	}
	var groupName = jsonConvert.convert<String>(json['groupName']);
	if (groupName != null) {
		groupItemInfoEntity.groupName = groupName;
	}
	var thankYouNote = jsonConvert.convert<int>(json['thankYouNote']);
	if (thankYouNote != null) {
		groupItemInfoEntity.thankYouNote = thankYouNote;
	}
	var refer = jsonConvert.convert<int>(json['refer']);
	if (refer != null) {
		groupItemInfoEntity.refer = refer;
	}
	var userInfoVos = jsonConvert.convertListNotNull<GroupItemInfoUserInfoVos>(json['userInfoVos']);
	if (userInfoVos != null) {
		groupItemInfoEntity.userInfoVos = userInfoVos;
	}
	return groupItemInfoEntity;
}

Map<String, dynamic> $GroupItemInfoEntityToJson(GroupItemInfoEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['groupId'] = entity.groupId;
	data['groupName'] = entity.groupName;
	data['thankYouNote'] = entity.thankYouNote;
	data['refer'] = entity.refer;
	data['userInfoVos'] =  entity.userInfoVos?.map((v) => v.toJson()).toList();
	return data;
}

GroupItemInfoUserInfoVos $GroupItemInfoUserInfoVosFromJson(Map<String, dynamic> json) {
	GroupItemInfoUserInfoVos groupItemInfoUserInfoVos = GroupItemInfoUserInfoVos();
	var userId = jsonConvert.convert<int>(json['userId']);
	if (userId != null) {
		groupItemInfoUserInfoVos.userId = userId;
	}
	var picture = jsonConvert.convert<String>(json['picture']);
	if (picture != null) {
		groupItemInfoUserInfoVos.picture = picture;
	}
	var name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		groupItemInfoUserInfoVos.name = name;
	}
	var concatNumber = jsonConvert.convert<String>(json['concatNumber']);
	if (concatNumber != null) {
		groupItemInfoUserInfoVos.concatNumber = concatNumber;
	}
	var industry = jsonConvert.convert<String>(json['industry']);
	if (industry != null) {
		groupItemInfoUserInfoVos.industry = industry;
	}
	var country = jsonConvert.convert<int>(json['country']);
	if (country != null) {
		groupItemInfoUserInfoVos.country = country;
	}
	var state = jsonConvert.convert<int>(json['state']);
	if (state != null) {
		groupItemInfoUserInfoVos.state = state;
	}
	var birthday = jsonConvert.convert<int>(json['birthday']);
	if (birthday != null) {
		groupItemInfoUserInfoVos.birthday = birthday;
	}
	var occupation = jsonConvert.convert<String>(json['occupation']);
	if (occupation != null) {
		groupItemInfoUserInfoVos.occupation = occupation;
	}
	var introduction = jsonConvert.convert<String>(json['introduction']);
	if (introduction != null) {
		groupItemInfoUserInfoVos.introduction = introduction;
	}
	var whatsapp = jsonConvert.convert<String>(json['whatsapp']);
	if (whatsapp != null) {
		groupItemInfoUserInfoVos.whatsapp = whatsapp;
	}
	var facebook = jsonConvert.convert<String>(json['facebook']);
	if (facebook != null) {
		groupItemInfoUserInfoVos.facebook = facebook;
	}
	var linkedin = jsonConvert.convert<String>(json['linkedin']);
	if (linkedin != null) {
		groupItemInfoUserInfoVos.linkedin = linkedin;
	}
	var youtube = jsonConvert.convert<String>(json['youtube']);
	if (youtube != null) {
		groupItemInfoUserInfoVos.youtube = youtube;
	}
	var instagram = jsonConvert.convert<String>(json['instagram']);
	if (instagram != null) {
		groupItemInfoUserInfoVos.instagram = instagram;
	}
	var gradeId = jsonConvert.convert<int>(json['gradeId']);
	if (gradeId != null) {
		groupItemInfoUserInfoVos.gradeId = gradeId;
	}
	var gradeName = jsonConvert.convert<String>(json['gradeName']);
	if (gradeName != null) {
		groupItemInfoUserInfoVos.gradeName = gradeName;
	}
	var groupId = jsonConvert.convert<int>(json['groupId']);
	if (groupId != null) {
		groupItemInfoUserInfoVos.groupId = groupId;
	}
	var groupName = jsonConvert.convert<String>(json['groupName']);
	if (groupName != null) {
		groupItemInfoUserInfoVos.groupName = groupName;
	}
	var attendance = jsonConvert.convert<int>(json['attendance']);
	if (attendance != null) {
		groupItemInfoUserInfoVos.attendance = attendance;
	}
	var referralSend = jsonConvert.convert<int>(json['referralSend']);
	if (referralSend != null) {
		groupItemInfoUserInfoVos.referralSend = referralSend;
	}
	var referralReceived = jsonConvert.convert<int>(json['referralReceived']);
	if (referralReceived != null) {
		groupItemInfoUserInfoVos.referralReceived = referralReceived;
	}
	var thankYouNote = jsonConvert.convert<int>(json['thankYouNote']);
	if (thankYouNote != null) {
		groupItemInfoUserInfoVos.thankYouNote = thankYouNote;
	}
	var enable = jsonConvert.convert<bool>(json['enable']);
	if (enable != null) {
		groupItemInfoUserInfoVos.enable = enable;
	}
	var positionId = jsonConvert.convert<int>(json['positionId']);
	if (positionId != null) {
		groupItemInfoUserInfoVos.positionId = positionId;
	}
	var positionName = jsonConvert.convert<String>(json['positionName']);
	if (positionName != null) {
		groupItemInfoUserInfoVos.positionName = positionName;
	}
	var member = jsonConvert.convert<String>(json['member']);
	if (member != null) {
		groupItemInfoUserInfoVos.member = member;
	}
	var companyVos = jsonConvert.convertListNotNull<GroupItemInfoUserInfoVosCompanyVos>(json['companyVos']);
	if (companyVos != null) {
		groupItemInfoUserInfoVos.companyVos = companyVos;
	}
	var achievement = jsonConvert.convert<dynamic>(json['achievement']);
	if (achievement != null) {
		groupItemInfoUserInfoVos.achievement = achievement;
	}
	var friend = jsonConvert.convert<bool>(json['friend']);
	if (friend != null) {
		groupItemInfoUserInfoVos.friend = friend;
	}
	return groupItemInfoUserInfoVos;
}

Map<String, dynamic> $GroupItemInfoUserInfoVosToJson(GroupItemInfoUserInfoVos entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['userId'] = entity.userId;
	data['picture'] = entity.picture;
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
	data['groupId'] = entity.groupId;
	data['groupName'] = entity.groupName;
	data['attendance'] = entity.attendance;
	data['referralSend'] = entity.referralSend;
	data['referralReceived'] = entity.referralReceived;
	data['thankYouNote'] = entity.thankYouNote;
	data['enable'] = entity.enable;
	data['positionId'] = entity.positionId;
	data['positionName'] = entity.positionName;
	data['member'] = entity.member;
	data['companyVos'] =  entity.companyVos?.map((v) => v.toJson()).toList();
	data['achievement'] = entity.achievement;
	data['friend'] = entity.friend;
	return data;
}

GroupItemInfoUserInfoVosCompanyVos $GroupItemInfoUserInfoVosCompanyVosFromJson(Map<String, dynamic> json) {
	GroupItemInfoUserInfoVosCompanyVos groupItemInfoUserInfoVosCompanyVos = GroupItemInfoUserInfoVosCompanyVos();
	var companyId = jsonConvert.convert<int>(json['companyId']);
	if (companyId != null) {
		groupItemInfoUserInfoVosCompanyVos.companyId = companyId;
	}
	var userId = jsonConvert.convert<int>(json['userId']);
	if (userId != null) {
		groupItemInfoUserInfoVosCompanyVos.userId = userId;
	}
	var companyLogo = jsonConvert.convert<dynamic>(json['companyLogo']);
	if (companyLogo != null) {
		groupItemInfoUserInfoVosCompanyVos.companyLogo = companyLogo;
	}
	var companyName = jsonConvert.convert<String>(json['companyName']);
	if (companyName != null) {
		groupItemInfoUserInfoVosCompanyVos.companyName = companyName;
	}
	var companyAddress = jsonConvert.convert<dynamic>(json['companyAddress']);
	if (companyAddress != null) {
		groupItemInfoUserInfoVosCompanyVos.companyAddress = companyAddress;
	}
	var companyWebsite = jsonConvert.convert<dynamic>(json['companyWebsite']);
	if (companyWebsite != null) {
		groupItemInfoUserInfoVosCompanyVos.companyWebsite = companyWebsite;
	}
	var companyEmail = jsonConvert.convert<dynamic>(json['companyEmail']);
	if (companyEmail != null) {
		groupItemInfoUserInfoVosCompanyVos.companyEmail = companyEmail;
	}
	var companyPhone = jsonConvert.convert<dynamic>(json['companyPhone']);
	if (companyPhone != null) {
		groupItemInfoUserInfoVosCompanyVos.companyPhone = companyPhone;
	}
	var companyFacebook = jsonConvert.convert<dynamic>(json['companyFacebook']);
	if (companyFacebook != null) {
		groupItemInfoUserInfoVosCompanyVos.companyFacebook = companyFacebook;
	}
	var companyLinkedin = jsonConvert.convert<dynamic>(json['companyLinkedin']);
	if (companyLinkedin != null) {
		groupItemInfoUserInfoVosCompanyVos.companyLinkedin = companyLinkedin;
	}
	var companyYoutube = jsonConvert.convert<dynamic>(json['companyYoutube']);
	if (companyYoutube != null) {
		groupItemInfoUserInfoVosCompanyVos.companyYoutube = companyYoutube;
	}
	var companyInstagram = jsonConvert.convert<dynamic>(json['companyInstagram']);
	if (companyInstagram != null) {
		groupItemInfoUserInfoVosCompanyVos.companyInstagram = companyInstagram;
	}
	var companyIntroduction = jsonConvert.convert<dynamic>(json['companyIntroduction']);
	if (companyIntroduction != null) {
		groupItemInfoUserInfoVosCompanyVos.companyIntroduction = companyIntroduction;
	}
	var companyGoals = jsonConvert.convert<dynamic>(json['companyGoals']);
	if (companyGoals != null) {
		groupItemInfoUserInfoVosCompanyVos.companyGoals = companyGoals;
	}
	var companyAccomplishments = jsonConvert.convert<dynamic>(json['companyAccomplishments']);
	if (companyAccomplishments != null) {
		groupItemInfoUserInfoVosCompanyVos.companyAccomplishments = companyAccomplishments;
	}
	var companyInterests = jsonConvert.convert<dynamic>(json['companyInterests']);
	if (companyInterests != null) {
		groupItemInfoUserInfoVosCompanyVos.companyInterests = companyInterests;
	}
	var serviceIntroduction = jsonConvert.convert<dynamic>(json['serviceIntroduction']);
	if (serviceIntroduction != null) {
		groupItemInfoUserInfoVosCompanyVos.serviceIntroduction = serviceIntroduction;
	}
	var producePictures = jsonConvert.convertListNotNull<GroupItemInfoUserInfoVosCompanyVosProducePictures>(json['producePictures']);
	if (producePictures != null) {
		groupItemInfoUserInfoVosCompanyVos.producePictures = producePictures;
	}
	return groupItemInfoUserInfoVosCompanyVos;
}

Map<String, dynamic> $GroupItemInfoUserInfoVosCompanyVosToJson(GroupItemInfoUserInfoVosCompanyVos entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['companyId'] = entity.companyId;
	data['userId'] = entity.userId;
	data['companyLogo'] = entity.companyLogo;
	data['companyName'] = entity.companyName;
	data['companyAddress'] = entity.companyAddress;
	data['companyWebsite'] = entity.companyWebsite;
	data['companyEmail'] = entity.companyEmail;
	data['companyPhone'] = entity.companyPhone;
	data['companyFacebook'] = entity.companyFacebook;
	data['companyLinkedin'] = entity.companyLinkedin;
	data['companyYoutube'] = entity.companyYoutube;
	data['companyInstagram'] = entity.companyInstagram;
	data['companyIntroduction'] = entity.companyIntroduction;
	data['companyGoals'] = entity.companyGoals;
	data['companyAccomplishments'] = entity.companyAccomplishments;
	data['companyInterests'] = entity.companyInterests;
	data['serviceIntroduction'] = entity.serviceIntroduction;
	data['producePictures'] =  entity.producePictures?.map((v) => v.toJson()).toList();
	return data;
}

GroupItemInfoUserInfoVosCompanyVosProducePictures $GroupItemInfoUserInfoVosCompanyVosProducePicturesFromJson(Map<String, dynamic> json) {
	GroupItemInfoUserInfoVosCompanyVosProducePictures groupItemInfoUserInfoVosCompanyVosProducePictures = GroupItemInfoUserInfoVosCompanyVosProducePictures();
	var produceId = jsonConvert.convert<int>(json['produceId']);
	if (produceId != null) {
		groupItemInfoUserInfoVosCompanyVosProducePictures.produceId = produceId;
	}
	var producePicture = jsonConvert.convert<String>(json['producePicture']);
	if (producePicture != null) {
		groupItemInfoUserInfoVosCompanyVosProducePictures.producePicture = producePicture;
	}
	var companyId = jsonConvert.convert<int>(json['companyId']);
	if (companyId != null) {
		groupItemInfoUserInfoVosCompanyVosProducePictures.companyId = companyId;
	}
	return groupItemInfoUserInfoVosCompanyVosProducePictures;
}

Map<String, dynamic> $GroupItemInfoUserInfoVosCompanyVosProducePicturesToJson(GroupItemInfoUserInfoVosCompanyVosProducePictures entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['produceId'] = entity.produceId;
	data['producePicture'] = entity.producePicture;
	data['companyId'] = entity.companyId;
	return data;
}