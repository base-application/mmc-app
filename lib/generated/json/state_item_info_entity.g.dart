import 'package:mmc/generated/json/base/json_convert_content.dart';
import 'package:mmc/bean/state_item_info_entity.dart';

StateItemInfoEntity $StateItemInfoEntityFromJson(Map<String, dynamic> json) {
	final StateItemInfoEntity stateItemInfoEntity = StateItemInfoEntity();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		stateItemInfoEntity.id = id;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		stateItemInfoEntity.name = name;
	}
	final int? countryId = jsonConvert.convert<int>(json['countryId']);
	if (countryId != null) {
		stateItemInfoEntity.countryId = countryId;
	}
	final String? countryCode = jsonConvert.convert<String>(json['countryCode']);
	if (countryCode != null) {
		stateItemInfoEntity.countryCode = countryCode;
	}
	final String? fipsCode = jsonConvert.convert<String>(json['fipsCode']);
	if (fipsCode != null) {
		stateItemInfoEntity.fipsCode = fipsCode;
	}
	final String? iso2 = jsonConvert.convert<String>(json['iso2']);
	if (iso2 != null) {
		stateItemInfoEntity.iso2 = iso2;
	}
	final double? latitude = jsonConvert.convert<double>(json['latitude']);
	if (latitude != null) {
		stateItemInfoEntity.latitude = latitude;
	}
	final double? longitude = jsonConvert.convert<double>(json['longitude']);
	if (longitude != null) {
		stateItemInfoEntity.longitude = longitude;
	}
	if (json['cities'] != null) {
		stateItemInfoEntity.cities = json['cities'].toInt();
	}
	final String? translations = jsonConvert.convert<String>(json['translations']);
	if (translations != null) {
		stateItemInfoEntity.translations = translations;
	}
	return stateItemInfoEntity;
}

Map<String, dynamic> $StateItemInfoEntityToJson(StateItemInfoEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['countryId'] = entity.countryId;
	data['countryCode'] = entity.countryCode;
	data['fipsCode'] = entity.fipsCode;
	data['iso2'] = entity.iso2;
	data['latitude'] = entity.latitude;
	data['longitude'] = entity.longitude;
	data['cities'] = entity.cities;
	data['translations'] = entity.translations;
	return data;
}