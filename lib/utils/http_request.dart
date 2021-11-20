import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:mmc/bean/event_data_item_info_entity.dart';
import 'package:mmc/bean/event_detail_info_entity.dart';
import 'package:mmc/bean/grade_level_info_entity.dart';
import 'package:mmc/bean/group_item_entity.dart';
import 'package:mmc/bean/group_item_info_entity.dart';
import 'package:mmc/bean/home_index_info_entity.dart';
import 'package:mmc/bean/login_info_entity.dart';
import 'package:mmc/bean/network_item_info_entity.dart';
import 'package:mmc/bean/newest_item_info_entity.dart';
import 'package:mmc/bean/personal_profile_info_entity.dart';
import 'package:mmc/bean/state_item_info_entity.dart';
import 'package:mmc/screens/login.dart';

import 'http.dart';

/// 用户登录
login(BuildContext context, { required String account, required String password, bool endHideLoading = true, required Function(LoginInfoEntity info) result, Function? err }) {
  httpPost(context, url: 'login', queryParameters: { 'username': account, 'password': password }, endHideLoading: endHideLoading).then((value) {
    result.call(LoginInfoEntity.fromJson(value!.data));
  }).catchError((_) {
    err?.call();
  });
}

/// 用户注册
register(BuildContext context, { required String countryCode, required String phoneNumber, required String verificationCode, required String password, required Function() result, Function? err }) {
  httpPost(context, url: 'user/info/register', queryParameters: {
    'countryCode': countryCode,
    'phoneNumber': phoneNumber,
    'verificationCode': verificationCode,
    'password': password,
  }, loadingTip: '账号注册中').then((value) {
    result.call();
  }).catchError((_) {
    err?.call();
  });
}

/// 忘记密码
forgotPassword(BuildContext context, { required String phoneNumber, required String verificationCode, required String password, required Function() result, Function? err }) {
  httpPost(context, url: 'user/info/forgot/password', queryParameters: {
    'phoneNumber': phoneNumber,
    'verificationCode': verificationCode,
    'password': password,
  }, loadingTip: '重置密码中').then((value) {
    result.call();
  }).catchError((_) {
    err?.call();
  });
}

/// 发送短信验证码
/// type 1 注册   2 忘记密码
sendSmsCode(BuildContext context, { required String phoneNumber, required int type, required Function() result, Function? err }) {
  httpPost(context, url: 'user/info/send/verification', queryParameters: {
    'phoneNumber': phoneNumber,
    'type': type,
  }, loadingTip: '短信验证码发送中').then((value) {
    result.call();
  }).catchError((_) {
    err?.call();
  });
}

/// 获取国家code值
Future getCountryCodeData(BuildContext context, { bool silence = true, required Function(List<CountryCodeInfo> list) result, Function? err }) async {
  await httpGetList(context, url: 'countries', queryParameters: {}, silence: silence).then((value) {
    result.call(value!.data!.map((e) => CountryCodeInfo.fromJson(e)).toList());
  }).catchError((_) {
    err?.call();
  });
}

/// 根据国家code 获取城市数据
Future getStateDataByCountryCode(BuildContext context, { required String countryCode, bool silence = true, required Function(List<StateItemInfoEntity> list) result, Function? err }) async {
  await httpGetList(context, url: 'states', queryParameters: {
    'countryCode': countryCode,
  }, silence: silence).then((value) {
    result.call(value!.data!.map((e) => StateItemInfoEntity.fromJson(e)).toList());
  }).catchError((_) {
    err?.call();
  });
}

/// 获取行业数据
Future getIndustryData(BuildContext context, { bool silence = true, required Function(List<String> list) result, Function? err }) async {
  await httpGetList(context, url: 'user/info/industry', queryParameters: {}, silence: silence).then((value) {
    result.call(value!.data!.map((e) => e.toString()).toList());
  }).catchError((_) {
    err?.call();
  });
}

/// 获取用户详细数据
Future getUserDetailData(BuildContext context, { required int userId, bool silence = false, required Function(PersonalProfileInfoEntity info) result, Function? err }) async {
  await httpGet(context, url: 'user/info/detail', queryParameters: {
    'userId': userId,
  }, silence: silence).then((value) {
    result.call(PersonalProfileInfoEntity.fromJson(value!.data));
  }).catchError((_) {
    err?.call();
  });
}

/// 获取首页主体数据
Future getIndexData(BuildContext context, { bool silence = false, required Function(HomeIndexInfoEntity info) result, Function? err }) async {
  await httpGet(context, url: 'user/info/index', queryParameters: {}, silence: silence).then((value) {
    result.call(HomeIndexInfoEntity.fromJson(value!.data));
  }).catchError((_) {
    err?.call();
  });
}

/// group数据
Future getGroupListData(BuildContext context, { bool silence = false, required Function(List<GroupItemEntity> list) result, Function? err }) async {
  await httpGetList(context, url: 'group/list', queryParameters: {}, silence: silence).then((value) {
    result.call(value!.data!.map((e) => GroupItemEntity.fromJson(e)).toList());
  }).catchError((_) {
    err?.call();
  });
}

