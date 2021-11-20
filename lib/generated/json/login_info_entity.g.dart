import 'package:mmc/generated/json/base/json_convert_content.dart';
import 'package:mmc/bean/login_info_entity.dart';

LoginInfoEntity $LoginInfoEntityFromJson(Map<String, dynamic> json) {
	LoginInfoEntity loginInfoEntity = LoginInfoEntity();
	var positionName = jsonConvert.convert<String>(json['positionName']);
	if (positionName != null) {
		loginInfoEntity.positionName = positionName;
	}
	var role = jsonConvert.convertListNotNull<String>(json['role']);
	if (role != null) {
		loginInfoEntity.role = role;
	}
	var grade = jsonConvert.convert<int>(json['grade']);
	if (grade != null) {
		loginInfoEntity.grade = grade;
	}
	var nickname = jsonConvert.convert<String>(json['nickname']);
	if (nickname != null) {
		loginInfoEntity.nickname = nickname;
	}
	var createEvent = jsonConvert.convert<bool>(json['createEvent']);
	if (createEvent != null) {
		loginInfoEntity.createEvent = createEvent;
	}
	var id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		loginInfoEntity.id = id;
	}
	var avatar = jsonConvert.convert<String>(json['avatar']);
	if (avatar != null) {
		loginInfoEntity.avatar = avatar;
	}
	var position = jsonConvert.convert<int>(json['position']);
	if (position != null) {
		loginInfoEntity.position = position;
	}
	var token = jsonConvert.convert<String>(json['token']);
	if (token != null) {
		loginInfoEntity.token = token;
	}
	var username = jsonConvert.convert<String>(json['username']);
	if (username != null) {
		loginInfoEntity.username = username;
	}
	return loginInfoEntity;
}

Map<String, dynamic> $LoginInfoEntityToJson(LoginInfoEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['positionName'] = entity.positionName;
	data['role'] =  entity.role;
	data['grade'] = entity.grade;
	data['nickname'] = entity.nickname;
	data['createEvent'] = entity.createEvent;
	data['id'] = entity.id;
	data['avatar'] = entity.avatar;
	data['position'] = entity.position;
	data['token'] = entity.token;
	data['username'] = entity.username;
	return data;
}