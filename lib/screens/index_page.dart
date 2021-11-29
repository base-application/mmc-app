import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:mmc/bean/event_data_item_info_entity.dart';
import 'package:mmc/bean/newest_item_info_entity.dart';
import 'package:mmc/router/auth_guard.dart';
import 'package:mmc/router/router.gr.dart';
import 'package:mmc/utils/comfun.dart';
import 'package:mmc/utils/comm_widget.dart';
import 'package:mmc/utils/dialog.dart';
import 'package:mmc/utils/http_request.dart';
import 'package:mmc/widget/app_bar_home.dart';
import 'package:mmc/widget/banner.dart';
import 'package:provider/src/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key, this.pageScrollDirectionChange}) : super(key: key);

  final Function(ScrollDirection scrollDirection)? pageScrollDirectionChange;

  @override
  State<StatefulWidget> createState() {
    return _IndexPageState();
  }
}

class _IndexPageState extends State<IndexPage> with TickerProviderStateMixin {
  final ScrollController _pageScrollController = ScrollController();

  late AnimationController tipController;
  late PageController _tipController;
  Timer? _tipTimer;

  final List<MenuDoItem> _menus = [];

  final List<String> _currentNotes = []; // 通知消息的数组

  @override
  void initState() {
    super.initState();
    _tipController = PageController(
        initialPage: 0,
        keepPage: true,
        viewportFraction: 1
    );
    tipController = AnimationController(
      ///duration 为正向执行动画的时间
        duration: const Duration(milliseconds: 200),
        ///反向执行动画的时间
        reverseDuration: const Duration(milliseconds: 200),
        ///controller的变化的最小值
        lowerBound: 0.0,
        ///controller变化的最大值
        upperBound: 1.0,
        ///绑定页面的Ticker
        vsync: this);
    tipController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.dismissed) {
        stopLoopTips();
      } else if (status == AnimationStatus.completed) {
        startLoopTips();
      }
    });

    _currentNotes.clear();
    _currentNotes.addAll([
      'Lorem ipsum dolor sit amet, consectetu...',
      'Lorem ipsum dolor sit amet, consectetus,sd sdasds ddsvs dvdsfds dfsfsdfds dsvfdfsd...',
      'Lorem ipsum dolor sit amet, consectetu...'
    ]);

    tipController.reset();
    tipController.forward();
  }

  @override
  void dispose() {
    tipController.dispose();
    super.dispose();
  }

  startLoopTips() {
    if (_tipTimer == null || !_tipTimer!.isActive) {
      _tipTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
        // 滑动到下一页
        if (_tipController.hasClients && _currentNotes.isNotEmpty && _currentNotes.length > 1) {
          _tipController.nextPage(
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 900,),
          );
        }
      });
    }
  }
  stopLoopTips() {
    _tipTimer?.cancel();
  }

  /// 通知信息点击事件
  void _tipTap() {
    if (_tipController.page != null) {
      int curIndex = _tipController.page!.round();
      int curPage = curIndex % _currentNotes.length;
      if (curPage < 0) {
        curPage = 0;
      } else if (curPage > _currentNotes.length - 1) {
        curPage = _currentNotes.length - 1;
      }
      // _currentNotes[curPage]
    }
  }

  @override
  Widget build(BuildContext context) {
    _menus.clear();
    _menus.addAll([
      MenuDoItem(
        iconAssets: 'assets/icon/menu_group.png',
        label: AppLocalizations.of(context)!.homeIndexMenuGroupBtn,
        onTap: () {
          AutoRouter.of(context).push(const GroupRoute());
        },
      ),
      MenuDoItem(
        iconAssets: 'assets/icon/menu_event.png',
        label: AppLocalizations.of(context)!.homeIndexMenuEventBtn,
        onTap: () {
          AutoRouter.of(context).push(const EventListingRoute());
        },
      ),
      MenuDoItem(
        iconAssets: 'assets/icon/menu_shining_board.png',
        label: AppLocalizations.of(context)!.homeIndexMenuShiningBoardBtn,
        onTap: () {
          AutoRouter.of(context).push(const ShiningBoardRoute());
        },
      ),
      MenuDoItem(
        iconAssets: 'assets/icon/menu_send_referral.png',
        label: AppLocalizations.of(context)!.homeIndexMenuSendReferralBtn,
        onTap: () {
          AutoRouter.of(context).push(const SendingReferralRoute());
        },
      ),
      MenuDoItem(
        iconAssets: 'assets/icon/menu_referral_received.png',
        label: AppLocalizations.of(context)!.homeIndexMenuReferralReceivedBtn,
        onTap: () {
          AutoRouter.of(context).push(const ReferralReceivedRoute());
        },
      ),
      MenuDoItem(
        iconAssets: 'assets/icon/menu_thank_you_note_received.png',
        label: AppLocalizations.of(context)!.homeIndexMenuThankNoteReceivedBtn,
        onTap: () {
          AutoRouter.of(context).push(const ThankYouNoteReceivedRoute());
        },
      ),
      MenuDoItem(
        iconAssets: 'assets/icon/menu_shop.png',
        label: AppLocalizations.of(context)!.homeIndexMenuShopBtn,
        onTap: () {
          // AutoRouter.of(context).push(const SendingReferralRoute());
        },
      ),
    ]);

    Widget _scrollMain =
    Scaffold(
      appBar: HomeAppBar(),
      body: SingleChildScrollView(
        controller: _pageScrollController,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 12, bottom: 12, left: 24, right: 24,),
              decoration: const BoxDecoration(
                color: Color(0xFFFBB714),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!.homeIndexAchievementsTip, style: const TextStyle(fontSize: 15, color: Color(0xFF06387D)),),
                  Text(context.watch<HomeIndexDataService>().getHomeIndexInfo!.user.thankYouNote.formatNumber() ?? '0', style: const TextStyle(fontSize: 15, color: Color(0xFF06387D), fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            if (context.watch<HomeIndexDataService>().getHomeIndexInfo!.slider.isNotEmpty) BannerWidget(
              whRadio: 9 / 16,
              isNetImg: true,
              topGradientHeight: 0,
              showIndicator: false,
              imageList: context.watch<HomeIndexDataService>().getHomeIndexInfo!.slider.map((e) => '${context.read<SystemSetService>().baseUrl}${e.sliderPoster}').toList(),
            ),
            Container(
              height: 70,
              alignment: Alignment.centerLeft,
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
              child: ScrollConfiguration(
                behavior: CusBehavior(),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _menus.length,
                  itemBuilder: (BuildContext context, int index) {
                    MenuDoItem menuItem = _menus[index];
                    return GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(left: 14, right: 14,),
                        constraints: const BoxConstraints(
                          minWidth: 80,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(menuItem.iconAssets, width: 24, height: 24,),
                            const SizedBox(height: 4,),
                            Text(menuItem.label, style: const TextStyle(fontSize: 12, color: Colors.white,),),
                          ],
                        ),
                      ),
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        menuItem.onTap?.call();
                      },
                    );
                  },
                ),
              ),
            ),
            if (_currentNotes.isNotEmpty) GestureDetector(
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15,),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(bottom: BorderSide(color: Colors.black12, width: 0.4,))
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 4,),
                    Image.asset('assets/icon/note.png', width: 20, height: 20,),
                    const SizedBox(width: 18,),
                    Expanded(child: Container(
                      height: 16,
                      alignment: Alignment.centerLeft,
                      child: PageView.builder(
                          controller: _tipController,
                          scrollDirection: Axis.vertical,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            if (_currentNotes.isNotEmpty) {
                              String tipItem = _currentNotes[index % _currentNotes.length];
                              return Text(tipItem, maxLines: 1, style: const TextStyle(fontSize: 14, color: Colors.black87,), overflow: TextOverflow.ellipsis);
                            } else {
                              return Container();
                            }
                          }
                      ),
                    ),),
                  ],
                ),
              ),
              behavior: HitTestBehavior.opaque,
              onTap: () {
                _tipTap();
              },
            ),
            Column(
              children: [
                const SizedBox(height: 10,),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 22),
                      child: Text(AppLocalizations.of(context)!.homeIndexTodayNewestTitle, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF013B7B)),),
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(20).copyWith(right: 22),
                        child: Text(AppLocalizations.of(context)!.seeAll, style: const TextStyle(fontSize: 13, color: Color(0xFF013B7B)),),
                      ),
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        AutoRouter.of(context).push(const TodayNewestRoute());
                      },
                    ),
                  ],
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: context.watch<HomeIndexDataService>().getHomeIndexInfo!.newset.length,
                  itemBuilder: (BuildContext context, int index) {
                    NewestItemInfoEntity itemInfo = context.watch<HomeIndexDataService>().getHomeIndexInfo!.newset[index];
                    return Container(
                      margin: const EdgeInsets.only(top: 4, bottom: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            blurRadius: 1,
                            color: Colors.black87.withAlpha(10),
                          ),
                        ],
                      ),
                      child: TextButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                          // 设置水波纹颜色
                          overlayColor: MaterialStateProperty.all(const Color(0x22CBCBCB)),
                        ),
                        onPressed: () {
                          AutoRouter.of(context).push(NewestDetailRoute(info: itemInfo));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 14, bottom: 14, left: 24, right: 24,),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(DateFormat('EEEE, d MMMM yyyy | h:mm a', Localizations.localeOf(context).languageCode == 'en' ? 'en_US' : 'zh_CN').format(DateTime.fromMillisecondsSinceEpoch(itemInfo.pushTime)), style: const TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w500,),),
                              const SizedBox(height: 12,),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  netImgWrap(context,
                                    width: 80,
                                    height: 80,
                                    radius: 8,
                                    url: itemInfo.cover,
                                    errorWidget: Container(color: Colors.grey.shade300, width: 80, height: 80,),
                                  ),
                                  const SizedBox(width: 16,),
                                  Expanded(child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(itemInfo.title, style: const TextStyle(fontSize: 15.6, fontWeight: FontWeight.bold, color: Colors.black87,),),
                                      const SizedBox(height: 4,),
                                      Text(itemInfo.description, style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w400, fontSize: 14,), maxLines: 3, overflow: TextOverflow.ellipsis,),
                                    ],
                                  )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            Column(
              children: [
                const SizedBox(height: 10,),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 22),
                      child: Text(AppLocalizations.of(context)!.homeIndexUpcomingEventTitle, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF013B7B)),),
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(20).copyWith(right: 22),
                        child: Text(AppLocalizations.of(context)!.seeAll, style: const TextStyle(fontSize: 13, color: Color(0xFF013B7B)),),
                      ),
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        AutoRouter.of(context).push(const EventListingRoute());
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 150,
                  child: ScrollConfiguration(
                    behavior: CusBehavior(),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: context.watch<HomeIndexDataService>().getHomeIndexInfo!.upcoming.length,
                      itemBuilder: (BuildContext context, int index) {
                        EventDataItemInfoEntity eventItemInfo = context.watch<HomeIndexDataService>().getHomeIndexInfo!.upcoming[index];
                        return GestureDetector(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.82,
                            margin: EdgeInsets.only(left: 20, right: index == 1 ? 20 : 0, top: 6, bottom: 6),
                            padding: const EdgeInsets.only(left: 15, right: 15, top: 12, bottom: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  blurRadius: 1,
                                  color: Colors.black87.withAlpha(10),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    netImgWrap(context,
                                      width: 30,
                                      height: 30,
                                      assets: 'assets/icon/upcoming_item_ic.png',
                                      errorWidget: Container(color: Colors.grey.shade300, width: 30, height: 30,),
                                    ),
                                    const SizedBox(width: 12,),
                                    Expanded(child: Text(eventItemInfo.eventTitle, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,), overflow: TextOverflow.ellipsis,),),
                                  ],
                                ),
                                const SizedBox(height: 18,),
                                Row(
                                  children: [
                                    Image.asset('assets/icon/date.png', width: 15, height: 15,),
                                    const SizedBox(width: 8,),
                                    Text(DateFormat('EEEE, d MMMM yyyy | h:mm a', Localizations.localeOf(context).languageCode == 'en' ? 'en_US' : 'zh_CN').format(DateTime.fromMillisecondsSinceEpoch(eventItemInfo.eventStartTime!)), style: const TextStyle(fontSize: 13, color: Colors.black54,),),
                                  ],
                                ),
                                const SizedBox(height: 18,),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: (eventItemInfo.attendance != null ? (eventItemInfo.attendance!.length > 4 ? 4 : eventItemInfo.attendance!.length) : 0) * 20 + 8,
                                            height: 28,
                                            child: StatefulBuilder(builder: (ctx, setSta) {
                                              List<Widget> _item() {
                                                List<Widget> items = [];
                                                (eventItemInfo.attendance?.take(4).toList() ?? []).asMap().forEach((index, value) {
                                                  items.add(Positioned(
                                                    child: Container(
                                                      width: 28,
                                                      height: 28,
                                                      clipBehavior: Clip.antiAlias,
                                                      decoration: BoxDecoration(
                                                        borderRadius: const BorderRadius.all(Radius.circular(100)),
                                                        border: Border.all(width: 2, color: Colors.white,),
                                                      ),
                                                      child: netImgWrap(context,
                                                        url: value.picture,
                                                        radius: 100,
                                                        errorWidget: Container(color: Colors.grey.shade300,),
                                                      ),
                                                    ),
                                                    left: index * 20,
                                                  ));
                                                });
                                                return items;
                                              }
                                              return Stack(
                                                fit: StackFit.loose,
                                                children: _item(),
                                              );
                                            }),
                                          ),
                                          if (eventItemInfo.attendance != null && eventItemInfo.attendance!.length > 4) const SizedBox(width: 6,),
                                          if (eventItemInfo.attendance != null && eventItemInfo.attendance!.length > 4) Text('+${eventItemInfo.attendance!.length - 4}', style: TextStyle(fontSize: 13, color: Colors.amber.shade800,),),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 30,),
                                    SizedBox(
                                      height: 30,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all(const Color(0xFFFBB714)),
                                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
                                          elevation: MaterialStateProperty.all(0),
                                        ),
                                        child: Text(eventItemInfo.checkIn != null ? AppLocalizations.of(context)!.joined : AppLocalizations.of(context)!.join, style: const TextStyle(color: Color(0xFF013B7B), fontSize: 15, fontWeight: FontWeight.w500,),),
                                        onPressed: () {
                                          if (eventItemInfo.checkIn == null) {
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
                                                          Text(AppLocalizations.of(context)!.confirmJoin, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600,), textAlign: TextAlign.center,),
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
                                                                    _doJoin(eventItemInfo);
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
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            AutoRouter.of(context).push(EventListingDetailRoute(eventInfo: eventItemInfo));
                          },
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 120,),
              ],
            ),
          ],
        ),
      ),
    );

    return ScrollConfiguration(
      behavior: CusBehavior(),
      child: NotificationListener(
        child: _scrollMain,
        onNotification: (Notification notification) => _pageScrollNotification(notification),
      ),
    );
  }

  bool _pageScrollNotification(Notification notification) {
    if (notification is ScrollStartNotification) {
    }
    if (notification is ScrollUpdateNotification) {
      if (_pageScrollController.position.userScrollDirection != ScrollDirection.idle) {
        widget.pageScrollDirectionChange?.call(_pageScrollController.position.userScrollDirection);
      }
    }
    if (notification is ScrollEndNotification) {
    }
    return true;
  }

  /// 执行join
  _doJoin(EventDataItemInfoEntity item) {
    doJoinEvent(context, eventId: item.eventId, result: (List<EventDataItemInfoAttendance> list) {
      ComFun.showToast(msg: 'Join event success');
      item.checkIn = false;
      item.attendance = list;
      setState(() {});
    });
  }
}
