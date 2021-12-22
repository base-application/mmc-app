import 'package:mmc/generated/json/base/json_convert_content.dart';
import 'package:mmc/bean/group_item_entity.dart';

GroupItemEntity $GroupItemEntityFromJson(Map<String, dynamic> json) {
	final GroupItemEntity groupItemEntity = GroupItemEntity();
	final int? groupId = jsonConvert.convert<int>(json['groupId']);
	if (groupId != null) {
		groupItemEntity.groupId = groupId;
	}
	final String? groupName = jsonConvert.convert<String>(json['groupName']);
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