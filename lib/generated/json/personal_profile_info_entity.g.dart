import 'package:mmc/generated/json/base/json_convert_content.dart';
import 'package:mmc/bean/personal_profile_info_entity.dart';

PersonalProfileInfoEntity $PersonalProfileInfoEntityFromJson(Map<String, dynamic> json) {
	PersonalProfileInfoEntity personalProfileInfoEntity = PersonalProfileInfoEntity();
	var userId = jsonConvert.convert<int>(json['userId']);
	if (userId != null) {
		personalProfileInfoEntity.userId = userId;
	}
	var picture = jsonConvert.convert<String>(json['picture']);
	if (picture != null) {
		personalProfileInfoEntity.picture = picture;
	}
	var name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		personalProfileInfoEntity.name = name;
	}
	var concatNumber = jsonConvert.convert<String>(json['concatNumber']);
	if (concatNumber != null) {
		personalProfileInfoEntity.concatNumber = concatNumber;
	}
	var industry = jsonConvert.convert<String>(json['industry']);
	if (industry != null) {
		personalProfileInfoEntity.industry = industry;
	}
	var country = jsonConvert.convert<int>(json['country']);
	if (country != null) {
		personalProfileInfoEntity.country = country;
	}
	var state = jsonConvert.convert<int>(json['state']);
	if (state != null) {
		personalProfileInfoEntity.state = state;
	}
	var birthday = jsonConvert.convert<int>(json['birthday']);
	if (birthday != null) {
		personalProfileInfoEntity.birthday = birthday;
	}
	var occupation = jsonConvert.convert<String>(json['occupation']);
	if (occupation != null) {
		personalProfileInfoEntity.occupation = occupation;
	}
	var introduction = jsonConvert.convert<String>(json['introduction']);
	if (introduction != null) {
		personalProfileInfoEntity.introduction = introduction;
	}
	var whatsapp = jsonConvert.convert<String>(json['whatsapp']);
	if (whatsapp != null) {
		personalProfileInfoEntity.whatsapp = whatsapp;
	}
	var facebook = jsonConvert.convert<String>(json['facebook']);
	if (facebook != null) {
		personalProfileInfoEntity.facebook = facebook;
	}
	var linkedin = jsonConvert.convert<String>(json['linkedin']);
	if (linkedin != null) {
		personalProfileInfoEntity.linkedin = linkedin;
	}
	var youtube = jsonConvert.convert<String>(json['youtube']);
	if (youtube != null) {
		personalProfileInfoEntity.youtube = youtube;
	}
	var instagram = jsonConvert.convert<String>(json['instagram']);
	if (instagram != null) {
		personalProfileInfoEntity.instagram = instagram;
	}
	var gradeId = jsonConvert.convert<int>(json['gradeId']);
	if (gradeId != null) {
		personalProfileInfoEntity.gradeId = gradeId;
	}
	var gradeName = jsonConvert.convert<String>(json['gradeName']);
	if (gradeName != null) {
		personalProfileInfoEntity.gradeName = gradeName;
	}
	var groupId = jsonConvert.convert<int>(json['groupId']);
	if (groupId != null) {
		personalProfileInfoEntity.groupId = groupId;
	}
	var groupName = jsonConvert.convert<String>(json['groupName']);
	if (groupName != null) {
		personalProfileInfoEntity.groupName = groupName;
	}
	var attendance = jsonConvert.convert<int>(json['attendance']);
	if (attendance != null) {
		personalProfileInfoEntity.attendance = attendance;
	}
	var referralSend = jsonConvert.convert<int>(json['referralSend']);
	if (referralSend != null) {
		personalProfileInfoEntity.referralSend = referralSend;
	}
	var referralReceived = jsonConvert.convert<int>(json['referralReceived']);
	if (referralReceived != null) {
		personalProfileInfoEntity.referralReceived = referralReceived;
	}
	var thankYouNote = jsonConvert.convert<int>(json['thankYouNote']);
	if (thankYouNote != null) {
		personalProfileInfoEntity.thankYouNote = thankYouNote;
	}
	var enable = jsonConvert.convert<bool>(json['enable']);
	if (enable != null) {
		personalProfileInfoEntity.enable = enable;
	}
	var positionId = jsonConvert.convert<int>(json['positionId']);
	if (positionId != null) {
		personalProfileInfoEntity.positionId = positionId;
	}
	var positionName = jsonConvert.convert<String>(json['positionName']);
	if (positionName != null) {
		personalProfileInfoEntity.positionName = positionName;
	}
	var member = jsonConvert.convert<dynamic>(json['member']);
	if (member != null) {
		personalProfileInfoEntity.member = member;
	}
	var companyVos = jsonConvert.convertListNotNull<PersonalProfileInfoCompanyVos>(json['companyVos']);
	if (companyVos != null) {
		personalProfileInfoEntity.companyVos = companyVos;
	}
	var achievement = jsonConvert.convert<dynamic>(json['achievement']);
	if (achievement != null) {
		personalProfileInfoEntity.achievement = achievement;
	}
	var friend = jsonConvert.convert<dynamic>(json['friend']);
	if (friend != null) {
		personalProfileInfoEntity.friend = friend;
	}
	return personalProfileInfoEntity;
}

