import 'package:mmc/generated/json/base/json_convert_content.dart';
import 'package:mmc/bean/personal_profile_info_entity.dart';
import 'package:mmc/bean/achievement_entity.dart';


PersonalProfileInfoEntity $PersonalProfileInfoEntityFromJson(Map<String, dynamic> json) {
	final PersonalProfileInfoEntity personalProfileInfoEntity = PersonalProfileInfoEntity();
	final int? userId = jsonConvert.convert<int>(json['userId']);
	if (userId != null) {
		personalProfileInfoEntity.userId = userId;
	}
	final String? picture = jsonConvert.convert<String>(json['picture']);
	if (picture != null) {
		personalProfileInfoEntity.picture = picture;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		personalProfileInfoEntity.name = name;
	}
	final String? concatNumber = jsonConvert.convert<String>(json['concatNumber']);
	if (concatNumber != null) {
		personalProfileInfoEntity.concatNumber = concatNumber;
	}
	final String? industry = jsonConvert.convert<String>(json['industry']);
	if (industry != null) {
		personalProfileInfoEntity.industry = industry;
	}
	final int? country = jsonConvert.convert<int>(json['country']);
	if (country != null) {
		personalProfileInfoEntity.country = country;
	}
	final int? state = jsonConvert.convert<int>(json['state']);
	if (state != null) {
		personalProfileInfoEntity.state = state;
	}
	final int? birthday = jsonConvert.convert<int>(json['birthday']);
	if (birthday != null) {
		personalProfileInfoEntity.birthday = birthday;
	}
	final String? occupation = jsonConvert.convert<String>(json['occupation']);
	if (occupation != null) {
		personalProfileInfoEntity.occupation = occupation;
	}
	final String? introduction = jsonConvert.convert<String>(json['introduction']);
	if (introduction != null) {
		personalProfileInfoEntity.introduction = introduction;
	}
	final String? whatsapp = jsonConvert.convert<String>(json['whatsapp']);
	if (whatsapp != null) {
		personalProfileInfoEntity.whatsapp = whatsapp;
	}
	final String? facebook = jsonConvert.convert<String>(json['facebook']);
	if (facebook != null) {
		personalProfileInfoEntity.facebook = facebook;
	}
	final String? linkedin = jsonConvert.convert<String>(json['linkedin']);
	if (linkedin != null) {
		personalProfileInfoEntity.linkedin = linkedin;
	}
	final String? youtube = jsonConvert.convert<String>(json['youtube']);
	if (youtube != null) {
		personalProfileInfoEntity.youtube = youtube;
	}
	final String? instagram = jsonConvert.convert<String>(json['instagram']);
	if (instagram != null) {
		personalProfileInfoEntity.instagram = instagram;
	}
	final int? gradeId = jsonConvert.convert<int>(json['gradeId']);
	if (gradeId != null) {
		personalProfileInfoEntity.gradeId = gradeId;
	}
	final String? gradeName = jsonConvert.convert<String>(json['gradeName']);
	if (gradeName != null) {
		personalProfileInfoEntity.gradeName = gradeName;
	}
	final int? groupId = jsonConvert.convert<int>(json['groupId']);
	if (groupId != null) {
		personalProfileInfoEntity.groupId = groupId;
	}
	final String? groupName = jsonConvert.convert<String>(json['groupName']);
	if (groupName != null) {
		personalProfileInfoEntity.groupName = groupName;
	}
	final String? email = jsonConvert.convert<String>(json['email']);
	if (email != null) {
		personalProfileInfoEntity.email = email;
	}
	final int? attendance = jsonConvert.convert<int>(json['attendance']);
	if (attendance != null) {
		personalProfileInfoEntity.attendance = attendance;
	}
	final int? referralSend = jsonConvert.convert<int>(json['referralSend']);
	if (referralSend != null) {
		personalProfileInfoEntity.referralSend = referralSend;
	}
	final int? referralReceived = jsonConvert.convert<int>(json['referralReceived']);
	if (referralReceived != null) {
		personalProfileInfoEntity.referralReceived = referralReceived;
	}
	final int? thankYouNote = jsonConvert.convert<int>(json['thankYouNote']);
	if (thankYouNote != null) {
		personalProfileInfoEntity.thankYouNote = thankYouNote;
	}
	final int? thankYouNoteSum = jsonConvert.convert<int>(json['thankYouNoteSum']);
	if (thankYouNoteSum != null) {
		personalProfileInfoEntity.thankYouNoteSum = thankYouNoteSum;
	}
	final bool? enable = jsonConvert.convert<bool>(json['enable']);
	if (enable != null) {
		personalProfileInfoEntity.enable = enable;
	}
	final int? positionId = jsonConvert.convert<int>(json['positionId']);
	if (positionId != null) {
		personalProfileInfoEntity.positionId = positionId;
	}
	final String? positionName = jsonConvert.convert<String>(json['positionName']);
	if (positionName != null) {
		personalProfileInfoEntity.positionName = positionName;
	}
	final String? member = jsonConvert.convert<String>(json['member']);
	if (member != null) {
		personalProfileInfoEntity.member = member;
	}
	final List<PersonalProfileInfoCompanyVos>? companyVos = jsonConvert.convertListNotNull<PersonalProfileInfoCompanyVos>(json['companyVos']);
	if (companyVos != null) {
		personalProfileInfoEntity.companyVos = companyVos;
	}
	final AchievementEntity? achievement = jsonConvert.convert<AchievementEntity>(json['achievement']);
	if (achievement != null) {
		personalProfileInfoEntity.achievement = achievement;
	}
	final bool? friend = jsonConvert.convert<bool>(json['friend']);
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
	data['email'] = entity.email;
	data['attendance'] = entity.attendance;
	data['referralSend'] = entity.referralSend;
	data['referralReceived'] = entity.referralReceived;
	data['thankYouNote'] = entity.thankYouNote;
	data['thankYouNoteSum'] = entity.thankYouNoteSum;
	data['enable'] = entity.enable;
	data['positionId'] = entity.positionId;
	data['positionName'] = entity.positionName;
	data['member'] = entity.member;
	data['companyVos'] =  entity.companyVos.map((v) => v.toJson()).toList();
	data['achievement'] = entity.achievement.toJson();
	data['friend'] = entity.friend;
	return data;
}

