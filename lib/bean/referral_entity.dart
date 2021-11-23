import 'dart:convert';
import 'package:mmc/bean/image_vo_entity.dart';
import 'package:mmc/generated/json/base/json_field.dart';
import 'package:mmc/generated/json/referral_entity.g.dart';

@JsonSerializable()
class ReferralEntity {

	String? fromPicture;
	int? fromGroupId;
	String? fromName;
	String? fromGroup;
	String? toPicture;
	int? toGroupId;
	String? toGroup;
	String? toName;
	int? referralId;
	String? reason;
	int? receivedUser;
	String? sendUser;
	String? failMessage;
	int? sendTime;
	int? receivedTime;
	int? status;
	String? remark;
	bool? thank;
	List<ImageVoEntity>? picture;
  
  ReferralEntity();

  factory ReferralEntity.fromJson(Map<String, dynamic> json) => $ReferralEntityFromJson(json);

  Map<String, dynamic> toJson() => $ReferralEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}