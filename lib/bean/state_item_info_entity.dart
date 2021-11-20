import 'package:mmc/generated/json/base/json_field.dart';
import 'package:mmc/generated/json/state_item_info_entity.g.dart';


@JsonSerializable()
class StateItemInfoEntity {

	StateItemInfoEntity();

	factory StateItemInfoEntity.fromJson(Map<String, dynamic> json) => $StateItemInfoEntityFromJson(json);

	Map<String, dynamic> toJson() => $StateItemInfoEntityToJson(this);

	late int id;
	late String name;
	late int countryId;
	late String countryCode;
	late String fipsCode;
	late String iso2;
	late double latitude;
	late double longitude;
	dynamic cities;
	String? translations;
}
