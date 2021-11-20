import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:mmc/bean/newest_item_info_entity.dart';
import 'package:mmc/router/router.gr.dart';
import 'package:mmc/utils/comfun.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mmc/utils/comm_widget.dart';
import 'package:mmc/utils/http_request.dart';

class TodayNewestPage extends StatefulWidget {
  const TodayNewestPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TodayNewestPageState();
  }
}

class _TodayNewestPageState extends State<TodayNewestPage> {
  List<NewestItemInfoEntity> pageList = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      title: AppLocalizations.of(context)!.homeIndexTodayNewestTitle,
      body: ScrollConfiguration(
        behavior: CusBehavior(),
        child: ListView.builder(itemCount: pageList.length, itemBuilder: (BuildContext context, int index) {
          NewestItemInfoEntity itemInfo = pageList[index];
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
        }),
      ),
      onRefresh: () async {
        _getData();
      },
    );
  }

  Future _getData() async {
    return getNewestListData(context, title: null, startDate: null, endDate: null, result: (List<NewestItemInfoEntity> list) {
      pageList = list;
      setState(() {});
    });
  }
}
