import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:keyboard_actions/external/platform_check/platform_check.dart';
import 'package:mmc/router/auth_guard.dart';
import 'package:mmc/router/router.gr.dart';
import 'package:mmc/screens/checkin_page.dart';
import 'package:mmc/screens/index_page.dart';
import 'package:mmc/screens/network_page.dart';
import 'package:mmc/screens/profile_page.dart';
import 'package:mmc/utils/comfun.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

import 'app_bar_home_default.dart';

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NavigatorPageState();
  }
}

class _NavigatorPageState extends State<NavigatorPage> {
  GlobalKey<HomeDefaultAppBarState> childKeyHomeAppBarDefault = GlobalKey();
  DateTime? _lastPressedAt; // 退出 上一次点击的时间
  int _currentIndex = 0;

  final pageController = PageController(initialPage: 0);

  CustomAnimationControl _bottomNavigatorAnimControl = CustomAnimationControl.stop;

  List<Widget> _tabBodies() {
    return [
      IndexPage(pageScrollDirectionChange: (ScrollDirection scrollDirection) {
        if (scrollDirection == ScrollDirection.forward) {
          if (_bottomNavigatorAnimControl != CustomAnimationControl.playReverse) {
            setState(() {
              _bottomNavigatorAnimControl = CustomAnimationControl.playReverse;
            });
          }
        } else if (scrollDirection == ScrollDirection.reverse) {
          if (_bottomNavigatorAnimControl != CustomAnimationControl.play) {
            setState(() {
              _bottomNavigatorAnimControl = CustomAnimationControl.play;
            });
          }
        }
      },),
      NetworkPage(onlyMy: false,pageScrollDirectionChange: (ScrollDirection scrollDirection) {
        if (scrollDirection == ScrollDirection.forward) {
          if (_bottomNavigatorAnimControl != CustomAnimationControl.playReverse) {
            setState(() {
              _bottomNavigatorAnimControl = CustomAnimationControl.playReverse;
            });
          }
        } else if (scrollDirection == ScrollDirection.reverse) {
          if (_bottomNavigatorAnimControl != CustomAnimationControl.play) {
            setState(() {
              _bottomNavigatorAnimControl = CustomAnimationControl.play;
            });
          }
        }
      }, title: AppLocalizations.of(context)!.netWork,),
      CheckInPage(pageScrollDirectionChange: (ScrollDirection scrollDirection) {
        if (scrollDirection == ScrollDirection.forward) {
          if (_bottomNavigatorAnimControl != CustomAnimationControl.playReverse) {
            setState(() {
              _bottomNavigatorAnimControl = CustomAnimationControl.playReverse;
            });
          }
        } else if (scrollDirection == ScrollDirection.reverse) {
          if (_bottomNavigatorAnimControl != CustomAnimationControl.play) {
            setState(() {
              _bottomNavigatorAnimControl = CustomAnimationControl.play;
            });
          }
        }
      },),
      ProfilePage(pageScrollDirectionChange: (ScrollDirection scrollDirection) {
        if (scrollDirection == ScrollDirection.forward) {
          if (_bottomNavigatorAnimControl != CustomAnimationControl.playReverse) {
            setState(() {
              _bottomNavigatorAnimControl = CustomAnimationControl.playReverse;
            });
          }
        } else if (scrollDirection == ScrollDirection.reverse) {
          if (_bottomNavigatorAnimControl != CustomAnimationControl.play) {
            setState(() {
              _bottomNavigatorAnimControl = CustomAnimationControl.play;
            });
          }
        }
      },),
    ];
  }

  /// 获取导航菜单图标地址
  String _getItemImageAssets(int index) {
    switch (index) {
      case 0:
        return 'assets/icon/home.png';
      case 1:
        return 'assets/icon/network.png';
      case 2:
        return 'assets/icon/check_in.png';
      case 3:
        return 'assets/icon/profile.png';
    }
    return 'assets/image/home.png';
  }
  String _homeTitle(int index) {
    switch (index) {
      case 0:
        return AppLocalizations.of(context)!.appNavigatorHome;
      case 1:
        return AppLocalizations.of(context)!.appNavigatorNetwork;
      case 2:
        return AppLocalizations.of(context)!.appNavigatorCheckIn;
      case 3:
        return AppLocalizations.of(context)!.appNavigatorProfile;
    }
    return AppLocalizations.of(context)!.appNavigatorHome;
  }

  Widget _getItem(int index) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          color: _currentIndex == index ? const Color(0xFFFBB714) : null,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment:MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(_getItemImageAssets(index), width: 22, height: 22, color: _currentIndex == index ? const Color(0xFF013B7B) : const Color(0xFFD3D6E2), colorBlendMode: BlendMode.srcATop,),
              const SizedBox(height: 6,),
              Text(_homeTitle(index), style: TextStyle(fontSize: 15, fontWeight: _currentIndex == index ? FontWeight.bold : FontWeight.w400, color: _currentIndex == index ? const Color(0xFF013B7B) : const Color(0xFFD3D6E2)),),
            ],
          ),
        ),
        onTap: () {
          ///除了home都要登陆
          if(index != 0){
            if(context.read<AuthService>().getLoginInfo?.token == null){
              AutoRouter.of(context).push(SignUpRoute(type: 1));
              return;
            }
          }
          setState(() {
            _currentIndex = index;
          });
          childKeyHomeAppBarDefault.currentState?.changeNavigationTo(index);
          pageController.jumpToPage(index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget _bottomNavigator() {
      return Material(
        elevation: 8,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).padding.bottom != 0 ? MediaQuery.of(context).padding.bottom + 66 : 66,
          padding: EdgeInsets.only(left: 12, right: 12, bottom: MediaQuery.of(context).padding.bottom != 0 ? MediaQuery.of(context).padding.bottom : 0),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF043B94),
                Color(0xFF0D66E5),
              ],
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment:MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [0, 1, 2, 3].map((i) => _getItem(i)).toList(),
          ),
        ),
      );
    }
    Widget _page() {
      return Stack(
        children: [
          Positioned.fill(
              child: PageView(
              controller: pageController,
              onPageChanged: (int index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              children: _tabBodies(),

              physics: const NeverScrollableScrollPhysics(), // 禁止滑动
          )),
          Positioned(
            child: CustomAnimation<double>(
              control: _bottomNavigatorAnimControl,
              duration: const Duration(milliseconds: 300),
              tween: (0.0).tweenTo(100.0),
              builder: (context, child, value) {
                return Transform.translate(
                  offset: Offset(0, value),
                  child: child,
                );
              },
              child: Transform.translate(
                offset: const Offset(0, 0),
                child: _bottomNavigator(),
              ),
            ),
            bottom: 0,
          ),
        ],
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PlatformCheck.isAndroid ? WillPopScope(
        child: _page(),
        onWillPop: () async {
          if (EasyLoading.isShow) {
            EasyLoading.dismiss(animation: true);
            return Future.value(false);
          }
          if (_lastPressedAt == null || DateTime.now().difference(_lastPressedAt!) > const Duration(seconds: 3)) {
            _lastPressedAt = DateTime.now();
            ComFun.showToast(msg: AppLocalizations.of(context)!.exit);
            return Future.value(false);
          }
          return Future.value(true);
        }
      ) : _page(),

    );
  }
}
