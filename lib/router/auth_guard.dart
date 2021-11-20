import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:mmc/bean/home_index_info_entity.dart';
import 'package:mmc/bean/login_info_entity.dart';
import 'package:mmc/bean/personal_profile_info_entity.dart';
import 'package:mmc/router/router.gr.dart';

bool isAuthenticated = false;
class AuthGuard extends AutoRouteGuard {

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    debugPrint('路由守卫：${router.current.name} 是否已登录 > $isAuthenticated');
    if (!isAuthenticated) {
      router.push(
        LoginRoute(onLoginSuccess: (_) {
          resolver.next();
          router.popForced();
        }),
      );
    } else {
      resolver.next(true);
    }
  }
}

class AuthService extends ChangeNotifier {
  LoginInfoEntity? _loginInfo;

  String? get token {
    return _loginInfo?.token;
  }

  LoginInfoEntity? get getLoginInfo => _loginInfo;

  setLoginInfo(LoginInfoEntity? loginInfo) {
    _loginInfo = loginInfo;
    isAuthenticated = _loginInfo != null;
    notifyListeners();
  }

  setAvatar(String? avatar) {
    _loginInfo?.avatar = avatar;
    notifyListeners();
  }

  setAuthenticated(bool isAuth) {
    isAuthenticated = isAuth;
    notifyListeners();
  }
}

class PersonalProfileService extends ChangeNotifier {
  PersonalProfileInfoEntity? _personalProfileInfo;

  PersonalProfileInfoEntity? get getPersonalProfileInfo => _personalProfileInfo;

  setPersonalProfileInfo(PersonalProfileInfoEntity? personalProfileInfo) {
    _personalProfileInfo = personalProfileInfo;
    notifyListeners();
  }
}

class SystemSetService extends ChangeNotifier {
  // String baseUrl = 'http://192.168.0.9:8005/mmc/';
  // String baseUrl = 'http://wanghuiwen.com:9090/mock/122/mmc/';
  String baseUrl = 'http://47.107.84.246/mmc/api/';

  String appLanguage = 'en';

  /// en、zh
  setAppLanguage(String language) {
    appLanguage = language;
    notifyListeners();
  }
}

/// 完全静默的接口请求
/// 请求出错的时候，不会有任何提示
List<String> quietRequest = [
  'countries',
];

class HomeIndexDataService extends ChangeNotifier {
  HomeIndexInfoEntity? _homeIndexInfo;

  HomeIndexInfoEntity? get getHomeIndexInfo => _homeIndexInfo;

  setHomeIndexInfo(HomeIndexInfoEntity? homeIndexInfo) {
    _homeIndexInfo = homeIndexInfo;
    notifyListeners();
  }
}