/// group数据
Future getGroupListUserData(BuildContext context, { String? groupName, bool silence = false, required Function(List<GroupItemInfoEntity> list) result, Function? err }) async {
  await httpGetList(context, url: 'group/list/user', queryParameters: {
    'groupName': groupName,
  }, silence: silence).then((value) {
    result.call(value!.data!.map((e) => GroupItemInfoEntity.fromJson(e)).toList());
  }).catchError((_) {
    err?.call();
  });
}

/// grade数据
Future getGradeListData(BuildContext context, { bool silence = false, required Function(List<GradeLevelInfoEntity> list) result, Function? err }) async {
  await httpGetList(context, url: 'grade/list', queryParameters: {}, silence: silence).then((value) {
    result.call(value!.data!.map((e) => GradeLevelInfoEntity.fromJson(e)).toList());
  }).catchError((_) {
    err?.call();
  });
}

/// 用户可加入的event数据
Future getEventListData(BuildContext context, { String? dateTime, bool silence = false, required Function(List<EventDataItemInfoEntity> list) result, Function? err }) async {
  await httpGetPage(context, url: 'event/list/user', queryParameters: {
    'page': 1,
    'size': 0,
    'startTime': dateTime != null ? DateUtil.getDateTime('$dateTime 00:00:00')!.millisecondsSinceEpoch : null,
    'endTime': dateTime != null ? DateUtil.getDateTime('$dateTime 23:59:59')!.millisecondsSinceEpoch : null,
  }, silence: silence).then((value) {
    result.call(value!.data!.list.map((e) => EventDataItemInfoEntity.fromJson(e)).toList());
  }).catchError((_) {
    err?.call();
  });
}

/// 用户创建的event数据
Future getUserCreateEventData(BuildContext context, { String? dateTime, bool silence = false, required Function(List<EventDataItemInfoEntity> list) result, Function? err }) async {
  await httpGetPage(context, url: 'event/user/create', queryParameters: {
    'page': 1,
    'size': 0,
    'startTime': dateTime != null ? DateUtil.getDateTime('$dateTime 00:00:00')!.millisecondsSinceEpoch : null,
    'endTime': dateTime != null ? DateUtil.getDateTime('$dateTime 23:59:59')!.millisecondsSinceEpoch : null,
  }, silence: silence).then((value) {
    result.call(value!.data!.list.map((e) => EventDataItemInfoEntity.fromJson(e)).toList());
  }).catchError((_) {
    err?.call();
  });
}

/// 创建event数据
Future createEventData(BuildContext context, {
    required List<GradeLevelInfoEntity> grades,
    List<GroupItemEntity>? groups,
    required String eventTitle,
    required String eventDescription,
    required int eventStartTime,
    required int eventEndTime,
    required String eventLocation,
    required String eventMapLink,
    required List<String> eventPoster,
    bool silence = false,
    required Function() result,
    Function? err,
  }) async {
  await httpPost(context, url: 'event/add', data: {
    'grades': grades,
    'groups': groups,
    'eventTitle': eventTitle,
    'eventDescription': eventDescription,
    'eventStartTime': eventStartTime,
    'eventEndTime': eventEndTime,
    'eventLocation': eventLocation,
    'eventMapLink': eventMapLink,
    'eventPoster': eventPoster.map((e) => { 'url': e }).toList(),
  }, silence: silence).then((value) {
    result.call();
  }).catchError((_) {
    err?.call();
  });
}

/// join Event
Future doJoinEvent(BuildContext context, { required int eventId, bool silence = false, required Function(List<EventDataItemInfoAttendance> list) result, Function? err }) async {
  await httpPutList(context, url: 'event/join', queryParameters: {
    'eventId': eventId,
  }, silence: silence).then((value) {
    result.call(value!.data!.map((e) => EventDataItemInfoAttendance.fromJson(e)).toList());
  }).catchError((_) {
    err?.call();
  });
}

/// unJoin Event
Future doUnJoinEvent(BuildContext context, { required int eventId, bool silence = false, required Function(List<EventDataItemInfoAttendance> list) result, Function? err }) async {
  await httpPutList(context, url: 'event/unjoin', queryParameters: {
    'eventId': eventId,
  }, silence: silence).then((value) {
    result.call(value!.data!.map((e) => EventDataItemInfoAttendance.fromJson(e)).toList());
  }).catchError((_) {
    err?.call();
  });
}

/// 用户 event 详情数据
Future getEventDetailData(BuildContext context, { required int eventId, bool silence = false, required Function(EventDetailInfoEntity info) result, Function? err }) async {
  await httpPost(context, url: 'event/detail', queryParameters: {
    'id': eventId,
  }, silence: silence).then((value) {
    result.call(EventDetailInfoEntity.fromJson(value!.data));
  }).catchError((_) {
    err?.call();
  });
}

