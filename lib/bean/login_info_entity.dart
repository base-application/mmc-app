import 'package:mmc/generated/json/base/json_field.dart';
import 'package:mmc/generated/json/login_info_entity.g.dart';


@JsonSerializable()
class LoginInfoEntity {

	LoginInfoEntity();

	factory LoginInfoEntity.fromJson(Map<String, dynamic> json) => $LoginInfoEntityFromJson(json);

	Map<String, dynamic> toJson() => $LoginInfoEntityToJson(this);

	String? positionName;
	List<String>? role;
	int? grade;
	String? nickname;
	late bool createEvent;
	late int id;
	String? avatar;
	int? position;
	late String token;
	late String username;
}