Map<String, dynamic> $PersonalProfileInfoEntityToJson(PersonalProfileInfoEntity entity) {
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
	data['companyVos'] =  entity.companyVos.map((v) => v.toJson()).toList();
	data['achievement'] = entity.achievement;
	data['friend'] = entity.friend;
	return data;
}

PersonalProfileInfoCompanyVos $PersonalProfileInfoCompanyVosFromJson(Map<String, dynamic> json) {
	PersonalProfileInfoCompanyVos personalProfileInfoCompanyVos = PersonalProfileInfoCompanyVos();
	var companyId = jsonConvert.convert<int>(json['companyId']);
	if (companyId != null) {
		personalProfileInfoCompanyVos.companyId = companyId;
	}
	var userId = jsonConvert.convert<int>(json['userId']);
	if (userId != null) {
		personalProfileInfoCompanyVos.userId = userId;
	}
	var companyLogo = jsonConvert.convert<String>(json['companyLogo']);
	if (companyLogo != null) {
		personalProfileInfoCompanyVos.companyLogo = companyLogo;
	}
	var companyName = jsonConvert.convert<String>(json['companyName']);
	if (companyName != null) {
		personalProfileInfoCompanyVos.companyName = companyName;
	}
	var companyAddress = jsonConvert.convert<String>(json['companyAddress']);
	if (companyAddress != null) {
		personalProfileInfoCompanyVos.companyAddress = companyAddress;
	}
	var city = jsonConvert.convert<String>(json['city']);
	if (city != null) {
		personalProfileInfoCompanyVos.city = city;
	}
	var postCode = jsonConvert.convert<String>(json['postCode']);
	if (postCode != null) {
		personalProfileInfoCompanyVos.postCode = postCode;
	}
	var companyWebsite = jsonConvert.convert<String>(json['companyWebsite']);
	if (companyWebsite != null) {
		personalProfileInfoCompanyVos.companyWebsite = companyWebsite;
	}
	var companyWhatsapp = jsonConvert.convert<String>(json['companyWhatsapp']);
	if (companyWhatsapp != null) {
		personalProfileInfoCompanyVos.companyWhatsapp = companyWhatsapp;
	}
	var companyEmail = jsonConvert.convert<String>(json['companyEmail']);
	if (companyEmail != null) {
		personalProfileInfoCompanyVos.companyEmail = companyEmail;
	}
	var companyPhone = jsonConvert.convert<String>(json['companyPhone']);
	if (companyPhone != null) {
		personalProfileInfoCompanyVos.companyPhone = companyPhone;
	}
	var companyFacebook = jsonConvert.convert<String>(json['companyFacebook']);
	if (companyFacebook != null) {
		personalProfileInfoCompanyVos.companyFacebook = companyFacebook;
	}
	var companyLinkedin = jsonConvert.convert<String>(json['companyLinkedin']);
	if (companyLinkedin != null) {
		personalProfileInfoCompanyVos.companyLinkedin = companyLinkedin;
	}
	var companyYoutube = jsonConvert.convert<String>(json['companyYoutube']);
	if (companyYoutube != null) {
		personalProfileInfoCompanyVos.companyYoutube = companyYoutube;
	}
	var companyInstagram = jsonConvert.convert<String>(json['companyInstagram']);
	if (companyInstagram != null) {
		personalProfileInfoCompanyVos.companyInstagram = companyInstagram;
	}
	var companyIntroduction = jsonConvert.convert<String>(json['companyIntroduction']);
	if (companyIntroduction != null) {
		personalProfileInfoCompanyVos.companyIntroduction = companyIntroduction;
	}
	var companyGoals = jsonConvert.convert<String>(json['companyGoals']);
	if (companyGoals != null) {
		personalProfileInfoCompanyVos.companyGoals = companyGoals;
	}
	var companyAccomplishments = jsonConvert.convert<String>(json['companyAccomplishments']);
	if (companyAccomplishments != null) {
		personalProfileInfoCompanyVos.companyAccomplishments = companyAccomplishments;
	}
	var companyInterests = jsonConvert.convert<String>(json['companyInterests']);
	if (companyInterests != null) {
		personalProfileInfoCompanyVos.companyInterests = companyInterests;
	}
	var serviceIntroduction = jsonConvert.convert<String>(json['serviceIntroduction']);
	if (serviceIntroduction != null) {
		personalProfileInfoCompanyVos.serviceIntroduction = serviceIntroduction;
	}
	var producePictures = jsonConvert.convertListNotNull<PersonalProfileInfoCompanyVosProducePictures>(json['producePictures']);
	if (producePictures != null) {
		personalProfileInfoCompanyVos.producePictures = producePictures;
	}
	return personalProfileInfoCompanyVos;
}

