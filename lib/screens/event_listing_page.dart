import 'dart:async';
import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mmc/bean/event_data_item_info_entity.dart';
import 'package:mmc/router/auth_guard.dart';
import 'package:mmc/router/router.gr.dart';
import 'package:mmc/utils/comfun.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mmc/utils/comm_widget.dart';
import 'package:mmc/utils/dialog.dart';
import 'package:mmc/utils/event_bus.dart';
import 'package:mmc/utils/http_request.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

class EventListingPage extends StatefulWidget {
  const EventListingPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _EventListingPageState();
  }
}

class _EventListingPageState extends State<EventListingPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  bool _isCreate = false; // 默认页面状态为 join 列表

  final Map<DateTime, List<EventDataItemInfoEntity>> _data = {};

  late StreamSubscription _eventItemDataChangeEvent;

  @override
  void initState() {
    super.initState();
    _eventItemDataChangeEvent = eventBus.on<EventItemDataChangeEvent>().listen((event) async {
      _data.forEach((key, value) {
        List<EventDataItemInfoEntity> find = value.where((element) => element.eventId == event.eventId).toList();
        if (find.isNotEmpty) {
          find.first.join = true;
          find.first.attendance = event.list;
          setState(() {});
          return;
        }
      });
    });
    _getPageData();
  }

  @override
  void dispose() {
    _eventItemDataChangeEvent.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      title: AppLocalizations.of(context)!.eventsListing,
      bodyTop: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.only(right: 8),
            height: 60,
            alignment: Alignment.center,
            child: Stack(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(20).copyWith(right: _selectedDay != null ? 6 : 20),
                        child: Image.asset('assets/icon/app_bar_filter.png', width: 18, height: 18,),
                      ),
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        showDialog(
                          context: context,
                          barrierColor: Colors.black.withAlpha(180),
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return StatefulBuilder(builder: (ctx, setSta) {
                              return DialogWidget(
                                title: '',
                                content: '',
                                slideMargin: 4,
                                showTitle: false,
                                showBottomDo: false,
                                borderRadius: 18,
                                outTapDismiss: true,
                                contentExtend: TableCalendar(
                                  locale: Localizations.localeOf(context).languageCode == 'en' ? 'en_US' : 'zh_CN',
                                  firstDay: DateTime.utc(2021, 1, 1),
                                  lastDay: DateTime.now().add(const Duration(days: 365)),
                                  focusedDay: _focusedDay,
                                  daysOfWeekHeight: 20,
                                  daysOfWeekStyle: const DaysOfWeekStyle(
                                    weekdayStyle: TextStyle(color: Colors.black87, fontSize: 15, fontWeight: FontWeight.w500,),
                                    weekendStyle: TextStyle(color: Colors.black87, fontSize: 15, fontWeight: FontWeight.w500,),
                                  ),
                                  calendarStyle: const CalendarStyle(
                                    todayTextStyle: TextStyle(fontSize: 18, color: Color(0xFF3F7CCD), fontWeight: FontWeight.w500,),
                                    todayDecoration: BoxDecoration(
                                      color: Color(0xFFFDF7E6),
                                      shape: BoxShape.circle,
                                    ),
                                    selectedTextStyle: TextStyle(fontSize: 18, color: Color(0xFF013B7B), fontWeight: FontWeight.w500,),
                                    selectedDecoration: BoxDecoration(
                                      color: Color(0xFFFBB714),
                                      shape: BoxShape.circle,
                                    ),
                                    outsideTextStyle: TextStyle(fontSize: 18, color: Color(0xFF8BA1B3), fontWeight: FontWeight.w400,),
                                    disabledTextStyle: TextStyle(fontSize: 18, color: Color(0xFFD3D8DC), fontWeight: FontWeight.w400,),
                                    weekendTextStyle: TextStyle(fontSize: 18, color: Color(0xFF013B7B), fontWeight: FontWeight.w500,),
                                    defaultTextStyle: TextStyle(fontSize: 18, color: Color(0xFF013B7B), fontWeight: FontWeight.w500,),
                                  ),
                                  headerStyle: const HeaderStyle(
                                    formatButtonVisible: false,
                                    titleTextStyle: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF013B7B),
                                    ),
                                    leftChevronIcon: Icon(Icons.chevron_left, size: 28, color: Color(0xFF013B7B),),
                                    rightChevronIcon: Icon(Icons.chevron_right, size: 28, color: Color(0xFF013B7B),),
                                  ),
                                  selectedDayPredicate: (day) {
                                    return isSameDay(_selectedDay, day);
                                  },
                                  onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                                    if (!isSameDay(_selectedDay, selectedDay)) {
                                      setSta(() {
                                        _selectedDay = selectedDay;
                                        _focusedDay = focusedDay;
                                      });
                                      setState(() {});
                                      _getPageData();
                                      Navigator.of(context).pop();
                                    }
                                  },
                                ),
                              );
                            });
                          },
                        );
                      },
                    ),
                    if (_selectedDay != null) GestureDetector(
                      child: Row(
                        children: [
                          const SizedBox(width: 8,),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(DateFormat('MMM', Localizations.localeOf(context).languageCode == 'en' ? 'en_US' : 'zh_CN').format(_selectedDay!), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500,),),
                                  const SizedBox(width: 4,),
                                  Text(DateFormat('d', Localizations.localeOf(context).languageCode == 'en' ? 'en_US' : 'zh_CN').format(_selectedDay!), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500,),),
                                ],
                              ),
                              Text(DateFormat('EEE', Localizations.localeOf(context).languageCode == 'en' ? 'en_US' : 'zh_CN').format(_selectedDay!), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400,),),
                            ],
                          ),
                          const SizedBox(width: 14,),
                        ],
                      ),
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        setState(() {
                          _focusedDay = DateTime.now();
                          _selectedDay = null;
                        });
                        _getPageData();
                      },
                    ),
                  ],
                ),
                if (_selectedDay != null) const Positioned(child: IgnorePointer(
                  child: Icon(Icons.close_rounded, size: 10,),
                ), top: 12, right: 2,),
              ],
            ),
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (_data.isEmpty) stateNoDate(inRef: true),
          if (_data.isNotEmpty) ListView.builder(itemCount: _data.length, itemBuilder: (BuildContext context, int index) {
            DateTime itemDate = _data.keys.elementAt(index);
            List<EventDataItemInfoEntity> itemList = _data.values.elementAt(index);
            Widget _eventItem(EventDataItemInfoEntity item, { bool isLast = false }) {
              return GestureDetector(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.82,
                  margin: EdgeInsets.only(bottom: isLast ? 40 : 14),
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 12, bottom: 12),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF043B94),
                        Color(0xFF095BD4),
                      ],
                    ),
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
                          Expanded(child: Text(item.eventTitle, style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold,), overflow: TextOverflow.ellipsis,),),
                        ],
                      ),
                      const SizedBox(height: 18,),
                      Row(
                        children: [
                          Image.asset('assets/icon/date.png', width: 15, height: 15, color: Colors.white,),
                          const SizedBox(width: 8,),
                          Expanded(child: Text(DateFormat('EEEE, d MMMM yyyy | h:mm a', Localizations.localeOf(context).languageCode == 'en' ? 'en_US' : 'zh_CN').format(DateTime.fromMillisecondsSinceEpoch(item.eventStartTime!)), style: TextStyle(fontSize: 13, color: Colors.white.withAlpha(180),),)),
                        ],
                      ),
                      const SizedBox(height: 18,),
                      !_isCreate ? Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                SizedBox(
                                  width: (item.attendance != null ? (item.attendance!.length > 4 ? 4 : item.attendance!.length) : 0) * 20 + 8,
                                  height: 28,
                                  child: Builder(builder: (ctx) {
                                    List<Widget> _item() {
                                      List<Widget> items = [];
                                      (item.attendance?.take(4).toList() ?? []).asMap().forEach((index, value) {
                                        items.add(Positioned(
                                          child: Container(
                                            width: 28,
                                            height: 28,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.all(Radius.circular(100)),
                                              border: Border.all(width: 1.4, color: Colors.white,),
                                            ),
                                            child: netImgWrap(context,
                                                url: value.picture,
                                                radius: 100,
                                                errorWidget: Image.asset("assets/image/personal_head_empty.png",fit: BoxFit.cover,)
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
                                if (item.attendance != null && item.attendance!.length > 4) const SizedBox(width: 6,),
                                if (item.attendance != null && item.attendance!.length > 4) Text('+${item.attendance!.length - 4}', style: TextStyle(fontSize: 16, color: Colors.amber.shade600,),),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10,),
                          Row(
                            children: [
                              if ((item.join??false)
                                  &&(item.eventStartTime??0) > DateTime.now().millisecondsSinceEpoch
                                  && item.checkIn != true
                                  && item.attend != true
                              ) GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.all(10).copyWith(top: 4, bottom: 4,),
                                  child: Text(AppLocalizations.of(context)!.unJoin, style: const TextStyle(fontSize: 14, color: Color(0xFFFDC12C), fontWeight: FontWeight.w500,),),
                                ),
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
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
                                                Text(AppLocalizations.of(context)!.confirmUnJoin, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600,), textAlign: TextAlign.center,),
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
                                                          _doUnJoin(item);
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
                                },
                              ),

                              const SizedBox(width: 10,),
                              SizedBox(
                                width: 66,
                                height: 30,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(const Color(0xFFFBB714)),
                                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                                    elevation: MaterialStateProperty.all(0),
                                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                                  ),
                                  child: Text(item.join==true ? AppLocalizations.of(context)!.joined : AppLocalizations.of(context)!.join, style: const TextStyle(color: Color(0xFF013B7B), fontSize: 15, fontWeight: FontWeight.w500,),),
                                  onPressed: () {
                                    if (item.join == false) {
                                      if((item.eventStartTime??0) <= DateTime.now().millisecondsSinceEpoch){
                                        ComFun.showToast(msg: AppLocalizations.of(context)!.joinOnStart);
                                        return ;
                                      }
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
                                                              _doJoin(item);
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
                      ) : Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('Attendance: ${item.attendanceProportion.formatPercentage() ?? '0'}%', style: const TextStyle(fontSize: 13, color: Color(0xFFFDC12C), fontWeight: FontWeight.w500,),),
                          GestureDetector(
                            onTap: (){
                              showGeneralDialog(
                                  barrierDismissible: true,
                                  barrierLabel: "qr",
                                  context: context,
                                  pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
                                 return Center(
                                   child: Material(
                                     child: GestureDetector(
                                       onTap: (){
                                         Navigator.of(context).pop();
                                       },
                                       child: Container(
                                         color: Colors.white,
                                         height: MediaQuery.of(context).size.width,
                                         width: MediaQuery.of(context).size.width,
                                         child:QrImage(
                                           data: "event:${item.eventId}",
                                           version: QrVersions.auto,
                                           size: 300,
                                           gapless: false,
                                           padding: const EdgeInsets.all(6),
                                         ),
                                       ),
                                     )
                                   ),
                                 );
                              });
                            },
                            child:  Container(
                              width: 50,
                              height: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    blurRadius: 1,
                                    color: Colors.white.withAlpha(10),
                                  ),
                                ],
                              ),
                              child: QrImage(
                                data: json.encode({ 'scene': 'mmc-eventQr', 'about': item.eventId }),
                                version: QrVersions.auto,
                                size: 300,
                                gapless: false,
                                padding: const EdgeInsets.all(6),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  AutoRouter.of(context).push(EventListingDetailRoute(eventInfo: item, source: _isCreate?2:1));
                },
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 4,),
                SizedBox(
                  width: 70,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(DateFormat('MMM', Localizations.localeOf(context).languageCode == 'en' ? 'en_US' : 'zh_CN').format(itemDate), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87,),),
                          const SizedBox(width: 4,),
                          Text(DateFormat('d', Localizations.localeOf(context).languageCode == 'en' ? 'en_US' : 'zh_CN').format(itemDate), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87,),),
                        ],
                      ),
                      Text(DateFormat('EEE', Localizations.localeOf(context).languageCode == 'en' ? 'en_US' : 'zh_CN').format(itemDate), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black87,),),
                    ],
                  ),
                ),
                const SizedBox(width: 14,),
                Expanded(child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: itemList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _eventItem(itemList[index], isLast: index == itemList.length - 1);
                  },
                )),
              ],
            );
          }, padding: EdgeInsets.only(top: 6, bottom: _isCreate ? 80 : 40, left: 18, right: 18,),),
          if (_isCreate) Positioned(child: Container(
            height: 150,
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0, 0.2],
                colors: [
                  Colors.white.withAlpha(0),
                  Colors.white,
                ],
              ),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 52,
              padding: const EdgeInsets.only(left: 22, right: 22,),
              margin: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 10,),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(const Color(0xFFFBB714)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                  elevation: MaterialStateProperty.all(0),
                ),
                child: const Icon(Icons.add_circle_rounded, size: 26, color: Color(0xFF013B7B),),
                onPressed: () async {
                  AutoRouter.of(context).push(CreateEventRoute(entity: null));
                },
              ),
            ),
          ), bottom: 0,),
        ],
      ),
      onRefresh: () async {
        _getPageData();
      },
      titleBarBgColor: Colors.white,
      rightBtn: ({ int? homeIndex }) {
        return {
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: netImgWrap(context,
                    width: 40,
                    height: 40,
                    url: Provider.of<AuthService>(context,listen: false).getLoginInfo?.avatar,
                    errorWidget: Image.asset('assets/image/personal_head_empty.png', width: 40, height: 40, fit: BoxFit.fitWidth,),
                  ),
                ),
              ),
              if (context.read<AuthService>().getLoginInfo?.createEvent??false) Positioned(
                child: Image.asset('assets/icon/change.png', width: 18, height: 18,),
                bottom: 0,
                right: 3,
              ),
            ],
          ): (ctx) {
            if (context.read<AuthService>().getLoginInfo!.createEvent) {
              _data.clear();
              _isCreate = !_isCreate;
              setState(() {});
              _getPageData();
            }
          },
        };
      },
    );
  }

  /// 获取页面数据
  Future _getPageData() async {
    if (_isCreate) {
      return await getUserCreateEventData(context, dateTime: _selectedDay != null ? DateUtil.formatDate(_selectedDay!, format: 'yyyy-MM-dd') : null, result: (List<EventDataItemInfoEntity> list) {
        _data.clear();
        for (var element in list) {
          if (element.eventStartTime != null) {
            DateTime thisDate = DateTime.utc(DateUtil.getDateTimeByMs(element.eventStartTime!).year, DateUtil.getDateTimeByMs(element.eventStartTime!).month, DateUtil.getDateTimeByMs(element.eventStartTime!).day);
            List<EventDataItemInfoEntity> thisDateList = _data[thisDate] ?? [];
            thisDateList.add(element);
            _data[thisDate] = thisDateList;
          }
        }
        setState(() {});
      });
    } else {
      return await getEventListData(context, dateTime: _selectedDay != null ? DateUtil.formatDate(_selectedDay!, format: 'yyyy-MM-dd') : null, result: (List<EventDataItemInfoEntity> list) {
        _data.clear();
        for (var element in list) {
          if (element.eventStartTime != null) {
            DateTime thisDate = DateTime.utc(DateUtil.getDateTimeByMs(element.eventStartTime!).year, DateUtil.getDateTimeByMs(element.eventStartTime!).month, DateUtil.getDateTimeByMs(element.eventStartTime!).day);
            List<EventDataItemInfoEntity> thisDateList = _data[thisDate] ?? [];
            thisDateList.add(element);
            _data[thisDate] = thisDateList;
          }
        }
        setState(() {});
      });
    }
  }

  /// 执行join
  _doJoin(EventDataItemInfoEntity item) {
    doJoinEvent(context, eventId: item.eventId, result: (List<EventDataItemInfoAttendance> list) {
      ComFun.showToast(msg: 'Join event success');
      item.join = true;
      item.attendance = list;
      setState(() {});
    });
  }

  /// 执行unJoin
  _doUnJoin(EventDataItemInfoEntity item) {
    doUnJoinEvent(context, eventId: item.eventId, result: (List<EventDataItemInfoAttendance> list) {
      ComFun.showToast(msg: 'Unjoin event success');
      item.join = false;
      item.attendance = list;
      setState(() {});
    });
  }
}
