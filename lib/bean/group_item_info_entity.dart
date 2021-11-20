import 'package:mmc/generated/json/base/json_field.dart';
import 'package:mmc/generated/json/group_item_info_entity.g.dart';


@JsonSerializable()
class GroupItemInfoEntity {

	GroupItemInfoEntity();

	factory GroupItemInfoEntity.fromJson(Map<String, dynamic> json) => $GroupItemInfoEntityFromJson(json);

	Map<String, dynamic> toJson() => $GroupItemInfoEntityToJson(this);

	late int groupId;
	late String groupName;
	int? thankYouNote;
	int? refer;
	List<GroupItemInfoUserInfoVos>? userInfoVos;
}

@JsonSerializable()
class GroupItemInfoUserInfoVos {

	GroupItemInfoUserInfoVos();

	factory GroupItemInfoUserInfoVos.fromJson(Map<String, dynamic> json) => $GroupItemInfoUserInfoVosFromJson(json);

	Map<String, dynamic> toJson() => $GroupItemInfoUserInfoVosToJson(this);

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
	late int groupId;
	late String groupName;
	int? attendance;
	int? referralSend;
	int? referralReceived;
	int? thankYouNote;
	bool? enable;
	int? positionId;
	String? positionName;
	String? member;
	List<GroupItemInfoUserInfoVosCompanyVos>? companyVos;
	dynamic achievement;
	bool? friend;
}

@JsonSerializable()
class GroupItemInfoUserInfoVosCompanyVos {

	GroupItemInfoUserInfoVosCompanyVos();

	factory GroupItemInfoUserInfoVosCompanyVos.fromJson(Map<String, dynamic> json) => $GroupItemInfoUserInfoVosCompanyVosFromJson(json);

	Map<String, dynamic> toJson() => $GroupItemInfoUserInfoVosCompanyVosToJson(this);

	late int companyId;
	late int userId;
	dynamic companyLogo;
	String? companyName;
	dynamic companyAddress;
	dynamic companyWebsite;
	dynamic companyEmail;
	dynamic companyPhone;
	dynamic companyFacebook;
	dynamic companyLinkedin;
	dynamic companyYoutube;
	dynamic companyInstagram;
	dynamic companyIntroduction;
	dynamic companyGoals;
	dynamic companyAccomplishments;
	dynamic companyInterests;
	dynamic serviceIntroduction;
	List<GroupItemInfoUserInfoVosCompanyVosProducePictures>? producePictures;
}

@JsonSerializable()
class GroupItemInfoUserInfoVosCompanyVosProducePictures {

	GroupItemInfoUserInfoVosCompanyVosProducePictures();

	factory GroupItemInfoUserInfoVosCompanyVosProducePictures.fromJson(Map<String, dynamic> json) => $GroupItemInfoUserInfoVosCompanyVosProducePicturesFromJson(json);

	Map<String, dynamic> toJson() => $GroupItemInfoUserInfoVosCompanyVosProducePicturesToJson(this);

	late int produceId;
	String? producePicture;
	int? companyId;
}
