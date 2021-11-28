import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:mmc/bean/notification_entity.dart';
import 'package:mmc/utils/comm_widget.dart';
import 'package:mmc/utils/http_request.dart';

class MyInboxPage extends StatefulWidget {
  const MyInboxPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyInboxPageState();
  }
}

class _MyInboxPageState extends State<MyInboxPage> {
  bool _isEdit = false;
  late Future<List<NotificationEntity>> _future;
  int _page = 2;
  @override
  void initState() {
    _future = notificationList(context,1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   return  FutureBuilder(
     future: _future,
     builder: (BuildContext context, AsyncSnapshot<List<NotificationEntity>> snapshot) {
       return  Scaffold(
         appBar: AppBar(
           title: Text("My Inbox"),
           leading: _isEdit ?
           TextButton(
               onPressed: (){
                 _isEdit = false;
                 setState(() {});
                 snapshot.data!.forEach((element) {
                   element.check = false;
                 });
                 },
               child: const Text("完成",style: TextStyle(color: Color(0xFF013B7B)),
               )
           ) :
           IconButton(
               onPressed: (){
                 AutoRouter.of(context).pop();
                 },
               icon: const Icon(CupertinoIcons.left_chevron)
           ) ,
           actions: [
             GestureDetector(
               onTap: (){
                 if(_isEdit){
                   snapshot.data!.forEach((element) {
                     element.check = true;
                   });
                   setState(() {});
                 }else{
                   _isEdit = true;
                 }
                 setState(() {});
               },
               child: AnimatedSwitcher(
                 duration: const Duration(milliseconds: 200),
                 child: Padding(
                   padding: const EdgeInsets.all(10),
                   child: _isEdit ? Text('Select All', style: TextStyle(fontSize: 12, color: Colors.grey.shade700, fontWeight: FontWeight.w500,),)
                       : const Icon(Icons.create_rounded, size: 22,),
                 ) ,
               ),
             )
           ],
         ),
         body: getBody(snapshot),
         bottomNavigationBar: _isEdit ? SafeArea(
           child: Container(
             width: MediaQuery.of(context).size.width,
             height: 50,
             margin: const EdgeInsets.only(left: 20, right: 20,),
             child: ElevatedButton(
               style: ButtonStyle(
                 backgroundColor: MaterialStateProperty.all(const Color(0xFFFBB714)),
                 shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                 elevation: MaterialStateProperty.all(0),
               ),
               child: Text(AppLocalizations.of(context)!.delete, style: const TextStyle(color: Color(0xFF013B7B), fontSize: 16, fontWeight: FontWeight.bold,),),
               onPressed: () async {
                 List<int>? list = snapshot.data?.where((element) => element.check??false).map((e) => e.notificationId).toList();
                 if(list!=null && list.isNotEmpty){
                   notificationDelete(context,list).then((value) {
                     if(value = true){
                       snapshot.data?.removeWhere((element) => element.check??false);
                       setState(() {});
                     }
                   });
                 }
               },
             ),
           ),
         ) : Container(height: 1,),
       );
     },);

  }

  ///有5种选项 - Loan genie, Property deal, News, Updates, System
  getIcon(int notificationType) {
    if(notificationType == 1){
      return  Image.asset("assets/icon/notic_mony.png", width: 40, height: 40,);
    }else if(notificationType == 2){
      return  Image.asset("assets/icon/notic_home.png", width: 40, height: 40,);
    }else if(notificationType == 3){
      return  Image.asset("assets/icon/notic_new.png", width: 40, height: 40,);
    }else if(notificationType == 4){
      return  Image.asset("assets/icon/notic_message.png", width: 40, height: 40,);
    }else{
      return Image.asset("assets/icon/notic_system.png", width: 40, height: 40,);
    }
  }

  getBody(AsyncSnapshot<List<NotificationEntity>> snapshot) {
    if(snapshot.connectionState == ConnectionState.done){
      return EasyRefresh(
        onLoad: () async {
          notificationList(context,_page).then((value) {
            if(value.isNotEmpty){
              snapshot.data!.addAll(value);
              _page +=1;
              setState(() {});
            }
          });
        },
          footer: BezierBounceFooter(
              backgroundColor: const Color(0xFF095BD4)
          ),
        child: ListView.builder(
        padding: const EdgeInsets.only(top: 8,),
        shrinkWrap: true,
        itemCount: snapshot.data!.length,
        itemBuilder: (ctx, index) {
          return GestureDetector(
            onTap: (){
              snapshot.data![index].check = !(snapshot.data![index].check??false);
              setState(() {});
            },
            child: Container(
              padding: const EdgeInsets.only(top: 8, left: 12, right: 12, bottom: 8,),
              child: Row(
                children: [
                  if (_isEdit)Container(
                    width: 27,
                    height: 27,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(width: 1.4, color: const Color(0xFF095DD8),),
                    ),
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: snapshot.data![index].check == true ?  const Color(0xFF095DD8) : Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  if (_isEdit) const SizedBox(width: 8,),
                  Expanded(
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
                            getIcon(snapshot.data![index].notificationType),
                            SizedBox(width: 10,),
                            Expanded(
                                child:Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(snapshot.data![index].notificationTitle,style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold,)),
                                    Text(DateFormat('EEE, d MMM yyyy | h:mm a', Localizations.localeOf(context).languageCode == 'en' ? 'en_US' : 'zh_CN').format(DateTime.fromMillisecondsSinceEpoch(snapshot.data![index].notificationTime)),
                                      style: TextStyle(fontSize: 12, color: Colors.white.withAlpha(180), fontWeight: FontWeight.w300,),
                                    ),
                                    Text(snapshot.data![index].notificationContent.replaceAll(RegExp(r'<[^>]+>'), ""),style: TextStyle(fontSize: 12, color: Colors.white.withAlpha(180), fontWeight: FontWeight.w300,),overflow: TextOverflow.ellipsis,),
                                  ],
                                )
                            )
                          ],
                        ),
                      )),
                ],
              ),
            ),
          );
        },
      )
      );
    }
    else{
      return Center(
          child: stateNoDate(inRef: true)
      );
    }
  }
}
