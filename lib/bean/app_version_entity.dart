import 'dart:convert';
import 'package:mmc/generated/json/base/json_field.dart';
import 'package:mmc/generated/json/app_version_entity.g.dart';

@JsonSerializable()
class AppVersionEntity {

	late int id;
	late int appId;
	late String url;
	late String platform;
	late String version;
	late String info;
	late String createDate;
	late String qrcode;
	late String md5;
  
  AppVersionEntity();

  factory AppVersionEntity.fromJson(Map<String, dynamic> json) => $AppVersionEntityFromJson(json);

  Map<String, dynamic> toJson() => $AppVersionEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}