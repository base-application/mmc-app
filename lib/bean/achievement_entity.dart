import 'dart:convert';
import 'package:mmc/generated/json/base/json_field.dart';
import 'package:mmc/generated/json/achievement_entity.g.dart';

@JsonSerializable()
class AchievementEntity {

	int? referralSend;
	int? referralReceived;
	int? thankYouNoteSend;
	int? thankYouNoteReceived;
	int? prevReferralSend;
	int? prevReferralReceived;
	int? prevThankYouNoteSend;
	int? prevThankYouNoteReceived;
	int? referralSendCount;
	int? referralReceivedCount;
	int? thankYouNoteSendCount;
	int? thankYouNoteReceivedCount;
	int? joinEvent;
	int? joinEventCount;
	int? joinEventPre;

  AchievementEntity();

  factory AchievementEntity.fromJson(Map<String, dynamic> json) => $AchievementEntityFromJson(json);

  Map<String, dynamic> toJson() => $AchievementEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}