import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mmc/bean/notification_entity.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mmc/utils/comfun.dart';
import 'package:mmc/utils/comm_widget.dart';
import 'package:mmc/utils/http_request.dart';
import 'package:url_launcher/url_launcher.dart';
import 'my_inbox_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class InboxDetailPage extends StatefulWidget {
  final NotificationEntity notification;
  const InboxDetailPage({Key? key, required this.notification}) : super(key: key);

  @override
  _InboxDetailPageState createState() => _InboxDetailPageState();
}

class _InboxDetailPageState extends State<InboxDetailPage> {
  @override
  void initState() {
    readNotification(context,widget.notification.notificationId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.inbox),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: (){
            },
            child: Container(
              padding: const EdgeInsets.only(top: 8, left: 12, right: 12, bottom: 8,),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF043B94),
                      Color(0xFF095BD4),
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    getIcon(widget.notification.notificationType),
                    const SizedBox(width: 10,),
                    Expanded(
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.notification.notificationTitle,style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold,)),
                            Text(DateFormat('EEE, d MMM yyyy | h:mm a', Localizations.localeOf(context).languageCode == 'en' ? 'en_US' : 'zh_CN').format(DateTime.fromMillisecondsSinceEpoch(widget.notification.notificationTime)),
                              style: TextStyle(fontSize: 12, color: Colors.white.withAlpha(180), fontWeight: FontWeight.w300,),
                            ),
                          ],
                        )
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              child: Column(
                children: [
                  Html(
                    data: widget.notification.notificationContent,
                    customRender:{
                      "img":(contextre, child){
                        final attrs = contextre.tree.element?.attributes;
                        return Container(
                          child: netImgWrap(context,url: attrs!['src'],errorWidget: const Text("load error")),
                        );
                      }
                    }
                  ),
                  if(widget.notification.registrationName!=null)
                    Container(
                      padding: const EdgeInsets.only(left: 16,right: 16),
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(const Color(0xFFFBB714)),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                          elevation: MaterialStateProperty.all(0),
                        ),
                        onPressed: ()async{
                          if(await canLaunch(widget.notification.registrationLink??"")){
                            launch(widget.notification.registrationLink!);
                          }else{
                            ComFun.showToast(msg: AppLocalizations.of(context)!.urlNotOPen);
                          }
                        }, child: Text(widget.notification.registrationName??"")
                      ),
                    )
                ],
              )
          )
        ],
      ),
    );
  }
}
