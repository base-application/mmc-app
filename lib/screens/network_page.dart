import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/style/picker_style.dart';
import 'package:mmc/bean/network_item_info_entity.dart';
import 'package:mmc/bean/state_item_info_entity.dart';
import 'package:mmc/router/router.gr.dart';
import 'package:mmc/utils/comfun.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mmc/utils/comm_widget.dart';
import 'package:mmc/utils/dialog.dart';
import 'package:mmc/utils/event_bus.dart';
import 'package:mmc/utils/http_request.dart';

import 'login.dart';

class NetworkPage extends StatefulWidget {
  final bool onlyMy;
  const NetworkPage({Key? key, this.pageScrollDirectionChange, required this.onlyMy}) : super(key: key);

  final Function(ScrollDirection scrollDirection)? pageScrollDirectionChange;

  @override
  State<StatefulWidget> createState() {
    return _NetworkPageState();
  }
}

class _NetworkPageState extends State<NetworkPage> {
  final ScrollController _pageScrollController = ScrollController();

  final TextEditingController _nameSearchController = TextEditingController();

  String? _filterIndustry;
  CountryCodeInfo? _filterCountry;
  StateItemInfoEntity? _filterCity;
  List<StateItemInfoEntity> _aboutCity = [];

  /// 进行数据筛选
  Future<bool> doFilter({ bool isClear = false, String? industry, CountryCodeInfo? country, StateItemInfoEntity? city }) async {
    if (isClear) {
      _filterIndustry = null;
      _filterCountry = null;
      _filterCity = null;
    } else {
      _filterIndustry = industry;
      _filterCountry = country;
      _filterCity = city;
    }
    _getPageData(name: _nameSearchController.text.trim());
    return !isClear;
  }

  List<NetworkItemInfoEntity> pageList = [];

  late StreamSubscription _followUserStateChangeEvent;

  @override
  void initState() {
    super.initState();
    _followUserStateChangeEvent = eventBus.on<FollowUserStateChangeEvent>().listen((event) async {
      List<NetworkItemInfoEntity> n = pageList.where((element) => element.userId == event.userId).toList();
      if (n.isNotEmpty) {
        setState(() {
          n.first.isFriend = event.isFollow;
        });
      }
    });
    _getPageData();
  }

