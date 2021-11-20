import 'package:mmc/generated/json/base/json_convert_content.dart';
import 'package:mmc/bean/group_item_entity.dart';

GroupItemEntity $GroupItemEntityFromJson(Map<String, dynamic> json) {
	GroupItemEntity groupItemEntity = GroupItemEntity();
	var groupId = jsonConvert.convert<int>(json['groupId']);
	if (groupId != null) {
		groupItemEntity.groupId = groupId;
	}
	var groupName = jsonConvert.convert<String>(json['groupName']);
	if (groupName != null) {
		groupItemEntity.groupName = groupName;
	}
	return groupItemEntity;
}

Map<String, dynamic> $GroupItemEntityToJson(GroupItemEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['groupId'] = entity.groupId;
	data['groupName'] = entity.groupName;
	return data;
}