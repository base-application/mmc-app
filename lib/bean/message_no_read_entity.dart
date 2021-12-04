import 'dart:convert';
import 'package:mmc/generated/json/base/json_field.dart';
import 'package:mmc/generated/json/message_no_read_entity.g.dart';

@JsonSerializable()
class MessageNoReadEntity {

	late int count;
	late int event;
	late int newset;
	late int notification;
  
  MessageNoReadEntity();

  factory MessageNoReadEntity.fromJson(Map<String, dynamic> json) => $MessageNoReadEntityFromJson(json);

  Map<String, dynamic> toJson() => $MessageNoReadEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}