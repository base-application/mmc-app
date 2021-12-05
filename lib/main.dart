
import 'package:auto_route/auto_route.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lottie/lottie.dart';
import 'package:mmc/router/auth_guard.dart';
import 'package:mmc/router/router.gr.dart';
import 'package:mmc/utils/comfun.dart';
import 'package:mmc/utils/project_init.dart';
import 'package:provider/provider.dart';
import 'package:async/async.dart' show AsyncMemoizer;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) { // 设置仅竖屏
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthService>(create: (BuildContext context) => AuthService()),
          ChangeNotifierProvider<SystemSetService>(create: (BuildContext context) => SystemSetService()),
          ChangeNotifierProvider<PersonalProfileService>(create: (BuildContext context) => PersonalProfileService()),
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
    navigatorKey:ComFun.navigatorKey,
    authGuard: AuthGuard(),
  );

  final AsyncMemoizer<bool> _memoization = AsyncMemoizer<bool>();

  FirebaseAnalytics analytics = FirebaseAnalytics();

  @override
  void initState() {
    ComFun.statusBar(isLight: false);
    super.initState();
    ProjectInit.init(context);
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "MMC",
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.transparent,
          ),
          centerTitle: true,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Color(0xff000000),
          ),
          titleTextStyle:TextStyle(fontSize: 20, color: Colors.black87, fontWeight: FontWeight.bold,),
        ),
      ),
      routerDelegate: AutoRouterDelegate(
          _appRouter,
          navigatorObservers: ()=>[FirebaseAnalyticsObserver(analytics: analytics,nameExtractor : ( RouteSettings settings){return settings.name;})]
      ),
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
      locale: Locale.fromSubtags(languageCode: context.watch<SystemSetService>().appLanguage),
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
}
