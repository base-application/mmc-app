import 'dart:convert';
import 'package:mmc/bean/achievement_entity.dart';
import 'package:mmc/generated/json/base/json_field.dart';
import 'package:mmc/generated/json/personal_profile_info_entity.g.dart';

@JsonSerializable()
class PersonalProfileInfoEntity {

	late int userId;
	String? picture;
	String? name;
	String? concatNumber;
	String? industry;
	int? country;
	int? state;
	int? birthday;
	String? occupation;
	String? introduction;
	String? whatsapp;
	String? facebook;
	String? linkedin;
	String? youtube;
	String? instagram;
	int? gradeId;
	String? gradeName;
	int? groupId;
	String? groupName;
	String? email;
	int? attendance;
	int? referralSend;
	int? referralReceived;
	int? thankYouNote;
	int? thankYouNoteSum;
	late bool enable;
	int? positionId;
	String? positionName;
	String? member;
	late List<PersonalProfileInfoCompanyVos> companyVos;
	late AchievementEntity achievement;
	dynamic friend;
  
  PersonalProfileInfoEntity();

  factory PersonalProfileInfoEntity.fromJson(Map<String, dynamic> json) => $PersonalProfileInfoEntityFromJson(json);

  Map<String, dynamic> toJson() => $PersonalProfileInfoEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class PersonalProfileInfoCompanyVos {

	late int companyId;
	late int userId;
	String? companyLogo;
	String? companyName;
	String? companyAddress;
	String? city;
	String? postCode;
	String? companyWebsite;
	String? companyWhatsapp;
	String? companyEmail;
	String? companyPhone;
	String? companyFacebook;
	String? companyLinkedin;
	String? companyYoutube;
	String? companyInstagram;
	String? companyIntroduction;
	String? companyGoals;
	String? companyAccomplishments;
	String? companyInterests;
	String? serviceIntroduction;
	late List<PersonalProfileInfoCompanyVosProducePictures> producePictures;
  
  PersonalProfileInfoCompanyVos();

  factory PersonalProfileInfoCompanyVos.fromJson(Map<String, dynamic> json) => $PersonalProfileInfoCompanyVosFromJson(json);

  Map<String, dynamic> toJson() => $PersonalProfileInfoCompanyVosToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class PersonalProfileInfoCompanyVosProducePictures {

	late int produceId;
	late String producePicture;
	late int companyId;
  
  PersonalProfileInfoCompanyVosProducePictures();

  factory PersonalProfileInfoCompanyVosProducePictures.fromJson(Map<String, dynamic> json) => $PersonalProfileInfoCompanyVosProducePicturesFromJson(json);

  Map<String, dynamic> toJson() => $PersonalProfileInfoCompanyVosProducePicturesToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}