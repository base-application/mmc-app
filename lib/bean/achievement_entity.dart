import 'dart:convert';
import 'package:mmc/generated/json/base/json_field.dart';
import 'package:mmc/generated/json/achievement_entity.g.dart';

@JsonSerializable()
class AchievementEntity {

	late int referralSend;
	late int referralReceived;
	late int thankYouNoteSend;
	late int thankYouNoteReceived;
	late int prevReferralSend;
	late int prevReferralReceived;
	late int prevThankYouNoteSend;
	late int prevThankYouNoteReceived;
	late int referralSendCount;
	late int referralReceivedCount;
	late int thankYouNoteSendCount;
	late int thankYouNoteReceivedCount;
  
  AchievementEntity();

  factory AchievementEntity.fromJson(Map<String, dynamic> json) => $AchievementEntityFromJson(json);

  Map<String, dynamic> toJson() => $AchievementEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}