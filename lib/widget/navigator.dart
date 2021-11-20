import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/style/picker_style.dart';
import 'package:keyboard_actions/external/platform_check/platform_check.dart';
import 'package:mmc/bean/home_index_info_entity.dart';
import 'package:mmc/bean/state_item_info_entity.dart';
import 'package:mmc/router/auth_guard.dart';
import 'package:mmc/router/router.gr.dart';
import 'package:mmc/screens/checkin_page.dart';
import 'package:mmc/screens/index_page.dart';
import 'package:mmc/screens/login.dart';
import 'package:mmc/screens/network_page.dart';
import 'package:mmc/screens/profile_page.dart';
import 'package:mmc/utils/comfun.dart';
import 'package:mmc/utils/http_request.dart';
import 'package:provider/src/provider.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'app_bar_home.dart';
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

  String? _filterIndustry;
  CountryCodeInfo? _filterCountry;
  StateItemInfoEntity? _filterCity;
  List<StateItemInfoEntity> _aboutCity = [];

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
      NetworkPage(key: networkPageKey, pageScrollDirectionChange: (ScrollDirection scrollDirection) {
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
          if (index == 0) {
            getIndexData(context, silence: true, result: (HomeIndexInfoEntity info) {
              context.read<HomeIndexDataService>().setHomeIndexInfo(info);
            });
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
          Positioned.fill(child: PageView(
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

    PreferredSizeWidget? _appBar() {
      if (_currentIndex == 0) {
        return const HomeAppBar();
      }
      return HomeDefaultAppBar(key: childKeyHomeAppBarDefault, initPageIndex: _currentIndex, rightBtn: ({ int? homeIndex }) {
        switch (homeIndex) {
          case 1:
            return {
              Image.asset('assets/icon/app_bar_filter.png', width: 20, height: 20,): (BuildContext ctx) {
                Scaffold.of(ctx).openEndDrawer();
              },
            };
          case 3:
            return {
              Badge(
                animationType: BadgeAnimationType.fade,
                showBadge: true,
                position: const BadgePosition(top: -4, start: 12),
                padding: const EdgeInsets.all(5),
                child: Image.asset('assets/icon/app_bar_ring.png', width: 20, height: 20,),
              ): (BuildContext ctx) async {
                AutoRouter.of(context).push(const MyInboxRoute());
              },
              Image.asset('assets/icon/app_bar_set.png', width: 20, height: 20,): (BuildContext ctx) async {
                AutoRouter.of(context).push(const SettingRoute());
              },
            };
        }
        return null;
      },);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appBar(),
      body: PlatformCheck.isAndroid ? WillPopScope(
        child: _page(),
        onWillPop: () async {
          if (EasyLoading.isShow) {
            EasyLoading.dismiss(animation: true);
            return Future.value(false);
          }
          if (_lastPressedAt == null || DateTime.now().difference(_lastPressedAt!) > const Duration(seconds: 3)) {
            _lastPressedAt = DateTime.now();
            ComFun.showToast(msg: '再按一次退出');
            return Future.value(false);
          }
          return Future.value(true);
        }
      ) : _page(),
      endDrawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          padding: const EdgeInsets.only(top: 20, left: 26, right: 26,),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Text(AppLocalizations.of(context)!.appHomeNetworkFilterTitle, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500,),),
              const SizedBox(height: 40,),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppLocalizations.of(context)!.filterNetworkIndustryLabel, style: TextStyle(fontSize: 14, color: Colors.black87.withAlpha(200),),),
                      const SizedBox(height: 8,),
                      GestureDetector(
                        child: Container(
                          width: double.infinity,
                          height: 44,
                          padding: const EdgeInsets.only(left: 14, right: 10,),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 0.6, color: Colors.grey.shade300,)
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(_filterIndustry ?? AppLocalizations.of(context)!.filterNetworkIndustry, style: TextStyle(fontSize: 14, color: _filterIndustry == null ? Colors.black38 : Colors.black87,), overflow: TextOverflow.ellipsis,),
                              ),
                              const Icon(Icons.arrow_drop_down_rounded, size: 22, color: Colors.black54,),
                            ],
                          ),
                        ),
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          _chooseIndustry();
                        },
                      ),
                    ],
                  ),),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppLocalizations.of(context)!.filterNetworkCountryLabel, style: TextStyle(fontSize: 14, color: Colors.black87.withAlpha(200),),),
                      const SizedBox(height: 8,),
                      GestureDetector(
                        child: Container(
                          width: double.infinity,
                          height: 44,
                          padding: const EdgeInsets.only(left: 14, right: 10,),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 0.6, color: Colors.grey.shade300,)
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(_filterCountry?.nativeName ?? AppLocalizations.of(context)!.filterNetworkCountry, style: TextStyle(fontSize: 14, color: _filterCountry == null ? Colors.black38 : Colors.black87,), overflow: TextOverflow.ellipsis,),
                              ),
                              const Icon(Icons.arrow_drop_down_rounded, size: 22, color: Colors.black54,),
                            ],
                          ),
                        ),
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          _chooseCountry();
                        },
                      ),
                    ],
                  ),),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppLocalizations.of(context)!.filterNetworkCityLabel, style: TextStyle(fontSize: 14, color: Colors.black87.withAlpha(200),),),
                      const SizedBox(height: 8,),
                      GestureDetector(
                        child: Container(
                          width: double.infinity,
                          height: 44,
                          padding: const EdgeInsets.only(left: 14, right: 10,),
                          decoration: BoxDecoration(
                              color: _aboutCity.isNotEmpty ? Colors.white : Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 0.6, color: Colors.grey.shade300,)
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(_filterCity?.name ?? AppLocalizations.of(context)!.filterNetworkCity, style: TextStyle(fontSize: 14, color: _filterCity == null ? Colors.black38 : Colors.black87,), overflow: TextOverflow.ellipsis,),
                              ),
                              const Icon(Icons.arrow_drop_down_rounded, size: 22, color: Colors.black54,),
                            ],
                          ),
                        ),
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          _chooseState();
                        },
                      ),
                    ],
                  ),),
                ],
              ),
              const SizedBox(height: 40,),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 46,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(const Color(0xFFFBB714)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                    elevation: MaterialStateProperty.all(0),
                  ),
                  child: Text(AppLocalizations.of(context)!.filterNetworkApplyFilterBtn, style: const TextStyle(color: Color(0xFF013B7B), fontWeight: FontWeight.w500,),),
                  onPressed: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    bool filterOk = await networkPageKey.currentState?.doFilter(
                      industry: _filterIndustry,
                      country: _filterCountry,
                      city: _filterCity,
                    ) ?? false;
                    if (filterOk) {
                      Navigator.of(context).pop();
                    }
                  },
                )
              ),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(AppLocalizations.of(context)!.filterNetworkFilterClearBtn, style: const TextStyle(color: Color(
                      0xFFE2A60A)),),
                ),
                behavior: HitTestBehavior.opaque,
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  _filterCountry = null;
                  _filterCity = null;
                  _filterIndustry = null;
                  setState(() {});
                  bool filterOk = await networkPageKey.currentState?.doFilter(isClear: true) ?? false;
                  if (filterOk) {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
      endDrawerEnableOpenDragGesture: false,
    );
  }

  /// 选择国家
  _chooseCountry() {
    getCountryCodeData(context, silence: false, result: (List<CountryCodeInfo> list) {
      Pickers.showSinglePicker(context,
        data: list.map((e) => e.nativeName).toList(),
        selectData: _filterCountry?.nativeName,
        pickerStyle: PickerStyle(
          showTitleBar: true,
          backgroundColor: Colors.white,
          textColor: Colors.black87,
          pickerHeight: MediaQuery.of(context).size.height * 0.4,
          menuHeight: MediaQuery.of(context).size.height * 0.4,
        ),
        onConfirm: (res, position) {
          setState(() {
            _filterCountry = list[position];
            _filterCity = null;
          });
          _getStateData();
        },
      );
    });
  }

  _getStateData() {
    getStateDataByCountryCode(context, silence: true, countryCode: _filterCountry!.iso2, result: (List<StateItemInfoEntity> list) {
      setState(() {
        _aboutCity = list;
      });
    });
  }

  /// 选择城市
  _chooseState() {
    if (_aboutCity.isNotEmpty) {
      Pickers.showSinglePicker(context,
        data: _aboutCity.map((e) => e.name).toList(),
        selectData: _filterCity?.name,
        pickerStyle: PickerStyle(
          backgroundColor: Colors.white,
          textColor: Colors.black87,
          pickerHeight: MediaQuery.of(context).size.height * 0.4,
          menuHeight: MediaQuery.of(context).size.height * 0.4,
        ),
        onConfirm: (res, position) {
          setState(() {
            _filterCity = _aboutCity[position];
          });
        },
      );
    }
  }

  /// 选择行业
  _chooseIndustry() {
    getIndustryData(context, silence: false, result: (List<String> industryList) {
      Pickers.showSinglePicker(context,
        data: industryList,
        selectData: _filterIndustry,
        pickerStyle: PickerStyle(
          backgroundColor: Colors.white,
          textColor: Colors.black87,
          pickerHeight: MediaQuery.of(context).size.height * 0.4,
          menuHeight: MediaQuery.of(context).size.height * 0.4,
        ),
        onConfirm: (res, position) {
          setState(() {
            _filterIndustry = res;
          });
        },
      );
    });
  }
}
