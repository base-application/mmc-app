import 'package:mmc/generated/json/base/json_convert_content.dart';
import 'package:mmc/bean/newest_item_info_entity.dart';

NewestItemInfoEntity $NewestItemInfoEntityFromJson(Map<String, dynamic> json) {
	final NewestItemInfoEntity newestItemInfoEntity = NewestItemInfoEntity();
	final String? description = jsonConvert.convert<String>(json['description']);
	if (description != null) {
		newestItemInfoEntity.description = description;
	}
	final int? storyId = jsonConvert.convert<int>(json['storyId']);
	if (storyId != null) {
		newestItemInfoEntity.storyId = storyId;
	}
	final String? link = jsonConvert.convert<String>(json['link']);
	if (link != null) {
		newestItemInfoEntity.link = link;
	}
	final String? title = jsonConvert.convert<String>(json['title']);
	if (title != null) {
		newestItemInfoEntity.title = title;
	}
	final int? pushTime = jsonConvert.convert<int>(json['pushTime']);
	if (pushTime != null) {
		newestItemInfoEntity.pushTime = pushTime;
	}
	final List<NewestItemInfoPoster>? poster = jsonConvert.convertListNotNull<NewestItemInfoPoster>(json['poster']);
	if (poster != null) {
		newestItemInfoEntity.poster = poster;
	}
	final String? cover = jsonConvert.convert<String>(json['cover']);
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
	final NewestItemInfoPoster newestItemInfoPoster = NewestItemInfoPoster();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		newestItemInfoPoster.id = id;
	}
	final String? url = jsonConvert.convert<String>(json['url']);
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