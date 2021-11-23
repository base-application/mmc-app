import 'dart:async';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lottie/lottie.dart';
import 'package:mmc/router/auth_guard.dart';
import 'package:mmc/router/router.gr.dart';
import 'package:mmc/utils/comfun.dart';
import 'package:mmc/utils/event_bus.dart';
import 'package:mmc/utils/http_request.dart';
import 'package:mmc/utils/project_init.dart';
import 'package:provider/provider.dart';
import 'package:async/async.dart' show AsyncMemoizer;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'bean/home_index_info_entity.dart';
import 'bean/login_info_entity.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) { // 设置仅竖屏
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthService>(create: (BuildContext context) => AuthService()),
          ChangeNotifierProvider<SystemSetService>(create: (BuildContext context) => SystemSetService()),
          ChangeNotifierProvider<PersonalProfileService>(create: (BuildContext context) => PersonalProfileService()),
          ChangeNotifierProvider<HomeIndexDataService>(create: (BuildContext context) => HomeIndexDataService()),
        ],
        child: const MyApp(),
      ),
    );
  });

  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.custom
    ..animationStyle = EasyLoadingAnimationStyle.opacity
    ..contentPadding = const EdgeInsets.fromLTRB(20, 6, 20, 16)
    ..indicatorWidget = SizedBox(
      height: 40,
      width: 60,
      child: CustomPaint(
        child: Stack(
          children: <Widget>[
            Positioned(
              child: LottieBuilder.asset('assets/lottie/loading.json', width: 24, height: 24, fit: BoxFit.cover,),
              left: 10,
              bottom: 0,
            ),
          ],
        ),
      )
    )
    ..radius = 14
    ..textStyle = TextStyle(fontSize: 14 * ComFun.getTextScaleFactor(), fontWeight: FontWeight.bold, color: const Color(0xFF494949),)
    ..backgroundColor = Colors.white
    ..textColor = Colors.white
    ..indicatorColor = Colors.white
    ..progressColor = Colors.white
    ..boxShadow = <BoxShadow>[
      BoxShadow(
        blurRadius: 20,
        color: Colors.black.withAlpha(20),
      ),
    ]
    ..maskColor = Colors.white.withOpacity(0.1)
    ..maskType = EasyLoadingMaskType.black
    ..userInteractions = false
    ..dismissOnTap = true;
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final authService = AuthService();
  final _appRouter = AppRouter(
    authGuard: AuthGuard(),
  );

  late StreamSubscription _appLanguageChangeEvent; // 使用过程中登录token过期事件

  final AsyncMemoizer<bool> _memoization = AsyncMemoizer<bool>();

  bool _appLanguageChange = false;

  @override
  void initState() {
    ComFun.statusBar(isLight: false);
    super.initState();
    _appLanguageChangeEvent = eventBus.on<AppLanguageChangeEvent>().listen((_) async {
      _appLanguageChange = true;
      setState(() {});
    });
    //绑定用户推送ID
    ProjectInit.init(context);
  }

  @override
  void dispose() {
    _appLanguageChangeEvent.cancel();
    super.dispose();
  }

  Future<bool> _init() async {
    return _memoization.runOnce(() async {
      await initAppLanguageInfo(context);
      bool needToLogin = true; // 是否需要去到登录页面
      await SpUtil.getInstance();
      await initLoginInfo(context).then((LoginInfoEntity? userInfo) async {
        if (userInfo != null) {
          // 获取首页数据，如果获取成功，则进入主程序。否则进入登录页面
          await getIndexData(context, silence: true, result: (HomeIndexInfoEntity info) {
            context.read<HomeIndexDataService>().setHomeIndexInfo(info);
            initPersonalProfileInfo(context, userInfo.id);
            needToLogin = false;
          }, err: () {
            ComFun.showAppBadge(0);
            saveLoginInfo(context, null);
            needToLogin = true;
          });
        } else {
          ComFun.showAppBadge(0);
          // 没有保存用户登陆信息，重新去登陆
          needToLogin = true;
        }
      });
      context.read<AuthService>().setAuthenticated(!needToLogin);
      return needToLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _init(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!_appLanguageChange && snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(home: Splash(),);
        }
        _appLanguageChange = false;
        return MaterialApp.router(
          theme: ThemeData.light(),
          routerDelegate: _appRouter.delegate(),
          routeInformationProvider: _appRouter.routeInfoProvider(),
          routeInformationParser: _appRouter.defaultRouteParser(),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            AppLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
            Locale('zh', ''),
          ],
          locale: Locale.fromSubtags(languageCode: context.read<SystemSetService>().appLanguage),
          builder: (_, router) {
            return FlutterEasyLoading(child: Scaffold(
              backgroundColor: const Color(0xFFEAEAEA),
              resizeToAvoidBottomInset: false,
              body: GestureDetector(
                child: router!,
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
              ),
            ));
          },
        );
      }
    );
  }
}

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Image.asset('assets/image/app_launch.png', fit: BoxFit.fill,),
      ),
    );
  }
}
