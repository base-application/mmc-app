import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mmc/bean/notification_entity.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mmc/utils/http_request.dart';
import 'my_inbox_page.dart';

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
        title: Text("My Inbox"),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: (){
            },
            child: Container(
              padding: const EdgeInsets.only(top: 8, left: 12, right: 12, bottom: 8,),
              child: Container(
                padding: EdgeInsets.all(16),
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
                    SizedBox(width: 10,),
                    Expanded(
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.notification.notificationTitle,style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold,)),
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
              child: Html(data: widget.notification.notificationContent,)
          )
        ],
      ),
    );
  }
}
