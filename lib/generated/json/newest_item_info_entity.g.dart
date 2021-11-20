import 'package:mmc/generated/json/base/json_convert_content.dart';
import 'package:mmc/bean/newest_item_info_entity.dart';

NewestItemInfoEntity $NewestItemInfoEntityFromJson(Map<String, dynamic> json) {
	NewestItemInfoEntity newestItemInfoEntity = NewestItemInfoEntity();
	var description = jsonConvert.convert<String>(json['description']);
	if (description != null) {
		newestItemInfoEntity.description = description;
	}
	var storyId = jsonConvert.convert<int>(json['storyId']);
	if (storyId != null) {
		newestItemInfoEntity.storyId = storyId;
	}
	var link = jsonConvert.convert<String>(json['link']);
	if (link != null) {
		newestItemInfoEntity.link = link;
	}
	var title = jsonConvert.convert<String>(json['title']);
	if (title != null) {
		newestItemInfoEntity.title = title;
	}
	var pushTime = jsonConvert.convert<int>(json['pushTime']);
	if (pushTime != null) {
		newestItemInfoEntity.pushTime = pushTime;
	}
	var poster = jsonConvert.convertListNotNull<NewestItemInfoPoster>(json['poster']);
	if (poster != null) {
		newestItemInfoEntity.poster = poster;
	}
	var cover = jsonConvert.convert<String>(json['cover']);
	if (cover != null) {
		newestItemInfoEntity.cover = cover;
	}
	return newestItemInfoEntity;
}

Map<String, dynamic> $NewestItemInfoEntityToJson(NewestItemInfoEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['description'] = entity.description;
	data['storyId'] = entity.storyId;
	data['link'] = entity.link;
	data['title'] = entity.title;
	data['pushTime'] = entity.pushTime;
	data['poster'] =  entity.poster.map((v) => v.toJson()).toList();
	data['cover'] = entity.cover;
	return data;
}

NewestItemInfoPoster $NewestItemInfoPosterFromJson(Map<String, dynamic> json) {
	NewestItemInfoPoster newestItemInfoPoster = NewestItemInfoPoster();
	var id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		newestItemInfoPoster.id = id;
	}
	var url = jsonConvert.convert<String>(json['url']);
	if (url != null) {
		newestItemInfoPoster.url = url;
	}
	return newestItemInfoPoster;
}

Map<String, dynamic> $NewestItemInfoPosterToJson(NewestItemInfoPoster entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['url'] = entity.url;
	return data;
}