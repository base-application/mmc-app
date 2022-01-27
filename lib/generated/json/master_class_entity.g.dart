import 'package:mmc/generated/json/base/json_convert_content.dart';
import 'package:mmc/bean/master_class_entity.dart';
import 'package:mmc/bean/master_class_videos_entity.dart';


MasterClassEntity $MasterClassEntityFromJson(Map<String, dynamic> json) {
	final MasterClassEntity masterClassEntity = MasterClassEntity();
	final String? category = jsonConvert.convert<String>(json['category']);
	if (category != null) {
		masterClassEntity.category = category;
	}
	final String? title = jsonConvert.convert<String>(json['title']);
	if (title != null) {
		masterClassEntity.title = title;
	}
	final String? poster = jsonConvert.convert<String>(json['poster']);
	if (poster != null) {
		masterClassEntity.poster = poster;
	}
	final String? introduction = jsonConvert.convert<String>(json['introduction']);
	if (introduction != null) {
		masterClassEntity.introduction = introduction;
	}
	final int? type = jsonConvert.convert<int>(json['type']);
	if (type != null) {
		masterClassEntity.type = type;
	}
	final List<MasterClassVideosEntity>? videos = jsonConvert.convertListNotNull<MasterClassVideosEntity>(json['videos']);
	if (videos != null) {
		masterClassEntity.videos = videos;
	}
	return masterClassEntity;
}

Map<String, dynamic> $MasterClassEntityToJson(MasterClassEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['category'] = entity.category;
	data['title'] = entity.title;
	data['poster'] = entity.poster;
	data['introduction'] = entity.introduction;
	data['type'] = entity.type;
	data['videos'] =  entity.videos?.map((v) => v.toJson()).toList();
	return data;
}