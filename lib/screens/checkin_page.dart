import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:mmc/bean/event_data_item_info_entity.dart';
import 'package:mmc/router/auth_guard.dart';
import 'package:mmc/router/router.gr.dart';
import 'package:mmc/utils/comfun.dart';
import 'package:mmc/utils/comm_widget.dart';
import 'package:mmc/utils/http_request.dart';
import 'package:provider/src/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CheckInPage extends StatefulWidget {
  const CheckInPage({Key? key, this.pageScrollDirectionChange}) : super(key: key);

  final Function(ScrollDirection scrollDirection)? pageScrollDirectionChange;

  @override
  State<StatefulWidget> createState() {
    return _CheckInPageState();
  }
}

class _CheckInPageState extends State<CheckInPage> {

  final ScrollController _pageScrollController = ScrollController();
  List<EventDataItemInfoEntity> _future = [];
  @override
  void initState() {
     joinEventList(context,1).then((value) {
       _future = value;
       setState(() {});
     });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget _scrollMain = Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              const SizedBox(width: 26,),
              netImgWrap(context,
                width: 90,
                height: 90,
                radius: 34,
                url: context.watch<AuthService>().getLoginInfo?.avatar,
                errorWidget: Image.asset('assets/image/personal_head_empty.png', width: 90, height: 90, fit: BoxFit.fitWidth,),
              ),
              const SizedBox(width: 22,),
              Expanded(child: Column(
                children: [
                  Text(context.watch<PersonalProfileService>().getPersonalProfileInfo?.name ?? '-', style: const TextStyle(fontSize: 25, color: Colors.black87, fontWeight: FontWeight.bold,),),
                  const SizedBox(height: 2,),
                  Text(context.watch<PersonalProfileService>().getPersonalProfileInfo?.industry ?? '-', style: const TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w400,),),
                  const SizedBox(height: 12,),
                  Text(context.watch<PersonalProfileService>().getPersonalProfileInfo?.groupName ?? '', style: const TextStyle(fontSize: 14, color: Color(0xFFCCA962), fontWeight: FontWeight.w500,),),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              )),
              const SizedBox(width: 26,),
            ],
          ),
          const SizedBox(height: 20,),
          Expanded(
            child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(top: 10, bottom: 18, left: 16, right: 16,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(10).copyWith(right: 0, bottom: 14),
                    child: Text(AppLocalizations.of(context)!.history, style: const TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w500),),
                  ),
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    AutoRouter.of(context).push(CheckHistoryRoute());
                  },
                ),
                const SizedBox(height: 6,),
               Expanded(
                   child: _future.isEmpty ?  Center(
                       child: Image.asset('assets/image/no_data.png', height: 140,)
                   ) :  ListView.builder(
                     controller: _pageScrollController,
                     itemCount: _future.length,
                     itemBuilder: (BuildContext context, int index) {
                       return CheckEventItem(
                         key: ValueKey(_future[index].eventId),
                         entity: _future[index],
                         showDate: index == 0 || DateTime.fromMillisecondsSinceEpoch(_future[index].eventStartTime!).difference(DateTime.fromMillisecondsSinceEpoch(_future[index-1].eventStartTime!)).inDays>0,
                       );
                     },
                   ) ,
               )
              ],
            ),
          ),),
        ],
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appNavigatorCheckIn,overflow: TextOverflow.ellipsis,),
        actions: [
          IconButton(
            onPressed: (){
              AutoRouter.of(context).push<String>(QrViewRoute(type: 1)).then((value) {
                if(value!=null){
                  if(value.split(":")[0] == "event"){
                    checkIn(context,int.parse(value.split(":")[1])).then((response) {
                      if(response == true){
                        ComFun.showToast(msg: AppLocalizations.of(context)!.checkInSuccess);
                        for(int i =0;i<_future.length;i++){
                          if(_future[i].eventId == int.parse(value.split(":")[1])){
                            _future[i].checkIn = true;
                            _future[i].attend = true;
                            setState(() {});
                          }
                        }
                      }
                    });
                  }
                }
              });
            },
            icon: const Icon(CupertinoIcons.qrcode_viewfinder),color: Colors.black,
          )
        ],
      ),
      body: ScrollConfiguration(
        behavior: CusBehavior(),
        child: NotificationListener(
          child: _scrollMain,
          onNotification: (Notification notification) => _pageScrollNotification(notification),
        ),
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
}


class ConfirmAttend extends StatefulWidget {
  final EventDataItemInfoEntity entity;
  const ConfirmAttend({Key? key, required this.entity}) : super(key: key);

  @override
  _ConfirmAttendState createState() => _ConfirmAttendState();
}

