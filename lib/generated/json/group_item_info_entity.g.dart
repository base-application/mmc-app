import 'package:mmc/generated/json/base/json_convert_content.dart';
import 'package:mmc/bean/group_item_info_entity.dart';

GroupItemInfoEntity $GroupItemInfoEntityFromJson(Map<String, dynamic> json) {
	final GroupItemInfoEntity groupItemInfoEntity = GroupItemInfoEntity();
	final int? groupId = jsonConvert.convert<int>(json['groupId']);
	if (groupId != null) {
		groupItemInfoEntity.groupId = groupId;
	}
	final String? groupName = jsonConvert.convert<String>(json['groupName']);
	if (groupName != null) {
		groupItemInfoEntity.groupName = groupName;
	}
	final int? thankYouNote = jsonConvert.convert<int>(json['thankYouNote']);
	if (thankYouNote != null) {
		groupItemInfoEntity.thankYouNote = thankYouNote;
	}
	final int? refer = jsonConvert.convert<int>(json['refer']);
	if (refer != null) {
		groupItemInfoEntity.refer = refer;
	}
	final List<GroupItemInfoUserInfoVos>? userInfoVos = jsonConvert.convertListNotNull<GroupItemInfoUserInfoVos>(json['userInfoVos']);
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
	final GroupItemInfoUserInfoVos groupItemInfoUserInfoVos = GroupItemInfoUserInfoVos();
	final int? userId = jsonConvert.convert<int>(json['userId']);
	if (userId != null) {
		groupItemInfoUserInfoVos.userId = userId;
	}
	final String? picture = jsonConvert.convert<String>(json['picture']);
	if (picture != null) {
		groupItemInfoUserInfoVos.picture = picture;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		groupItemInfoUserInfoVos.name = name;
	}
	final String? concatNumber = jsonConvert.convert<String>(json['concatNumber']);
	if (concatNumber != null) {
		groupItemInfoUserInfoVos.concatNumber = concatNumber;
	}
	final String? industry = jsonConvert.convert<String>(json['industry']);
	if (industry != null) {
		groupItemInfoUserInfoVos.industry = industry;
	}
	final int? country = jsonConvert.convert<int>(json['country']);
	if (country != null) {
		groupItemInfoUserInfoVos.country = country;
	}
	final int? state = jsonConvert.convert<int>(json['state']);
	if (state != null) {
		groupItemInfoUserInfoVos.state = state;
	}
	final int? birthday = jsonConvert.convert<int>(json['birthday']);
	if (birthday != null) {
		groupItemInfoUserInfoVos.birthday = birthday;
	}
	final String? occupation = jsonConvert.convert<String>(json['occupation']);
	if (occupation != null) {
		groupItemInfoUserInfoVos.occupation = occupation;
	}
	final String? introduction = jsonConvert.convert<String>(json['introduction']);
	if (introduction != null) {
		groupItemInfoUserInfoVos.introduction = introduction;
	}
	final String? whatsapp = jsonConvert.convert<String>(json['whatsapp']);
	if (whatsapp != null) {
		groupItemInfoUserInfoVos.whatsapp = whatsapp;
	}
	final String? facebook = jsonConvert.convert<String>(json['facebook']);
	if (facebook != null) {
		groupItemInfoUserInfoVos.facebook = facebook;
	}
	final String? linkedin = jsonConvert.convert<String>(json['linkedin']);
	if (linkedin != null) {
		groupItemInfoUserInfoVos.linkedin = linkedin;
	}
	final String? youtube = jsonConvert.convert<String>(json['youtube']);
	if (youtube != null) {
		groupItemInfoUserInfoVos.youtube = youtube;
	}
	final String? instagram = jsonConvert.convert<String>(json['instagram']);
	if (instagram != null) {
		groupItemInfoUserInfoVos.instagram = instagram;
	}
	final int? gradeId = jsonConvert.convert<int>(json['gradeId']);
	if (gradeId != null) {
		groupItemInfoUserInfoVos.gradeId = gradeId;
	}
	final String? gradeName = jsonConvert.convert<String>(json['gradeName']);
	if (gradeName != null) {
		groupItemInfoUserInfoVos.gradeName = gradeName;
	}
	final int? groupId = jsonConvert.convert<int>(json['groupId']);
	if (groupId != null) {
		groupItemInfoUserInfoVos.groupId = groupId;
	}
	final String? groupName = jsonConvert.convert<String>(json['groupName']);
	if (groupName != null) {
		groupItemInfoUserInfoVos.groupName = groupName;
	}
	final int? attendance = jsonConvert.convert<int>(json['attendance']);
	if (attendance != null) {
		groupItemInfoUserInfoVos.attendance = attendance;
	}
	final int? referralSend = jsonConvert.convert<int>(json['referralSend']);
	if (referralSend != null) {
		groupItemInfoUserInfoVos.referralSend = referralSend;
	}
	final int? referralReceived = jsonConvert.convert<int>(json['referralReceived']);
	if (referralReceived != null) {
		groupItemInfoUserInfoVos.referralReceived = referralReceived;
	}
	final int? thankYouNote = jsonConvert.convert<int>(json['thankYouNote']);
	if (thankYouNote != null) {
		groupItemInfoUserInfoVos.thankYouNote = thankYouNote;
	}
	final bool? enable = jsonConvert.convert<bool>(json['enable']);
	if (enable != null) {
		groupItemInfoUserInfoVos.enable = enable;
	}
	final int? positionId = jsonConvert.convert<int>(json['positionId']);
	if (positionId != null) {
		groupItemInfoUserInfoVos.positionId = positionId;
	}
	final String? positionName = jsonConvert.convert<String>(json['positionName']);
	if (positionName != null) {
		groupItemInfoUserInfoVos.positionName = positionName;
	}
	final String? member = jsonConvert.convert<String>(json['member']);
	if (member != null) {
		groupItemInfoUserInfoVos.member = member;
	}
	final List<GroupItemInfoUserInfoVosCompanyVos>? companyVos = jsonConvert.convertListNotNull<GroupItemInfoUserInfoVosCompanyVos>(json['companyVos']);
	if (companyVos != null) {
		groupItemInfoUserInfoVos.companyVos = companyVos;
	}
	final dynamic? achievement = jsonConvert.convert<dynamic>(json['achievement']);
	if (achievement != null) {
		groupItemInfoUserInfoVos.achievement = achievement;
	}
	final bool? friend = jsonConvert.convert<bool>(json['friend']);
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
	final GroupItemInfoUserInfoVosCompanyVos groupItemInfoUserInfoVosCompanyVos = GroupItemInfoUserInfoVosCompanyVos();
	final int? companyId = jsonConvert.convert<int>(json['companyId']);
	if (companyId != null) {
		groupItemInfoUserInfoVosCompanyVos.companyId = companyId;
	}
	final int? userId = jsonConvert.convert<int>(json['userId']);
	if (userId != null) {
		groupItemInfoUserInfoVosCompanyVos.userId = userId;
	}
	final dynamic? companyLogo = jsonConvert.convert<dynamic>(json['companyLogo']);
	if (companyLogo != null) {
		groupItemInfoUserInfoVosCompanyVos.companyLogo = companyLogo;
	}
	final String? companyName = jsonConvert.convert<String>(json['companyName']);
	if (companyName != null) {
		groupItemInfoUserInfoVosCompanyVos.companyName = companyName;
	}
	final dynamic? companyAddress = jsonConvert.convert<dynamic>(json['companyAddress']);
	if (companyAddress != null) {
		groupItemInfoUserInfoVosCompanyVos.companyAddress = companyAddress;
	}
	final dynamic? companyWebsite = jsonConvert.convert<dynamic>(json['companyWebsite']);
	if (companyWebsite != null) {
		groupItemInfoUserInfoVosCompanyVos.companyWebsite = companyWebsite;
	}
	final dynamic? companyEmail = jsonConvert.convert<dynamic>(json['companyEmail']);
	if (companyEmail != null) {
		groupItemInfoUserInfoVosCompanyVos.companyEmail = companyEmail;
	}
	final dynamic? companyPhone = jsonConvert.convert<dynamic>(json['companyPhone']);
	if (companyPhone != null) {
		groupItemInfoUserInfoVosCompanyVos.companyPhone = companyPhone;
	}
	final dynamic? companyFacebook = jsonConvert.convert<dynamic>(json['companyFacebook']);
	if (companyFacebook != null) {
		groupItemInfoUserInfoVosCompanyVos.companyFacebook = companyFacebook;
	}
	final dynamic? companyLinkedin = jsonConvert.convert<dynamic>(json['companyLinkedin']);
	if (companyLinkedin != null) {
		groupItemInfoUserInfoVosCompanyVos.companyLinkedin = companyLinkedin;
	}
	final dynamic? companyYoutube = jsonConvert.convert<dynamic>(json['companyYoutube']);
	if (companyYoutube != null) {
		groupItemInfoUserInfoVosCompanyVos.companyYoutube = companyYoutube;
	}
	final dynamic? companyInstagram = jsonConvert.convert<dynamic>(json['companyInstagram']);
	if (companyInstagram != null) {
		groupItemInfoUserInfoVosCompanyVos.companyInstagram = companyInstagram;
	}
	final dynamic? companyIntroduction = jsonConvert.convert<dynamic>(json['companyIntroduction']);
	if (companyIntroduction != null) {
		groupItemInfoUserInfoVosCompanyVos.companyIntroduction = companyIntroduction;
	}
	final dynamic? companyGoals = jsonConvert.convert<dynamic>(json['companyGoals']);
	if (companyGoals != null) {
		groupItemInfoUserInfoVosCompanyVos.companyGoals = companyGoals;
	}
	final dynamic? companyAccomplishments = jsonConvert.convert<dynamic>(json['companyAccomplishments']);
	if (companyAccomplishments != null) {
		groupItemInfoUserInfoVosCompanyVos.companyAccomplishments = companyAccomplishments;
	}
	final dynamic? companyInterests = jsonConvert.convert<dynamic>(json['companyInterests']);
	if (companyInterests != null) {
		groupItemInfoUserInfoVosCompanyVos.companyInterests = companyInterests;
	}
	final dynamic? serviceIntroduction = jsonConvert.convert<dynamic>(json['serviceIntroduction']);
	if (serviceIntroduction != null) {
		groupItemInfoUserInfoVosCompanyVos.serviceIntroduction = serviceIntroduction;
	}
	final List<GroupItemInfoUserInfoVosCompanyVosProducePictures>? producePictures = jsonConvert.convertListNotNull<GroupItemInfoUserInfoVosCompanyVosProducePictures>(json['producePictures']);
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
	final GroupItemInfoUserInfoVosCompanyVosProducePictures groupItemInfoUserInfoVosCompanyVosProducePictures = GroupItemInfoUserInfoVosCompanyVosProducePictures();
	final int? produceId = jsonConvert.convert<int>(json['produceId']);
	if (produceId != null) {
		groupItemInfoUserInfoVosCompanyVosProducePictures.produceId = produceId;
	}
	final String? producePicture = jsonConvert.convert<String>(json['producePicture']);
	if (producePicture != null) {
		groupItemInfoUserInfoVosCompanyVosProducePictures.producePicture = producePicture;
	}
	final int? companyId = jsonConvert.convert<int>(json['companyId']);
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