import 'package:mmc/generated/json/base/json_convert_content.dart';
import 'package:mmc/bean/achievement_entity.dart';

AchievementEntity $AchievementEntityFromJson(Map<String, dynamic> json) {
	final AchievementEntity achievementEntity = AchievementEntity();
	final int? referralSend = jsonConvert.convert<int>(json['referralSend']);
	if (referralSend != null) {
		achievementEntity.referralSend = referralSend;
	}
	final int? referralReceived = jsonConvert.convert<int>(json['referralReceived']);
	if (referralReceived != null) {
		achievementEntity.referralReceived = referralReceived;
	}
	final int? thankYouNoteSend = jsonConvert.convert<int>(json['thankYouNoteSend']);
	if (thankYouNoteSend != null) {
		achievementEntity.thankYouNoteSend = thankYouNoteSend;
	}
	final int? thankYouNoteReceived = jsonConvert.convert<int>(json['thankYouNoteReceived']);
	if (thankYouNoteReceived != null) {
		achievementEntity.thankYouNoteReceived = thankYouNoteReceived;
	}
	final int? prevReferralSend = jsonConvert.convert<int>(json['prevReferralSend']);
	if (prevReferralSend != null) {
		achievementEntity.prevReferralSend = prevReferralSend;
	}
	final int? prevReferralReceived = jsonConvert.convert<int>(json['prevReferralReceived']);
	if (prevReferralReceived != null) {
		achievementEntity.prevReferralReceived = prevReferralReceived;
	}
	final int? prevThankYouNoteSend = jsonConvert.convert<int>(json['prevThankYouNoteSend']);
	if (prevThankYouNoteSend != null) {
		achievementEntity.prevThankYouNoteSend = prevThankYouNoteSend;
	}
	final int? prevThankYouNoteReceived = jsonConvert.convert<int>(json['prevThankYouNoteReceived']);
	if (prevThankYouNoteReceived != null) {
		achievementEntity.prevThankYouNoteReceived = prevThankYouNoteReceived;
	}
	final int? referralSendCount = jsonConvert.convert<int>(json['referralSendCount']);
	if (referralSendCount != null) {
		achievementEntity.referralSendCount = referralSendCount;
	}
	final int? referralReceivedCount = jsonConvert.convert<int>(json['referralReceivedCount']);
	if (referralReceivedCount != null) {
		achievementEntity.referralReceivedCount = referralReceivedCount;
	}
	final int? thankYouNoteSendCount = jsonConvert.convert<int>(json['thankYouNoteSendCount']);
	if (thankYouNoteSendCount != null) {
		achievementEntity.thankYouNoteSendCount = thankYouNoteSendCount;
	}
	final int? thankYouNoteReceivedCount = jsonConvert.convert<int>(json['thankYouNoteReceivedCount']);
	if (thankYouNoteReceivedCount != null) {
		achievementEntity.thankYouNoteReceivedCount = thankYouNoteReceivedCount;
	}
	final int? joinEvent = jsonConvert.convert<int>(json['joinEvent']);
	if (joinEvent != null) {
		achievementEntity.joinEvent = joinEvent;
	}
	final int? joinEventCount = jsonConvert.convert<int>(json['joinEventCount']);
	if (joinEventCount != null) {
		achievementEntity.joinEventCount = joinEventCount;
	}
	final int? joinEventPre = jsonConvert.convert<int>(json['joinEventPre']);
	if (joinEventPre != null) {
		achievementEntity.joinEventPre = joinEventPre;
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
	data['joinEvent'] = entity.joinEvent;
	data['joinEventCount'] = entity.joinEventCount;
	data['joinEventPre'] = entity.joinEventPre;
	return data;
}