PersonalProfileInfoCompanyVos $PersonalProfileInfoCompanyVosFromJson(Map<String, dynamic> json) {
	final PersonalProfileInfoCompanyVos personalProfileInfoCompanyVos = PersonalProfileInfoCompanyVos();
	final int? companyId = jsonConvert.convert<int>(json['companyId']);
	if (companyId != null) {
		personalProfileInfoCompanyVos.companyId = companyId;
	}
	final int? userId = jsonConvert.convert<int>(json['userId']);
	if (userId != null) {
		personalProfileInfoCompanyVos.userId = userId;
	}
	final String? companyLogo = jsonConvert.convert<String>(json['companyLogo']);
	if (companyLogo != null) {
		personalProfileInfoCompanyVos.companyLogo = companyLogo;
	}
	final String? companyName = jsonConvert.convert<String>(json['companyName']);
	if (companyName != null) {
		personalProfileInfoCompanyVos.companyName = companyName;
	}
	final String? companyAddress = jsonConvert.convert<String>(json['companyAddress']);
	if (companyAddress != null) {
		personalProfileInfoCompanyVos.companyAddress = companyAddress;
	}
	final String? city = jsonConvert.convert<String>(json['city']);
	if (city != null) {
		personalProfileInfoCompanyVos.city = city;
	}
	final String? postCode = jsonConvert.convert<String>(json['postCode']);
	if (postCode != null) {
		personalProfileInfoCompanyVos.postCode = postCode;
	}
	final String? companyWebsite = jsonConvert.convert<String>(json['companyWebsite']);
	if (companyWebsite != null) {
		personalProfileInfoCompanyVos.companyWebsite = companyWebsite;
	}
	final String? companyWhatsapp = jsonConvert.convert<String>(json['companyWhatsapp']);
	if (companyWhatsapp != null) {
		personalProfileInfoCompanyVos.companyWhatsapp = companyWhatsapp;
	}
	final String? companyEmail = jsonConvert.convert<String>(json['companyEmail']);
	if (companyEmail != null) {
		personalProfileInfoCompanyVos.companyEmail = companyEmail;
	}
	final String? companyPhone = jsonConvert.convert<String>(json['companyPhone']);
	if (companyPhone != null) {
		personalProfileInfoCompanyVos.companyPhone = companyPhone;
	}
	final String? companyFacebook = jsonConvert.convert<String>(json['companyFacebook']);
	if (companyFacebook != null) {
		personalProfileInfoCompanyVos.companyFacebook = companyFacebook;
	}
	final String? companyLinkedin = jsonConvert.convert<String>(json['companyLinkedin']);
	if (companyLinkedin != null) {
		personalProfileInfoCompanyVos.companyLinkedin = companyLinkedin;
	}
	final String? companyYoutube = jsonConvert.convert<String>(json['companyYoutube']);
	if (companyYoutube != null) {
		personalProfileInfoCompanyVos.companyYoutube = companyYoutube;
	}
	final String? companyInstagram = jsonConvert.convert<String>(json['companyInstagram']);
	if (companyInstagram != null) {
		personalProfileInfoCompanyVos.companyInstagram = companyInstagram;
	}
	final String? companyIntroduction = jsonConvert.convert<String>(json['companyIntroduction']);
	if (companyIntroduction != null) {
		personalProfileInfoCompanyVos.companyIntroduction = companyIntroduction;
	}
	final String? companyGoals = jsonConvert.convert<String>(json['companyGoals']);
	if (companyGoals != null) {
		personalProfileInfoCompanyVos.companyGoals = companyGoals;
	}
	final String? companyAccomplishments = jsonConvert.convert<String>(json['companyAccomplishments']);
	if (companyAccomplishments != null) {
		personalProfileInfoCompanyVos.companyAccomplishments = companyAccomplishments;
	}
	final String? companyInterests = jsonConvert.convert<String>(json['companyInterests']);
	if (companyInterests != null) {
		personalProfileInfoCompanyVos.companyInterests = companyInterests;
	}
	final String? serviceIntroduction = jsonConvert.convert<String>(json['serviceIntroduction']);
	if (serviceIntroduction != null) {
		personalProfileInfoCompanyVos.serviceIntroduction = serviceIntroduction;
	}
	final List<PersonalProfileInfoCompanyVosProducePictures>? producePictures = jsonConvert.convertListNotNull<PersonalProfileInfoCompanyVosProducePictures>(json['producePictures']);
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
	final PersonalProfileInfoCompanyVosProducePictures personalProfileInfoCompanyVosProducePictures = PersonalProfileInfoCompanyVosProducePictures();
	final int? produceId = jsonConvert.convert<int>(json['produceId']);
	if (produceId != null) {
		personalProfileInfoCompanyVosProducePictures.produceId = produceId;
	}
	final String? producePicture = jsonConvert.convert<String>(json['producePicture']);
	if (producePicture != null) {
		personalProfileInfoCompanyVosProducePictures.producePicture = producePicture;
	}
	final int? companyId = jsonConvert.convert<int>(json['companyId']);
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