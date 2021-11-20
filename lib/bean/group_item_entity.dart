import 'package:mmc/generated/json/base/json_field.dart';
import 'package:mmc/generated/json/group_item_entity.g.dart';


@JsonSerializable()
class GroupItemEntity {

	GroupItemEntity();

	factory GroupItemEntity.fromJson(Map<String, dynamic> json) => $GroupItemEntityFromJson(json);

	Map<String, dynamic> toJson() => $GroupItemEntityToJson(this);

	late int groupId;
	late String groupName;
}
