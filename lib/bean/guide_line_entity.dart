import 'dart:convert';
import 'package:mmc/generated/json/base/json_field.dart';
import 'package:mmc/generated/json/guide_line_entity.g.dart';

@JsonSerializable()
class GuideLineEntity {

	late int guideLineId;
  late String guideLineTitle;
  late String guideLineImage;
  
  GuideLineEntity();

  factory GuideLineEntity.fromJson(Map<String, dynamic> json) => $GuideLineEntityFromJson(json);

  Map<String, dynamic> toJson() => $GuideLineEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}