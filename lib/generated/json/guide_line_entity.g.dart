import 'package:mmc/generated/json/base/json_convert_content.dart';
import 'package:mmc/bean/guide_line_entity.dart';

GuideLineEntity $GuideLineEntityFromJson(Map<String, dynamic> json) {
	final GuideLineEntity guideLineEntity = GuideLineEntity();
	final int? guideLineId = jsonConvert.convert<int>(json['guideLineId']);
	if (guideLineId != null) {
		guideLineEntity.guideLineId = guideLineId;
	}
	final String? guideLineTitle = jsonConvert.convert<String>(json['guideLineTitle']);
	if (guideLineTitle != null) {
		guideLineEntity.guideLineTitle = guideLineTitle;
	}
	final String? guideLineImage = jsonConvert.convert<String>(json['guideLineImage']);
	if (guideLineImage != null) {
		guideLineEntity.guideLineImage = guideLineImage;
	}
	return guideLineEntity;
}

Map<String, dynamic> $GuideLineEntityToJson(GuideLineEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['guideLineId'] = entity.guideLineId;
	data['guideLineTitle'] = entity.guideLineTitle;
	data['guideLineImage'] = entity.guideLineImage;
	return data;
}