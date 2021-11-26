import 'dart:convert';
import 'package:mmc/generated/json/base/json_field.dart';
import 'package:mmc/generated/json/check_log_entity.g.dart';

@JsonSerializable()
class CheckLogEntity {

	int? checkLogId;
	int? eventId;
	int? userId;
	int? checkType;
	int? createTime;
	String? eventTitle;
  
  CheckLogEntity();

  factory CheckLogEntity.fromJson(Map<String, dynamic> json) => $CheckLogEntityFromJson(json);

  Map<String, dynamic> toJson() => $CheckLogEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}