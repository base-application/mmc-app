import 'package:mmc/generated/json/base/json_convert_content.dart';
import 'package:mmc/bean/grade_level_info_entity.dart';

GradeLevelInfoEntity $GradeLevelInfoEntityFromJson(Map<String, dynamic> json) {
	final GradeLevelInfoEntity gradeLevelInfoEntity = GradeLevelInfoEntity();
	final int? gradeId = jsonConvert.convert<int>(json['gradeId']);
	if (gradeId != null) {
		gradeLevelInfoEntity.gradeId = gradeId;
	}
	final String? gradeName = jsonConvert.convert<String>(json['gradeName']);
	if (gradeName != null) {
		gradeLevelInfoEntity.gradeName = gradeName;
	}
	return gradeLevelInfoEntity;
}

Map<String, dynamic> $GradeLevelInfoEntityToJson(GradeLevelInfoEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['gradeId'] = entity.gradeId;
	data['gradeName'] = entity.gradeName;
	return data;
}