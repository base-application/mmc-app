import 'package:mmc/generated/json/base/json_convert_content.dart';
import 'package:mmc/bean/master_class_videos_entity.dart';

MasterClassVideosEntity $MasterClassVideosEntityFromJson(Map<String, dynamic> json) {
	final MasterClassVideosEntity masterClassVideosEntity = MasterClassVideosEntity();
	final String? title = jsonConvert.convert<String>(json['title']);
	if (title != null) {
		masterClassVideosEntity.title = title;
	}
	final String? url = jsonConvert.convert<String>(json['url']);
	if (url != null) {
		masterClassVideosEntity.url = url;
	}
	return masterClassVideosEntity;
}

Map<String, dynamic> $MasterClassVideosEntityToJson(MasterClassVideosEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['title'] = entity.title;
	data['url'] = entity.url;
	return data;
}