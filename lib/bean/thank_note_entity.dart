import 'dart:convert';
import 'package:mmc/generated/json/base/json_field.dart';
import 'package:mmc/generated/json/thank_note_entity.g.dart';

@JsonSerializable()
class ThankNoteEntity {

	int? fromUserId;
	String? fromPicture;
	int? fromGroupId;
	String? fromName;
	int? toUserId;
	String? toPicture;
	int? toGroupId;
	String? toName;
	int? thankYouNoteId;
	int? sendUser;
	int? receivedUser;
	int? sendTime;
	int? receivedTime;
	String? note;
	int? value;
	String? fromGroup;
	String? toGroup;
	String? picture;
  
  ThankNoteEntity();

  factory ThankNoteEntity.fromJson(Map<String, dynamic> json) => $ThankNoteEntityFromJson(json);

  Map<String, dynamic> toJson() => $ThankNoteEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}