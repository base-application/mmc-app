import 'package:mmc/generated/json/base/json_convert_content.dart';
import 'package:mmc/bean/app_version_entity.dart';

AppVersionEntity $AppVersionEntityFromJson(Map<String, dynamic> json) {
	final AppVersionEntity appVersionEntity = AppVersionEntity();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		appVersionEntity.id = id;
	}
	final int? appId = jsonConvert.convert<int>(json['appId']);
	if (appId != null) {
		appVersionEntity.appId = appId;
	}
	final String? url = jsonConvert.convert<String>(json['url']);
	if (url != null) {
		appVersionEntity.url = url;
	}
	final String? platform = jsonConvert.convert<String>(json['platform']);
	if (platform != null) {
		appVersionEntity.platform = platform;
	}
	final String? version = jsonConvert.convert<String>(json['version']);
	if (version != null) {
		appVersionEntity.version = version;
	}
	final String? info = jsonConvert.convert<String>(json['info']);
	if (info != null) {
		appVersionEntity.info = info;
	}
	final String? createDate = jsonConvert.convert<String>(json['createDate']);
	if (createDate != null) {
		appVersionEntity.createDate = createDate;
	}
	final String? qrcode = jsonConvert.convert<String>(json['qrcode']);
	if (qrcode != null) {
		appVersionEntity.qrcode = qrcode;
	}
	final String? md5 = jsonConvert.convert<String>(json['md5']);
	if (md5 != null) {
		appVersionEntity.md5 = md5;
	}
	return appVersionEntity;
}

Map<String, dynamic> $AppVersionEntityToJson(AppVersionEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['appId'] = entity.appId;
	data['url'] = entity.url;
	data['platform'] = entity.platform;
	data['version'] = entity.version;
	data['info'] = entity.info;
	data['createDate'] = entity.createDate;
	data['qrcode'] = entity.qrcode;
	data['md5'] = entity.md5;
	return data;
}