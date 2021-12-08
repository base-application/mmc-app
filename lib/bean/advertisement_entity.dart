import 'dart:convert';
import 'package:mmc/generated/json/base/json_field.dart';
import 'package:mmc/generated/json/advertisement_entity.g.dart';

@JsonSerializable()
class AdvertisementEntity {

	late int advertisementId;
	late String advertisementPoster;
	late int advertisementType;
	late bool status;
	late String advertisementLink;
  
  AdvertisementEntity();

  factory AdvertisementEntity.fromJson(Map<String, dynamic> json) => $AdvertisementEntityFromJson(json);

  Map<String, dynamic> toJson() => $AdvertisementEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}