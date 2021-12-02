import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_actions/external/platform_check/platform_check.dart';
import 'package:mmc/bean/login_info_entity.dart';
import 'package:mmc/bean/personal_profile_info_entity.dart';
import 'package:mmc/router/auth_guard.dart';
import 'package:mmc/router/router.gr.dart';
import 'package:mmc/utils/dialog.dart';
import 'package:mmc/widget/app_bar_home_default.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import 'event_bus.dart';

class ComFun {
  /// 状态栏样式 沉浸式状态栏
  static statusBar({ required bool isLight }) {
    // 白色沉浸式状态栏颜色  白色文字
    SystemUiOverlayStyle light = const SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xFFFFFFFF),
      systemNavigationBarDividerColor: null,
      /// 注意安卓要想实现沉浸式的状态栏 需要底部设置透明色
      statusBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    );

    // 黑色沉浸式状态栏颜色 黑色文字
    SystemUiOverlayStyle dark = const SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xFFFFFFFF),
      systemNavigationBarDividerColor: null,
      /// 注意安卓要想实现沉浸式的状态栏 需要底部设置透明色
      statusBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    );

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [ SystemUiOverlay.top ]);
    isLight ? SystemChrome.setSystemUIOverlayStyle(light) : SystemChrome.setSystemUIOverlayStyle(dark);
  }

  /// 获取页面字体缩放比
  static double getTextScaleFactor() {
    return PlatformCheck.isAndroid ? 0.86 : 0.92;
  }

  /// 显示toast弹框
  static showToast({ required String msg, bool err = false }) {
    Fluttertoast.cancel();
    if (!err) {
      Fluttertoast.showToast(
        msg: msg,
        toastLength: err ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color.fromARGB(255, 177, 225, 231),
        textColor: Colors.black87,
        fontSize: 13 * ComFun.getTextScaleFactor(),
      );
    } else {
      Fluttertoast.showToast(
        msg: msg,
        toastLength: err ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color.fromARGB(255, 232, 194, 192),
        textColor: Colors.black87,
        fontSize: 13 * ComFun.getTextScaleFactor(),
      );
    }
  }

  /// 显示桌面角标
  static Future showAppBadge(int num) async {
    await SpUtil.getInstance();
    FlutterAppBadger.isAppBadgeSupported().then((supported) {
      if (supported) {
        if (num > 0) {
          FlutterAppBadger.updateBadgeCount(num);
        } else {
          FlutterAppBadger.removeBadge();
        }
      }
    });
  }

  /// 退出登录
  static Future outLogin(BuildContext context) async {
    await savePersonalProfileInfo(context, context.read<AuthService>().getLoginInfo!.id, null);
    await saveLoginInfo(context, null);
    AutoRouter.of(context).replaceAll([
      LoginRoute(onLoginSuccess: (ctx) {
        AutoRouter.of(ctx).replaceAll([const HomeRoute()]);
      })
    ]);
  }


  static void confirm(BuildContext context,Function() confirm,String text){
    showDialog(
      context: context,
      barrierColor: Colors.black.withAlpha(180),
      barrierDismissible: true,
      builder: (BuildContext context) {
        return DialogWidget(
          title: '',
          content: '',
          slideMargin: 4,
          showTitle: false,
          showBottomDo: false,
          borderRadius: 14,
          outTapDismiss: true,
          contentExtend: Row(
            children: [
              Expanded(child: Column(
                children: [
                  const SizedBox(height: 30,),
                  Text(text, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600,), textAlign: TextAlign.center,),
                  const SizedBox(height: 50,),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 130,
                        height: 48,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(const Color(0xFFFBB714)),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                            elevation: MaterialStateProperty.all(0),
                          ),
                          child: Text(AppLocalizations.of(context)!.yes, style: const TextStyle(color: Color(0xFF002A67), fontSize: 17, fontWeight: FontWeight.w600, letterSpacing: 0.2),),
                          onPressed: () {
                            Navigator.of(context).pop();
                            confirm();
                          },
                        ),
                      ),
                      const SizedBox(width: 20,),
                      Container(
                        width: 130,
                        height: 48,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: const Color(0xFF346295)),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                            elevation: MaterialStateProperty.all(0),
                          ),
                          child: Text(AppLocalizations.of(context)!.cancel, style: const TextStyle(color: Color(0xFF002A67), fontSize: 17, fontWeight: FontWeight.w600, letterSpacing: 0.2),),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40,),
                ],
              )),
            ],
          ),
        );
      },
    );
  }
}

/// 保存登录用户信息
/// 登录成功后调用
saveLoginInfo(BuildContext context, LoginInfoEntity? info) async {
  await SpUtil.getInstance();
  if (info != null) {
    SpUtil.putObject('loginAbout', info.toJson());
    context.read<AuthService>().setLoginInfo(info);
  } else {
    SpUtil.remove('loginAbout');
    context.read<AuthService>().setLoginInfo(null);
  }
}
/// 初始化并获取登录用户信息
/// 未登录则返回 NULL
Future<LoginInfoEntity?> initLoginInfo(BuildContext context) async {
  await SpUtil.getInstance();
  var loginAbout = SpUtil.getObject('loginAbout');
  if (loginAbout != null) {
    context.read<AuthService>().setLoginInfo(LoginInfoEntity.fromJson(loginAbout as Map<String, dynamic>));
    return context.read<AuthService>().getLoginInfo;
  }
  return null;
}

