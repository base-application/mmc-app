import 'package:mmc/generated/json/base/json_convert_content.dart';
import 'package:mmc/bean/image_vo_entity.dart';

ImageVoEntity $ImageVoEntityFromJson(Map<String, dynamic> json) {
	ImageVoEntity imageVoEntity = ImageVoEntity();
	var id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		imageVoEntity.id = id;
	}
	var url = jsonConvert.convert<String>(json['url']);
	if (url != null) {
		imageVoEntity.url = url;
	}
	return imageVoEntity;
}

Map<String, dynamic> $ImageVoEntityToJson(ImageVoEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['url'] = entity.url;
	return data;
}