  @override
  void dispose() {
    _followUserStateChangeEvent.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget _scrollMain = Container(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height
      ),
      color: Colors.white,
      child: pageList.isEmpty ? stateNoDate(inRef: true) : GridView.builder(
        controller: _pageScrollController,
        padding: EdgeInsets.zero.copyWith(top: 16, bottom: 30, left: 22, right: 22,),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 3 / 4,
        ),
        itemCount: pageList.length,
        itemBuilder: (BuildContext context, int index) {
          NetworkItemInfoEntity itemInfo = pageList[index];
          return GestureDetector(
            child: Container(
              padding: const EdgeInsets.only(top: 10, left: 14, right: 14,),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xFF043484),
                    Color(0xFF2B5BDC),
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      netImgWrap(context,
                        width: 66,
                        height: 66,
                        radius: 66,
                        url: itemInfo.picture,
                        errorWidget: Image.asset('assets/image/personal_head_empty.png', fit: BoxFit.fitWidth, width: 66, height: 66,),
                      ),
                      GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Image.asset(itemInfo.isFriend == true ? 'assets/icon/item_like.png' : 'assets/icon/item_no_like.png', width: 22, height: 22,),
                        ),
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          showDialog(
                            context: context,
                            barrierColor: Colors.black.withAlpha(180),
                            barrierDismissible: true,
                            builder: (BuildContext ctx) {
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
                                        Padding(
                                          padding: const EdgeInsets.only(left: 14, right: 14,),
                                          child: Text(itemInfo.isFriend == true ? AppLocalizations.of(ctx)!.confirmUndoApplyFriend : AppLocalizations.of(ctx)!.confirmApplyFriend, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600,), textAlign: TextAlign.center,),
                                        ),
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
                                                child: Text(AppLocalizations.of(ctx)!.yes, style: const TextStyle(color: Color(0xFF002A67), fontSize: 17, fontWeight: FontWeight.w600, letterSpacing: 0.2),),
                                                onPressed: () {
                                                  Navigator.of(ctx).pop();
                                                  userFollowAdd(context, userId: itemInfo.userId, result: () {
                                                    ComFun.showToast(msg: itemInfo.isFriend == true ? AppLocalizations.of(context)!.friendUndoApplySuccessToast : AppLocalizations.of(context)!.friendApplySuccessToast);
                                                    setState(() {
                                                      itemInfo.isFriend = !(itemInfo.isFriend == true);
                                                    });
                                                  });
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
                                                child: Text(AppLocalizations.of(ctx)!.cancel, style: const TextStyle(color: Color(0xFF002A67), fontSize: 17, fontWeight: FontWeight.w600, letterSpacing: 0.2),),
                                                onPressed: () {
                                                  Navigator.of(ctx).pop();
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
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 14,),
                  Text(itemInfo.name ?? '', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFFFBB714)),),
                  const SizedBox(height: 12,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (itemInfo.industry != null) Text(itemInfo.industry ?? '', style: const TextStyle(fontSize: 13, color: Colors.white,), maxLines: 3, overflow: TextOverflow.ellipsis,),
                        if (itemInfo.industry != null) const SizedBox(height: 6,),
                        Text(itemInfo.occupation ?? '', style: const TextStyle(fontSize: 12, color: Colors.white,), maxLines: 3, overflow: TextOverflow.ellipsis,),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
              AutoRouter.of(context).push(NetworkPersonRoute(itemInfo: itemInfo));
            },
          );
        },
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text("NetWork",style: TextStyle(color: Colors.black),),
        actions: [
         Builder(builder: (BuildContext context) {
           return IconButton(
               color: Colors.black,
               onPressed: (){
                 Scaffold.of(context).openEndDrawer();
               },
               icon:ImageIcon( Image.asset('assets/icon/app_bar_filter.png', width: 20, height: 20,).image)
           );
         },)
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: 40,
            margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 4,),
            decoration: BoxDecoration(
                color: const Color(0xFFFBB714),
                borderRadius: BorderRadius.circular(40)
            ),
            child: TextFormField(
              controller: _nameSearchController,
              cursorColor: Colors.blueAccent,
              textAlign: TextAlign.center,
              style: const TextStyle(textBaseline: TextBaseline.alphabetic),
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.pageNetworkHeadSearchTip,
                hintStyle: const TextStyle(fontSize: 14, color: Color(0xFF002A67)),
                contentPadding: const EdgeInsets.only(top: 10,),
                isDense: true,
                border: InputBorder.none,
              ),
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(FocusNode());
                _getPageData(name: _nameSearchController.text.trim());
              },
            ),
          ),
          Expanded(child:
          NotificationListener(
            child: RefreshIndicator(
              displacement: 20,
              color: const Color.fromARGB(245, 44, 163, 184),
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              child: ScrollConfiguration(
                behavior: CusBehavior(),
                child: _scrollMain,
              ),
              onRefresh: () async {
                _getPageData();
              },
            ),
            onNotification: (Notification notification) => _pageScrollNotification(notification),
          ),),
        ],
      ),
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
                      bool filterOk = await doFilter(
                        industry: _filterIndustry,
                        country: _filterCountry,
                        city: _filterCity,
                      );
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
                  bool filterOk = await doFilter(isClear: true);
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

  bool _pageScrollNotification(Notification notification) {
    if (notification is ScrollStartNotification) {
    }
    if (notification is ScrollUpdateNotification) {
      if (_pageScrollController.positions.isNotEmpty &&_pageScrollController.position.userScrollDirection != ScrollDirection.idle) {
        widget.pageScrollDirectionChange?.call(_pageScrollController.position.userScrollDirection);
      }
    }
    if (notification is ScrollEndNotification) {
    }
    return true;
  }

  Future _getPageData({ String? name }) async {
    if(widget.onlyMy){
      return getMyNetwork(context, name: name, industry: _filterIndustry, countryId: _filterCountry?.id, cityId: _filterCity?.id, result: (List<NetworkItemInfoEntity> list) {
        pageList = list;
        setState(() {});
      });
    }else{
      return getNetworkListData(context, name: name, industry: _filterIndustry, countryId: _filterCountry?.id, cityId: _filterCity?.id, result: (List<NetworkItemInfoEntity> list) {
        pageList = list;
        setState(() {});
      });
    }
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
}
