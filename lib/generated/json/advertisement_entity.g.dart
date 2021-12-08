import 'package:mmc/generated/json/base/json_convert_content.dart';
import 'package:mmc/bean/advertisement_entity.dart';

AdvertisementEntity $AdvertisementEntityFromJson(Map<String, dynamic> json) {
	AdvertisementEntity advertisementEntity = AdvertisementEntity();
	var advertisementId = jsonConvert.convert<int>(json['advertisementId']);
	if (advertisementId != null) {
		advertisementEntity.advertisementId = advertisementId;
	}
	var advertisementPoster = jsonConvert.convert<String>(json['advertisementPoster']);
	if (advertisementPoster != null) {
		advertisementEntity.advertisementPoster = advertisementPoster;
	}
	var advertisementType = jsonConvert.convert<int>(json['advertisementType']);
	if (advertisementType != null) {
		advertisementEntity.advertisementType = advertisementType;
	}
	var status = jsonConvert.convert<bool>(json['status']);
	if (status != null) {
		advertisementEntity.status = status;
	}
	var advertisementLink = jsonConvert.convert<String>(json['advertisementLink']);
	if (advertisementLink != null) {
		advertisementEntity.advertisementLink = advertisementLink;
	}
	return advertisementEntity;
}

Map<String, dynamic> $AdvertisementEntityToJson(AdvertisementEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['advertisementId'] = entity.advertisementId;
	data['advertisementPoster'] = entity.advertisementPoster;
	data['advertisementType'] = entity.advertisementType;
	data['status'] = entity.status;
	data['advertisementLink'] = entity.advertisementLink;
	return data;
}