/// 用户 好友添加
Future userFriendApply(BuildContext context, { required int idolId, bool silence = false, required Function() result, Function? err }) async {
  await httpPost(context, url: 'user/friend/apply', queryParameters: {
    'idolId': idolId,
  }, silence: silence).then((value) {
    result.call();
  }).catchError((_) {
    err?.call();
  });
}

/// 用户 关注 / 取消
Future userFollowAdd(BuildContext context, { required int userId, bool silence = false, required Function() result, Function? err }) async {
  await httpPost(context, url: 'user/follow/add', queryParameters: {
    'userId': userId,
  }, silence: silence).then((value) {
    result.call();
  }).catchError((_) {
    err?.call();
  });
}

/// 保存用户个人数据
Future userInfoUpdate(BuildContext context, {
  required String picture,
  required String name,
  required int birthday,
  int? country,
  int? state,
  String? industry, // 行业
  required String occupation,
  required String introduction,
  required String concatNumber,
  String? whatsapp,
  String? facebook,
  String? linkedin,
  String? youtube,
  String? instagram,
  String? email,
  String? member,
  required int userId,
  bool silence = false,
  required Function(PersonalProfileInfoEntity info) result,
  Function? err,
}) async {
  await httpPut(context, url: 'user/info/update', data: {
    'picture': picture,
    'name': name,
    'birthday': birthday,
    'country': country,
    'state': state,
    'industry': industry,
    'occupation': occupation,
    'introduction': introduction,
    'concatNumber': concatNumber,
    'whatsapp': whatsapp,
    'facebook': facebook,
    'linkedin': linkedin,
    'youtube': youtube,
    'instagram': instagram,
    'email': email,
    'member': member,
    'userId': userId,
  }, silence: silence).then((value) {
    result.call(PersonalProfileInfoEntity.fromJson(value!.data));
  }).catchError((_) {
    err?.call();
  });
}

/// 公司创建或修改
Future companyInfoAddOrUpdate(BuildContext context, {
  int? companyId,
  required String companyLogo,
  required String companyName,
  required String companyAddress,
  required String companyCity,
  required String companyPostcode,
  String? companyWebsite,
  String? companyEmail,
  String? companyPhone,
  String? companyFacebook,
  String? companyLinkedin,
  String? companyYoutube,
  String? companyInstagram,
  required String companyIntroduction,
  String? companyGoals,
  String? companyAccomplishments,
  String? companyInterests,
  String? serviceIntroduction,
  List? producePictures,
  required int userId,
  bool silence = false,
  required Function(int companyId) result,
  Function? err,
}) async {
  await httpPut(context, url: 'user/info/company/update', data: {
    'companyId': companyId,
    'companyLogo': companyLogo,
    'companyName': companyName,
    'companyAddress': companyAddress,
    'city': companyCity,
    'postCode': companyPostcode,
    'companyWebsite': companyWebsite,
    'companyEmail': companyEmail,
    'companyPhone': companyPhone,
    'companyFacebook': companyFacebook,
    'companyLinkedin': companyLinkedin,
    'companyYoutube': companyYoutube,
    'companyInstagram': companyInstagram,
    'companyIntroduction': companyIntroduction,
    'companyGoals': companyGoals,
    'companyAccomplishments': companyAccomplishments,
    'companyInterests': companyInterests,
    'serviceIntroduction': serviceIntroduction,
    'producePictures': producePictures,
    'userId': userId,
  }, silence: silence).then((value) {
    result.call(value!.data);
  }).catchError((_) {
    err?.call();
  });
}

/// 删除公司
Future deleteCompany(BuildContext context, { required int companyId, bool silence = false, required Function() result, Function? err }) async {
  await httpDelete(context, url: 'user/info/company/delete', queryParameters: {
    'companyId': companyId,
  }, silence: silence).then((value) {
    result.call();
  }).catchError((_) {
    err?.call();
  });
}

/// 获取Newest列表数据
Future getNewestListData(BuildContext context, { String? title, int? startDate, int? endDate, bool silence = false, required Function(List<NewestItemInfoEntity> list) result, Function? err }) async {
  await httpGetPage(context, url: 'newest/story/list', queryParameters: {
    'page': 1,
    'size': 0,
    'title': title,
    'startDate': startDate,
    'endDate': endDate,
  }, silence: silence).then((value) {
    result.call(value!.data!.list.map((e) => NewestItemInfoEntity.fromJson(e)).toList());
  }).catchError((_) {
    err?.call();
  });
}

/// 获取Network列表数据
Future getNetworkListData(BuildContext context, { String? name, String? industry, int? countryId, int? cityId, bool silence = false, required Function(List<NetworkItemInfoEntity> list) result, Function? err }) async {
  await httpGetPage(context, url: 'user/info/network', queryParameters: {
    'page': 1,
    'size': 0,
    'name': name,
    'industry': industry,
    'countryId': countryId,
    'cityId': cityId,
  }, silence: silence).then((value) {
    result.call(value!.data!.list.map((e) => NetworkItemInfoEntity.fromJson(e)).toList());
  }).catchError((_) {
    err?.call();
  });
}