Map<String, dynamic> $PersonalProfileInfoCompanyVosToJson(PersonalProfileInfoCompanyVos entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['companyId'] = entity.companyId;
	data['userId'] = entity.userId;
	data['companyLogo'] = entity.companyLogo;
	data['companyName'] = entity.companyName;
	data['companyAddress'] = entity.companyAddress;
	data['city'] = entity.city;
	data['postCode'] = entity.postCode;
	data['companyWebsite'] = entity.companyWebsite;
	data['companyWhatsapp'] = entity.companyWhatsapp;
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
	data['producePictures'] =  entity.producePictures.map((v) => v.toJson()).toList();
	return data;
}

PersonalProfileInfoCompanyVosProducePictures $PersonalProfileInfoCompanyVosProducePicturesFromJson(Map<String, dynamic> json) {
	PersonalProfileInfoCompanyVosProducePictures personalProfileInfoCompanyVosProducePictures = PersonalProfileInfoCompanyVosProducePictures();
	var produceId = jsonConvert.convert<int>(json['produceId']);
	if (produceId != null) {
		personalProfileInfoCompanyVosProducePictures.produceId = produceId;
	}
	var producePicture = jsonConvert.convert<String>(json['producePicture']);
	if (producePicture != null) {
		personalProfileInfoCompanyVosProducePictures.producePicture = producePicture;
	}
	var companyId = jsonConvert.convert<int>(json['companyId']);
	if (companyId != null) {
		personalProfileInfoCompanyVosProducePictures.companyId = companyId;
	}
	return personalProfileInfoCompanyVosProducePictures;
}

Map<String, dynamic> $PersonalProfileInfoCompanyVosProducePicturesToJson(PersonalProfileInfoCompanyVosProducePictures entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['produceId'] = entity.produceId;
	data['producePicture'] = entity.producePicture;
	data['companyId'] = entity.companyId;
	return data;
}