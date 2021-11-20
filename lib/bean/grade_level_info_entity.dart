import 'package:mmc/generated/json/base/json_field.dart';
import 'package:mmc/generated/json/grade_level_info_entity.g.dart';


@JsonSerializable()
class GradeLevelInfoEntity {

	GradeLevelInfoEntity();

	factory GradeLevelInfoEntity.fromJson(Map<String, dynamic> json) => $GradeLevelInfoEntityFromJson(json);

	Map<String, dynamic> toJson() => $GradeLevelInfoEntityToJson(this);

	late int gradeId;
	late String gradeName;
}
