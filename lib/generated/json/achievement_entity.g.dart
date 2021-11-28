import 'package:mmc/generated/json/base/json_convert_content.dart';
import 'package:mmc/bean/achievement_entity.dart';

AchievementEntity $AchievementEntityFromJson(Map<String, dynamic> json) {
	AchievementEntity achievementEntity = AchievementEntity();
	var referralSend = jsonConvert.convert<int>(json['referralSend']);
	if (referralSend != null) {
		achievementEntity.referralSend = referralSend;
	}
	var referralReceived = jsonConvert.convert<int>(json['referralReceived']);
	if (referralReceived != null) {
		achievementEntity.referralReceived = referralReceived;
	}
	var thankYouNoteSend = jsonConvert.convert<int>(json['thankYouNoteSend']);
	if (thankYouNoteSend != null) {
		achievementEntity.thankYouNoteSend = thankYouNoteSend;
	}
	var thankYouNoteReceived = jsonConvert.convert<int>(json['thankYouNoteReceived']);
	if (thankYouNoteReceived != null) {
		achievementEntity.thankYouNoteReceived = thankYouNoteReceived;
	}
	var prevReferralSend = jsonConvert.convert<int>(json['prevReferralSend']);
	if (prevReferralSend != null) {
		achievementEntity.prevReferralSend = prevReferralSend;
	}
	var prevReferralReceived = jsonConvert.convert<int>(json['prevReferralReceived']);
	if (prevReferralReceived != null) {
		achievementEntity.prevReferralReceived = prevReferralReceived;
	}
	var prevThankYouNoteSend = jsonConvert.convert<int>(json['prevThankYouNoteSend']);
	if (prevThankYouNoteSend != null) {
		achievementEntity.prevThankYouNoteSend = prevThankYouNoteSend;
	}
	var prevThankYouNoteReceived = jsonConvert.convert<int>(json['prevThankYouNoteReceived']);
	if (prevThankYouNoteReceived != null) {
		achievementEntity.prevThankYouNoteReceived = prevThankYouNoteReceived;
	}
	var referralSendCount = jsonConvert.convert<int>(json['referralSendCount']);
	if (referralSendCount != null) {
		achievementEntity.referralSendCount = referralSendCount;
	}
	var referralReceivedCount = jsonConvert.convert<int>(json['referralReceivedCount']);
	if (referralReceivedCount != null) {
		achievementEntity.referralReceivedCount = referralReceivedCount;
	}
	var thankYouNoteSendCount = jsonConvert.convert<int>(json['thankYouNoteSendCount']);
	if (thankYouNoteSendCount != null) {
		achievementEntity.thankYouNoteSendCount = thankYouNoteSendCount;
	}
	var thankYouNoteReceivedCount = jsonConvert.convert<int>(json['thankYouNoteReceivedCount']);
	if (thankYouNoteReceivedCount != null) {
		achievementEntity.thankYouNoteReceivedCount = thankYouNoteReceivedCount;
	}
	return achievementEntity;
}

Map<String, dynamic> $AchievementEntityToJson(AchievementEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['referralSend'] = entity.referralSend;
	data['referralReceived'] = entity.referralReceived;
	data['thankYouNoteSend'] = entity.thankYouNoteSend;
	data['thankYouNoteReceived'] = entity.thankYouNoteReceived;
	data['prevReferralSend'] = entity.prevReferralSend;
	data['prevReferralReceived'] = entity.prevReferralReceived;
	data['prevThankYouNoteSend'] = entity.prevThankYouNoteSend;
	data['prevThankYouNoteReceived'] = entity.prevThankYouNoteReceived;
	data['referralSendCount'] = entity.referralSendCount;
	data['referralReceivedCount'] = entity.referralReceivedCount;
	data['thankYouNoteSendCount'] = entity.thankYouNoteSendCount;
	data['thankYouNoteReceivedCount'] = entity.thankYouNoteReceivedCount;
	return data;
}