/// 保存登录用户个人资料信息
savePersonalProfileInfo(BuildContext context, int userId, PersonalProfileInfoEntity? info) async {
  await SpUtil.getInstance();
  if (info != null) {
    SpUtil.putObject('personalProfile-$userId', info.toJson());
    context.read<PersonalProfileService>().setPersonalProfileInfo(info);
  } else {
    SpUtil.remove('personalProfile-$userId');
    context.read<PersonalProfileService>().setPersonalProfileInfo(null);
  }
}
Future<PersonalProfileInfoEntity?> initPersonalProfileInfo(BuildContext context, int userId) async {
  await SpUtil.getInstance();
  var personalProfileAbout = SpUtil.getObject('personalProfile-$userId');
  if (personalProfileAbout != null) {
    context.read<PersonalProfileService>().setPersonalProfileInfo(PersonalProfileInfoEntity.fromJson(personalProfileAbout as Map<String, dynamic>));
    return context.read<PersonalProfileService>().getPersonalProfileInfo;
  }
  return null;
}

/// 保存修改应用语言设置
changeAppLanguageInfo(BuildContext context, { String language = 'en' }) async {
  await SpUtil.getInstance();
  SpUtil.putString('appLanguage', language);
  context.read<SystemSetService>().setAppLanguage(language);
  eventBus.fire(AppLanguageChangeEvent());
}
/// 初始化应用语言设置
initAppLanguageInfo(BuildContext context) async {
  await SpUtil.getInstance();
  var appLanguage = SpUtil.getString('appLanguage');
  context.read<SystemSetService>().setAppLanguage(appLanguage != null && appLanguage != '' ? appLanguage : 'en');
}

/// 自定义behavior
/// ScrollConfiguration包裹ListView去除滑动蓝色波纹
class CusBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    if (PlatformCheck.isAndroid || PlatformCheck.isIOS) return child;
    return super.buildOverscrollIndicator(context, child, details);
  }
}

class MenuDoItem {
  final String iconAssets;
  final String label;
  final Function? onTap;

  const MenuDoItem({ required this.iconAssets, required this.label, this.onTap });
}

class PageContainer extends StatelessWidget {
  const PageContainer({
    Key? key,
    required this.title,
    required this.body,
    this.titleBarBgColor,
    this.rightBtn,
    this.appBarType,
    this.pageBg,
    this.resizeToAvoidBottomInset = false,
    this.onRefresh,
    this.bodyTop,
    this.startDrawer,
    this.onStartDrawerChanged,
    this.endDrawer,
    this.onEndDrawerChanged,
  }) : super(key: key);

  final String title;
  final Color? titleBarBgColor;

  final RightBtn? rightBtn;

  final AppBarType? appBarType;
  final Color? pageBg;
  final bool resizeToAvoidBottomInset;

  final Widget body;
  final Widget? bodyTop;

  final RefreshCallback? onRefresh;

  final Widget? startDrawer;
  final DrawerCallback? onStartDrawerChanged;
  final Widget? endDrawer;
  final DrawerCallback? onEndDrawerChanged;

  @override
  Widget build(BuildContext context) {
    Widget _body() {
      return body;
    }
    PreferredSizeWidget appBarWidget() {
      switch (appBarType) {
        case AppBarType.typeSearch:
        default:
          return HomeDefaultAppBar(
            title: title,
            rightBtn: rightBtn,
            bgColor: titleBarBgColor,
          );
      }
    }

    Widget _mainBody() {
      if (onRefresh != null) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            if (bodyTop != null) bodyTop!,
            Expanded(child: RefreshIndicator(
              displacement: 20,
              color: const Color.fromARGB(245, 44, 163, 184),
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              child: ScrollConfiguration(
                behavior: CusBehavior(),
                child: _body(),
              ),
              onRefresh: onRefresh!,
            ),),
          ],
        );
      }
      return bodyTop != null ? Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          bodyTop!,
          Expanded(child: _body()),
        ],
      ) : _body();
    }

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaleFactor: ComFun.getTextScaleFactor(),
      ),
      child: Scaffold(
        key: key,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        backgroundColor: pageBg ?? const Color(0xFFF7F7F7),
        appBar: appBarWidget(),
        body: _mainBody(),
        drawer: startDrawer,
        drawerEnableOpenDragGesture: false,
        onDrawerChanged: onStartDrawerChanged,
        endDrawer: endDrawer,
        endDrawerEnableOpenDragGesture: false,
        onEndDrawerChanged: onEndDrawerChanged,
      ),
    );
  }
}

/// 顶部标题栏类型
enum AppBarType {
  /// 默认标题栏
  typeDefault,
  /// 搜索样式的标题栏
  typeSearch,
}

extension ExtensionInt on int? {
  String? formatNumber({ int counts = 3, String mark = ',' }) {
    if (this == null) {
      return null;
    }
    List<String> tempAry = toString().split('').reversed.toList();
    List<String> res = [];
    for (int i = 0, len = tempAry.length; i < len; i++) {
      if (i % counts == 0 && i != 0) {
        res.add(mark);
      }
      res.add(tempAry[i]);
    }
    res = res.reversed.toList();
    return res.join('');
  }
}

extension ExtensionDouble on double? {
  String? formatNumber({ int counts = 3, String mark = ',' }) {
    if (this == null) {
      return null;
    }
    List<String> num = toString().split('.');
    List<String> tempAry = num[0].split('').reversed.toList();
    List<String> res = [];
    for (int i = 0, len = tempAry.length; i < len; i++) {
      if (i % counts == 0 && i != 0) {
        res.add(mark);
      }
      res.add(tempAry[i]);
    }
    res = res.reversed.toList();
    if (num.length > 1) {
      return res.join('') + '.${num[1]}';
    }
    return res.join('');
  }
  String? formatPercentage() {
    if (this == null) {
      return null;
    }
    return (this! * 100).toStringAsFixed(2);
  }
}