class _ConfirmAttendState extends State<ConfirmAttend> {
  bool isAttend = true;
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(left: 16,right: 16,top: 20,bottom: MediaQuery.of(context).padding.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.entity.eventTitle,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,)),
          Text("Please confirm your attendance.",style: TextStyle(fontSize: 16,)),
          const SizedBox(height: 20,),
          Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          if (!isAttend) {
                            return const Color(0xffFBB714).withOpacity(0.5);
                          }
                          return const Color(0xFFFBB714);
                        }),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14))),
                        elevation: MaterialStateProperty.all(0),
                      ),
                      onPressed: () {
                        isAttend = true;
                        setState(() {});
                      },
                      child: Text(
                        AppLocalizations.of(context)!.yes,
                        style: TextStyle(color: Color(0xff013B7B)),
                      ))),
              const SizedBox(width: 20,),
              Expanded(
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          if (isAttend) {
                            return const Color(0xffFBB714).withOpacity(0.5);
                          }
                          return const Color(0xFFFBB714);
                        }),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14))),
                        elevation: MaterialStateProperty.all(0),
                      ),
                      onPressed: () {
                        isAttend = false;
                        setState(() {});
                      },
                      child: Text(AppLocalizations.of(context)!.no,
                          style: TextStyle(color: Color(0xff013B7B)
                          )
                      )
                  )
              )
            ],
          ),
          Offstage(
            offstage: isAttend,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("If No, please fill in reason below:",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                const SizedBox(height: 10,),
                TextFormField(
                  controller: _reasonController,
                  maxLines: 3,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)
                      )
                  ),

                ),
                const SizedBox(height: 10,),
                Text("If you would send your representative, please fill in the information below",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),textAlign: TextAlign.left),
                const SizedBox(height: 10,),
                Text("Representative name"),
                const SizedBox(height: 10,),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)
                      )
                  ),
                ),
                const SizedBox(height: 10,),
                Text("Representative role"),
                const SizedBox(height: 10,),
                TextFormField(
                  controller: _roleController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)
                      )
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20,),
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.resolveWith((states) {return const Color(0xFFFBB714);}),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width/2, 50)),
                elevation: MaterialStateProperty.all(0),
              ),
              onPressed: () {
                if(!isAttend && _reasonController.text.isEmpty){
                  ComFun.showToast(msg: "add reason");
                  return;
                }
                if(!isAttend && _nameController.text.isEmpty){
                  ComFun.showToast(msg: "add name");
                  return;
                }
                if(!isAttend && _roleController.text.isEmpty){
                  ComFun.showToast(msg: "add role");
                  return;
                }
                confirmAttend(context,widget.entity.eventId,context.read<AuthService>().getLoginInfo!.id,agent: _nameController.text,agentRole: _roleController.text,absentReason: _reasonController.text).then((value) {
                  if(value){
                    AutoRouter.of(context).pop(isAttend);
                  }
                });
              },
              child: Text(
                AppLocalizations.of(context)!.submit,
                style: TextStyle(color: Color(0xff013B7B)),
              ))
        ],
      ),
    );
  }
}
class CheckEventItem extends StatefulWidget {
  final EventDataItemInfoEntity entity;
  final bool showDate;
  const CheckEventItem({Key? key, required this.entity, required this.showDate}) : super(key: key);

  @override
  _CheckEventItemState createState() => _CheckEventItemState();
}

class _CheckEventItemState extends State<CheckEventItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 4,),
        _getDateTip(),
        const SizedBox(width: 14,),
        Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.only(left: 14, right: 14, top: 12,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.entity.eventTitle, style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold,),),
                  const SizedBox(height: 10,),
                  Text(DateFormat('EEEE, d MMMM yyyy | h:mm a', Localizations.localeOf(context).languageCode == 'en' ? 'en_US' : 'zh_CN').format(DateTime.fromMillisecondsSinceEpoch(widget.entity.eventStartTime??0)), style: TextStyle(fontSize: 13, color: Colors.white.withAlpha(180), fontWeight: FontWeight.w300,),),
                  const SizedBox(height: 10,),
                  _getoperBtn(widget.entity),
                  const SizedBox(height: 14,),
                ],
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
              ),)
        ),
      ],
    );
  }

  _getDateTip() {
    if(widget.showDate){
      return SizedBox(
        width: 60,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(DateFormat('MMM d', Localizations.localeOf(context).languageCode == 'en' ? 'en_US' : 'zh_CN').format(DateTime.fromMillisecondsSinceEpoch(widget.entity.eventStartTime??0)), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87,),),
            const SizedBox(height: 2,),
            Text(DateFormat('EE', Localizations.localeOf(context).languageCode == 'en' ? 'en_US' : 'zh_CN').format(DateTime.fromMillisecondsSinceEpoch(widget.entity.eventStartTime??0)), style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black87,),),
          ],
        ),
      );
    }else{
      return Container(
        width: 60,
      );
    }
  }

  _getoperBtn(EventDataItemInfoEntity data) {
    if(data.attend == null){
      return  SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 40,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                if(states.contains(MaterialState.disabled)){
                  return const Color(0xffFBB714).withOpacity(0.5);
                }
                return const Color(0xFFFBB714);
              }),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
              elevation: MaterialStateProperty.all(0),
            ),
            child: Text(
              AppLocalizations.of(context)!.toConfirmAttend,
              style: const TextStyle(color: Color(0xFF013B7B), fontWeight: FontWeight.w500,),),
            onPressed: () async {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(16),topLeft: Radius.circular(16))
                ),
                builder: (BuildContext context) {
                  return Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: SingleChildScrollView(
                      child: ConfirmAttend(entity: data,),
                    ),
                  );
                },
              ).then((value) {
                if(value!=null){
                  data.attend = value;
                  setState(() {});
                }
              });
            },
          )
      );
    }
    if((data.checkIn??false)&&data.checkOutTime == null ){
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 40,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if(states.contains(MaterialState.disabled)){
                return const Color(0xffFBB714).withOpacity(0.5);
              }
              return const Color(0xFFFBB714);
            }),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
            elevation: MaterialStateProperty.all(0),
          ),
          child: Text(
            (data.checkIn??false) ?
            AppLocalizations.of(context)!.checkOutSubmitBtn : AppLocalizations.of(context)!.checkInSubmitBtn,
            style: const TextStyle(color: Color(0xFF013B7B), fontWeight: FontWeight.w500,),),
          onPressed: () async {
            FocusScope.of(context).requestFocus(FocusNode());
            checkOut(context,data.eventId).then((value) {
              data.checkOutTime = DateTime.now().microsecondsSinceEpoch;
            });
          },
        ),
      );
    }
    return Container(height: 0,);
  }
}

