
import 'dart:developer';
import 'dart:io';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:mmc/bean/advertisement_entity.dart';
import 'package:mmc/bean/app_version_entity.dart';
import 'package:mmc/bean/check_log_entity.dart';
import 'package:mmc/bean/event_data_item_info_entity.dart';
import 'package:mmc/bean/event_detail_info_entity.dart';
import 'package:mmc/bean/grade_level_info_entity.dart';
import 'package:mmc/bean/group_item_entity.dart';
import 'package:mmc/bean/group_item_info_entity.dart';
import 'package:mmc/bean/guide_line_entity.dart';
import 'package:mmc/bean/home_index_info_entity.dart';
import 'package:mmc/bean/image_vo_entity.dart';
import 'package:mmc/bean/login_info_entity.dart';
import 'package:mmc/bean/message_no_read_entity.dart';
import 'package:mmc/bean/network_item_info_entity.dart';
import 'package:mmc/bean/newest_item_info_entity.dart';
import 'package:mmc/bean/notification_entity.dart';
import 'package:mmc/bean/personal_profile_info_entity.dart';
import 'package:mmc/bean/referral_entity.dart';
import 'package:mmc/bean/state_item_info_entity.dart';
import 'package:mmc/bean/thank_note_entity.dart';
import 'package:mmc/router/auth_guard.dart';
import 'package:mmc/widget/app_bar_home.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/src/provider.dart';

import 'http.dart';

/// 用户登录
login(BuildContext context, { required String account, required String password, bool endHideLoading = true, required Function(LoginInfoEntity info) result, Function? err }) {
  httpPost(context, url: 'login', queryParameters: { 'username': account, 'password': password }, endHideLoading: endHideLoading).then((value) {
    result.call(LoginInfoEntity.fromJson(value!.data));
  }).catchError((_) {
    err?.call();
  });
}

