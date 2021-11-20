import 'dart:convert';
import 'package:mmc/generated/json/base/json_field.dart';
import 'package:mmc/generated/json/network_item_info_entity.g.dart';

@JsonSerializable()
class NetworkItemInfoEntity {

	late int userId;
	String? picture;
	int? groupId;
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
	double? attendance;
	late int referralSend;
	late int referralReceived;
	late int thankUouNote;
	bool? enable;
	bool? isFriend;
  
  NetworkItemInfoEntity();

  factory NetworkItemInfoEntity.fromJson(Map<String, dynamic> json) => $NetworkItemInfoEntityFromJson(json);

  Map<String, dynamic> toJson() => $NetworkItemInfoEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}