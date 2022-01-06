import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:intl/intl.dart';
import 'package:mmc/bean/thank_note_entity.dart';
import 'package:mmc/utils/comfun.dart';
import 'package:mmc/utils/http_request.dart';

class ThankYouNoteReceivedPage extends StatefulWidget {
  const ThankYouNoteReceivedPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ThankYouNoteReceivedPageState();
  }
}

class _ThankYouNoteReceivedPageState extends State<ThankYouNoteReceivedPage> {
  late Future<List<ThankNoteEntity>> _future;
  int _page =2;
  @override
  void initState() {
    _future = receivedThank(context,1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget _scroll() {
      return Container(
        padding: const EdgeInsets.only(top: 10, left: 26, right: 26, bottom: 30,),
        child:  Column(
          children: [
            const Text('Well Done! You play a big role in connecting our member in MMC network!', style: TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w500,),),
            const SizedBox(height: 30,),
            Expanded(child: FutureBuilder(
              future: _future,
              builder: (BuildContext context, AsyncSnapshot<List<ThankNoteEntity>> snapshot) {
                if(snapshot.connectionState  == ConnectionState.done){
                  if(!snapshot.hasData){
                    return Center(
                        child: Image.asset('assets/image/no_data.png', height: 140,)
                    );
                  }else{
                    return  EasyRefresh(
                        onLoad: () async {
                          receivedThank(context,_page).then((value) {
                            if(value.isNotEmpty){
                              _page +=1;
                              snapshot.data!.addAll(value);
                              setState(() {});
                            }
                          });
                        },
                        footer: BezierBounceFooter(
                            backgroundColor: const Color(0xFF095BD4)
                        ),
                          child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: const EdgeInsets.only(
                              bottom: 14,
                            ),
                            padding: const EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                              left: 14,
                              right: 14,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xFF043B94),
                                  Color(0xFF095BD4),
                                ],
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'You have done',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'MYR ' +
                                      (snapshot.data![index].value.toString()) +
                                      ' refer!!!',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  height: 22,
                                ),
                                Text(
                                  DateFormat(
                                          'EEEE, d MMMM yyyy | h:mm a',
                                          Localizations.localeOf(context)
                                                      .languageCode ==
                                                  'en'
                                              ? 'en_US'
                                              : 'zh_CN')
                                      .format(DateTime.fromMillisecondsSinceEpoch(
                                          snapshot.data![index].sendTime ?? 0)),
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white.withAlpha(180),
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  'From ' +
                                      (snapshot.data![index].fromName ?? ""),
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white.withAlpha(180),
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    );
                  }
                }else{
                  return  Center(
                      child: Image.asset('assets/image/no_data.png', height: 140,)
                  );
                }

              },))
          ],
        ),
      );
    }

    return PageContainer(
      title: 'Thank You Note Received',
      body: ScrollConfiguration(
        behavior: CusBehavior(),
        child: _scroll(),
      ),
    );
  }
}