/// 用户设置token
setToken(BuildContext context, { required String token,required Function(LoginInfoEntity info) result, Function? err }) {
  httpPut(context, url: 'user/push/token',silence: true, queryParameters: { 'pushToken': token}).then((value) {
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
  httpPut(context, url: 'user/info/forgot/password', queryParameters: {
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
sendSmsCode(BuildContext context, { required String phoneNumber, required String countryCode, required int type, required Function() result, Function? err }) {
  httpPost(context, url: 'user/info/send/verification', queryParameters: {
    'phoneNumber': phoneNumber,
    'countryCode': countryCode,
    'type': type,
  }, loadingTip: '短信验证码发送中').then((value) {
    result.call();
  }).catchError((_) {
    err?.call();
  });
}



/// 发送短信验证码
/// type 1 注册   2 忘记密码
Future<MessageNoReadEntity> noReadMessage(BuildContext context) async {
  BaseBean? bean = await httpGet(context, url: 'user/info/message',silence: true);
  return MessageNoReadEntity.fromJson(bean!.data);
}

/// 获取国家code值
Future getCountryCodeData(BuildContext context, { bool silence = true, required Function(List<CountryCodeInfo> list) result, Function? err }) async {
  await httpGetList(context, url: 'countries', queryParameters: {}, silence: silence).then((value) {
    result.call(value!.data!.map((e) => CountryCodeInfo.fromJson(e)).toList());
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
Future<PersonalProfileInfoEntity> getUserDetailData(BuildContext context, { required int userId, bool silence = false}) async {
  BaseBean? bean = await httpGet(context, url: 'user/info/detail', queryParameters: {'userId': userId,}, silence: silence);
 return PersonalProfileInfoEntity.fromJson(bean!.data);
}

/// 获取首页主体数据
Future<HomeIndexInfoEntity> getIndexData(BuildContext context, { bool silence = false}) async {
  BaseBean? bean;
  if(context.read<AuthService>().getLoginInfo?.token!=null){
    bean = await httpGet(context, url: 'user/info/index', queryParameters: {}, silence: silence);
  }else{
    bean = await httpGet(context, url: 'user/info/tourist', queryParameters: {}, silence: silence);
  }
  return HomeIndexInfoEntity.fromJson(bean?.data);
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


/// 我的group数据
Future<GroupItemInfoEntity?> groupDetail(BuildContext context,int? groupId) async {
  if(groupId == null){
    return null;
  }
  BaseBean? res = await httpGet(context,
      url: 'group/detail',
      queryParameters: {"groupId":groupId}, silence: false);
  if(res?.code == 200){
    return GroupItemInfoEntity.fromJson(res!.data);
  }else{
    return null;
  }
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
    int? eventId,
    required String eventLocation,
    required String eventMapLink,
    required List<String> eventPoster,
    bool silence = false,
    required Function() result,
    Function? err,
  }) async {
  await httpPost(context, url: 'event/add', data: {
    'eventId': eventId,
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
  int? birthday,
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


/// 已读新闻
Future newestRead(BuildContext context, int newId) async {
  await httpGet(context, url: 'newest/story/detail', queryParameters: {
    'id': newId,
  }, silence: true);
}

/// 获取Network列表数据
Future getNetworkListData(BuildContext context, { String? name, int? groupId , String? industry, int? countryId, int? cityId, bool silence = false, required Function(List<NetworkItemInfoEntity> list) result, Function? err }) async {
  await httpGetPage(context, url: 'user/info/network', queryParameters: {
    'page': 1,
    'size': 0,
    'name': name,
    'industry': industry,
    'countryId': countryId,
    'cityId': cityId,
    'groupId': groupId
  }, silence: silence).then((value) {
    result.call(value!.data!.list.map((e) => NetworkItemInfoEntity.fromJson(e)).toList());
  }).catchError((_) {
    err?.call();
  });
}

/// 获取Network列表数据
Future getMyNetwork(BuildContext context, { String? name, String? industry, int? groupId ,int? countryId, int? cityId, bool silence = false, required Function(List<NetworkItemInfoEntity> list) result, Function? err }) async {
  await httpGetPage(context, url: 'user/info/my/network', queryParameters: {
    'page': 1,
    'size': 0,
    'name': name,
    'industry': industry,
    'countryId': countryId,
    'cityId': cityId,
    'groupId': groupId,
  }, silence: silence).then((value) {
    result.call(value!.data!.list.map((e) => NetworkItemInfoEntity.fromJson(e)).toList());
  }).catchError((_) {
    log(err.toString());
    err?.call();
  });
}


/// 用户修改密码
Future updatePassword(BuildContext context, String oldPassword, String  password) async {
  BaseBean? bean = await httpPut(context, url: 'user/info/update/password', queryParameters: {
    'oldPassword': oldPassword,
    'password': password
  }, silence: false);
  return bean?.code == 200;
}



/// 发送推荐
Future sendReferral(BuildContext context, { required String reason, required int receivedUser,required List<ImageVoEntity> images, bool silence = false, required Function(bool) result, Function? err }) async {
  await httpPost(context, url: 'referral/send', data: {
    'reason': reason,
    'receivedUser': receivedUser,
    'picture': images,
  }, silence: silence).then((value) {
    result.call(value!.code == 200);
  }).catchError((_) {
    err?.call();
  });
}


/// 收到的推荐
Future<List<ReferralEntity>> receivedList(BuildContext context,int page) async {
  BaseBean? res = await httpGet(context, url: 'referral/user/list',queryParameters: {"page":page});
  if(res!=null){
    List<ReferralEntity> resdata =res.data!['list'].map<ReferralEntity>((e) => ReferralEntity.fromJson(e)).toList();
    return resdata;
  }else{
    return [];
  }
}


/// 处理收到的推荐
Future received(BuildContext context,
    { required int referralId, required int status,String? failMessage, required Function(bool) result, Function? err }) async {
  await httpPost(context, url: 'referral/received', queryParameters: {
    'referralId': referralId,
    'status': status,
    'failMessage': failMessage,
  }, silence: false).then((value) {
    result.call(value!.code == 200);
  }).catchError((_) {
    err?.call();
  });
}


/// 发送感谢
Future thank(BuildContext context, { required String note, required String value,required int referralId, required Function(bool) result}) async {
  await httpPost(context, url: '/thank/you/note/add', data: {
    'note': note,
    'value': value,
    'referralId':referralId
  }, silence: false).then((value) {
    result.call(value!.code == 200);
  });
}

/// 发送感谢
Future<List<ThankNoteEntity>> receivedThank(BuildContext context,int page) async {
  BaseBean? res = await httpGet(context, url: '/thank/you/note/user/list',queryParameters: {"page": page});
  if(res!=null){
    List<ThankNoteEntity> resdata =res.data!['list'].map<ThankNoteEntity>((e) => ThankNoteEntity.fromJson(e)).toList();
    return resdata;
  }else{
    return [];
  }
}




/// 用户加入的活动
Future<List<EventDataItemInfoEntity>> joinEventList(BuildContext context,int page) async {
  BaseBean? res = await httpGet(context, url: '/event/join/list',queryParameters: {"page": page});
  if(res!=null){
    List<EventDataItemInfoEntity> resdata =res.data!['list'].map<EventDataItemInfoEntity>((e) => EventDataItemInfoEntity.fromJson(e)).toList();
    return resdata;
  }else{
    return [];
  }
}



/// 用户确认出席
Future<bool> confirmAttend(BuildContext context,int eventId,int userId , {String? agent, String? agentRole, String? absentReason}) async {
  BaseBean? res = await httpPut(context,
      url: '/event/confirm/attend',
      queryParameters: {"eventId": eventId,"userId":userId,"agent":agent,"agentRole":agentRole,"absentReason":absentReason});
  if(res!=null){
    return res.code == 200;
  }else{
    return false;
  }
}


/// 用户签到
Future<bool> checkIn(BuildContext context,int eventId) async {
  BaseBean? res = await httpPut(context,
      url: '/event/checkin',
      queryParameters: {"eventId": eventId});
  if(res!=null){
    return res.code == 200;
  }else{
    return false;
  }
}

/// 管理员修改签到状态
Future<bool> confirmCheckIn(BuildContext context,int eventId,int userId,bool isAttendance) async {
  BaseBean? res = await httpPut(context,
      url: '/event/attendance/checkin/confirm',
      queryParameters: {"eventId": eventId,"userId":userId,"isAttendance":isAttendance});
  if(res!=null){
    return res.code == 200;
  }else{
    return false;
  }
}


/// 用户签到
Future<bool> checkOut(BuildContext context,int eventId) async {
  BaseBean? res = await httpPut(context,
      url: '/event/checkout',
      queryParameters: {"eventId": eventId});
  if(res!=null){
    return res.code == 200;
  }else{
    return false;
  }
}

/// 用户签到历史
Future<List<CheckLogEntity>> checkHistory(BuildContext context,int page) async {
  BaseBean? res = await httpGet(context, url: '/event/check/history',queryParameters: {"page": page});
  if(res!=null){
    List<CheckLogEntity> resdata =res.data!['list'].map<CheckLogEntity>((e) => CheckLogEntity.fromJson(e)).toList();
    return resdata;
  }else{
    return [];
  }
}



/// 用户收到的通知
Future<List<NotificationEntity>> notificationList(BuildContext context,int page) async {
  BaseBean? res = await httpGet(context, url: '/notification/user/list',queryParameters: {"page": page});
  if(res!=null){
    List<NotificationEntity> resdata =res.data!['list'].map<NotificationEntity>((e) => NotificationEntity.fromJson(e)).toList();
    return resdata;
  }else{
    return [];
  }
}


/// 用户删除通知
Future<bool> notificationDelete(BuildContext context,List<int> ids) async {
  BaseBean? res = await httpPut(context,
      url: '/notification/user/delete',
      data: ids);
  if(res!=null){
    return res.code == 200;
  }else{
    return false;
  }
}


/// 用户已读通知
Future<bool> readNotification(BuildContext context,int notificationId) async {
  BaseBean? res = await httpPut(context,
      url: '/notification/read',
      queryParameters: {"notificationId":notificationId},
      silence: true);
  if(res!=null){
    return res.code == 200;
  }else{
    return false;
  }
}



/// 用户已读通知
Future<List<GuideLineEntity>> guideLine(BuildContext context) async {
  BaseBean? res = await httpGet(context, url: '/guide/line/list', silence: false);
  if(res!=null){
    return res.data.map<GuideLineEntity>((e) => GuideLineEntity.fromJson(e)).toList();
  }else{
    return [];
  }
}




/// app检查更新
Future<AppVersionEntity?> checkVersion(BuildContext context) async {
  BaseBean? res = await httpPost(context, url: '/app/history/last', queryParameters: {"appId":'8156387750412255232',"platform":Platform.operatingSystem}, silence: true);
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  AppVersionEntity appVersionEntity = AppVersionEntity.fromJson(res!.data);
  if(packageInfo.version != appVersionEntity.version){
    return appVersionEntity;
  }
  return null;
}


/// app检查更新
Future<AdvertisementEntity> advertisementPull(BuildContext context) async {
  BaseBean? res = await httpGet(context, url: '/advertisement/pull', silence: true);
  return AdvertisementEntity.fromJson(res!.data);
}

