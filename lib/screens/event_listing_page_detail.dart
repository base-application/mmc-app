import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mmc/bean/event_data_item_info_entity.dart';
import 'package:mmc/bean/event_detail_info_entity.dart';
import 'package:mmc/router/auth_guard.dart';
import 'package:mmc/router/router.gr.dart';
import 'package:mmc/utils/comfun.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mmc/utils/comm_widget.dart';
import 'package:mmc/utils/dialog.dart';
import 'package:mmc/utils/event_bus.dart';
import 'package:mmc/utils/http_request.dart';
import 'package:provider/provider.dart';

class EventListingDetailPage extends StatefulWidget {
  /// 1 普通列表进入 2 创建列表进入
  final int source;
  const EventListingDetailPage({Key? key, required this.eventInfo, required this.source}) : super(key: key);

  final EventDataItemInfoEntity eventInfo;

  @override
  State<StatefulWidget> createState() {
    return _EventListingDetailPageState();
  }
}

class _EventListingDetailPageState extends State<EventListingDetailPage> {
  EventDetailInfoEntity? detailInfo;

  @override
  void initState() {
    super.initState();
    _initDetailData();
  }

  @override
  Widget build(BuildContext context) {
    Widget _scroll() {
      return SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(),
              child: CustomPaint(
                child: Stack(
                  children: [
                    Positioned(child: Transform.rotate(
                      angle: 1,
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 600,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                stops: [0, 0.7],
                                colors: [
                                  Color(0xFF1C53A7),
                                  Colors.white,
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.48,
                            height: 600,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: const [0, 0.58],
                                colors: [
                                  const Color(0xFF1C53A7),
                                  const Color(0xFF1C53A7).withAlpha(0),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ), top: -260, left: -60,),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(widget.eventInfo.eventTitle, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.black,), textAlign: TextAlign.center,),
                  ),
                  const SizedBox(height: 12,),
                  Text(DateFormat('EEEE, d MMMM yyyy | h:mm a', Localizations.localeOf(context).languageCode == 'en' ? 'en_US' : 'zh_CN').format(DateTime.fromMillisecondsSinceEpoch(widget.eventInfo.eventStartTime!)), style: const TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w500,),),
                  const SizedBox(height: 26,),
                  Offstage(
                    offstage: widget.source == 2,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 56,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(const Color(0xFFFBB714)),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                          elevation: MaterialStateProperty.all(0),
                        ),
                        child: Text(widget.eventInfo.join !=true ? AppLocalizations.of(context)!.join : AppLocalizations.of(context)!.joined, style: const TextStyle(color: Color(0xFF002A67), fontSize: 17, fontWeight: FontWeight.w600, letterSpacing: 0.2),),
                        onPressed: () {
                            if (widget.eventInfo.join != true) {
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
                                                      _doJoin();
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
                  ),
                  const SizedBox(height: 16,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 56,
                    child: Opacity(
                      opacity: 0.3,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(const Color(0xFFFBB714)),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                          elevation: MaterialStateProperty.all(0),
                        ),
                        child: Text(AppLocalizations.of(context)!.back, style: const TextStyle(color: Color(0xFF002A67), fontSize: 17, fontWeight: FontWeight.w600, letterSpacing: 0.2),),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 30,),
                  Row(
                    children: [
                      const SizedBox(width: 24,),
                      Container(
                        width: 5,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 12,),
                      const  Text('Description', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,),),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(top: 8, left: 24, right: 24,),
                    padding: const EdgeInsets.only(top: 12, bottom: 12, left: 15, right: 15,),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF043B94),
                          Color(0xFF095BD4),
                        ],
                      ),
                    ),
                    child: Text(detailInfo?.eventDescription ?? '', style: const TextStyle(color: Colors.white, fontSize: 15,),),
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      const SizedBox(width: 24,),
                      Container(
                        width: 5,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 12,),
                      const  Text('Location', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,),),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(top: 8, left: 24, right: 24,),
                    padding: const EdgeInsets.only(top: 12, bottom: 12, left: 15, right: 15,),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF043B94),
                          Color(0xFF095BD4),
                        ],
                      ),
                    ),
                    child: Text(detailInfo?.eventLocation ?? '', style: const TextStyle(color: Colors.white, fontSize: 15,),),
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      const SizedBox(width: 24,),
                      Container(
                        width: 5,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 12,),
                      const  Text('Link', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,),),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(top: 8, left: 24, right: 24,),
                    padding: const EdgeInsets.only(top: 12, bottom: 12, left: 15, right: 15,),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF043B94),
                          Color(0xFF095BD4),
                        ],
                      ),
                    ),
                    child: Text(detailInfo?.eventMapLink ?? '', style: const TextStyle(color: Colors.white, fontSize: 15,),),
                  ),
                  if ((detailInfo?.eventPoster?.length ?? 0) > 0) const SizedBox(height: 20,),
                  ListView.builder(
                    padding: const EdgeInsets.only(left: 24, right: 24,),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: detailInfo?.eventPoster?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: netImgWrap(context,
                            width: MediaQuery.of(context).size.width,
                            height: (MediaQuery.of(context).size.width - 2 * 24) * 9 / 16,
                            url: detailInfo!.eventPoster![index].url,
                            errorWidget: Container(color: Colors.grey.shade300,),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 28,),
                  if ((widget.eventInfo.attendance?.length ?? 0) > 0) Row(
                    children: [
                      const SizedBox(width: 24,),
                      Container(
                        width: 5,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 12,),
                      const Text('Participants', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,),),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(top: 18, left: 24, right: 24,),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                        childAspectRatio: 3 / 4.6,
                      ),
                      itemCount: widget.eventInfo.attendance?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        EventDataItemInfoAttendance attendanceItem = (widget.eventInfo.attendance ?? []).elementAt(index);
                        return Column(
                          children: [
                            netImgWrap(context,
                              width: 60,
                              height: 60,
                              radius: 16,
                              url: attendanceItem.picture,
                              errorWidget: Image.asset('assets/image/personal_head_empty.png', width: 60, height: 60, fit: BoxFit.fitWidth,),
                            ),
                            const SizedBox(height: 6,),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(child: Text(attendanceItem.name ?? 'Mr/Ms', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500,), overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,),),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 140,),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.eventInfo.eventTitle,
          style: const TextStyle(fontSize: 20, color: Colors.black87, fontWeight: FontWeight.bold,),
        ),
        actions: [
          if(widget.eventInfo.createId == Provider.of<AuthService>(context, listen: false).getLoginInfo?.id
          && widget.eventInfo.eventStartTime! > DateTime.now().millisecondsSinceEpoch
          ) IconButton(onPressed: (){ AutoRouter.of(context).push(CreateEventRoute(entity: widget.eventInfo));}, icon: const Icon(Icons.edit))
        ],
      ),
      body: ScrollConfiguration(
        behavior: CusBehavior(),
        child: _scroll(),
      ),
    );
  }

  /// 获取event详情数据
  _initDetailData() {
    getEventDetailData(context, eventId: widget.eventInfo.eventId, result: (EventDetailInfoEntity info) {
      setState(() {
        detailInfo = info;
      });
    },);
  }

  /// 执行join
  _doJoin() {
    doJoinEvent(context, eventId: widget.eventInfo.eventId, result: (List<EventDataItemInfoAttendance> list) {
      ComFun.showToast(msg: 'Join event success');
      setState(() {
        detailInfo?.checkIn == false;
        widget.eventInfo.checkIn = false;
        widget.eventInfo.attendance = list;
      });
      eventBus.fire(EventItemDataChangeEvent(eventId: widget.eventInfo.eventId, list: list,));
    });
  }
}
