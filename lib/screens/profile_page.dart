import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:mmc/bean/message_no_read_entity.dart';
import 'package:mmc/bean/personal_profile_info_entity.dart';
import 'package:mmc/router/auth_guard.dart';
import 'package:mmc/router/router.gr.dart';
import 'package:mmc/utils/comfun.dart';
import 'package:mmc/utils/comm_widget.dart';
import 'package:mmc/utils/http_request.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, this.pageScrollDirectionChange}) : super(key: key);

  final Function(ScrollDirection scrollDirection)? pageScrollDirectionChange;

  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  final ScrollController _pageScrollController = ScrollController();
  final PageController _pageController = PageController();
  MessageNoReadEntity? _messageNoReadEntity;

  final Map<String, String> _groupZ = {
    'Crystal': 'assets/image/profile_z.png',
    'Elite': 'assets/image/profile_e.png',
    'Premiere': 'assets/image/profile_p.png',
    'MMC': 'assets/image/profile_m.png',
    'Platinum': 'assets/image/profile_pla.png',
    'Titanium': 'assets/image/profile_t.png',
  };
  String? _getGroupZ(String? gradeName) {
    if (gradeName == null) {
      return null;
    }
    String? z;
    _groupZ.forEach((key, value) {
      if (key.toLowerCase() == gradeName.toLowerCase()) {
        z = value;
        return;
      }
    });
    return z;
  }

  int _achievementIndex = 0;

  @override
  void initState() {
    getNoReadMessage();
    super.initState();
  }

  ///获取未读消息
  getNoReadMessage(){
    if(context.read<AuthService>().getLoginInfo?.token != null){
      noReadMessage(context).then((value) {
        _messageNoReadEntity = value;
        FlutterAppBadger.updateBadgeCount(_messageNoReadEntity?.count??0);
        if(mounted){
          setState(() {});
        }
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    Widget _scrollMain = EasyRefresh(
        onRefresh: () async {
          if(context.read<AuthService>().getLoginInfo?.token != null){
            PersonalProfileInfoEntity info = await getUserDetailData(context, userId: context.read<AuthService>().getLoginInfo!.id);
            savePersonalProfileInfo(context, context.read<AuthService>().getLoginInfo!.id, info);
            getNoReadMessage();
          }
        },
        header: MaterialHeader(
            backgroundColor: const Color(0xFF095BD4)
        ),
      child:SingleChildScrollView(
          controller: _pageScrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 4, left: 26, right: 26,),
                height: MediaQuery.of(context).size.width * 0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF043B94),
                      Color(0xFF095BD4),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      child: Image.asset('assets/image/profile_logo_bg.png', width: 140, height: 140,),
                      bottom: 20,
                      right: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 18, bottom: 18, left: 18, right: 18,),
                      child: Row(
                        children: [
                          Container(
                            width: 120,
                            height: double.infinity,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: netImgWrap(context,
                              width: 120,
                              height: double.infinity,
                              url: context.watch<AuthService>().getLoginInfo?.avatar,
                              errorWidget: Image.asset('assets/image/personal_head_empty.png', width: 120, fit: BoxFit.fitWidth,),
                            ),
                          ),
                          const SizedBox(width: 14,),
                          Expanded(child: Stack(
                            children: [
                              if (_getGroupZ(context.watch<PersonalProfileService>().getPersonalProfileInfo?.gradeName) != null) Positioned(
                                child: Image.asset(_getGroupZ(context.watch<PersonalProfileService>().getPersonalProfileInfo?.gradeName)!, width: 90, height: 90,),
                                top: 0,
                                right: -12,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(context.watch<PersonalProfileService>().getPersonalProfileInfo?.name ?? '-', style: const TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),),
                                  const SizedBox(height: 5,),
                                  Text('ID:${context.watch<PersonalProfileService>().getPersonalProfileInfo?.userId??""}', style: TextStyle(fontSize: 15, color: Colors.white.withAlpha(180), fontWeight: FontWeight.w300,),),
                                  const SizedBox(height: 6,),
                                  Text(context.watch<PersonalProfileService>().getPersonalProfileInfo?.industry ?? '-', style: TextStyle(fontSize: 14, color: Colors.white.withAlpha(180), fontWeight: FontWeight.w300,), maxLines: 3, overflow: TextOverflow.ellipsis,),
                                  Text(context.watch<PersonalProfileService>().getPersonalProfileInfo?.occupation ?? '-', style: TextStyle(fontSize: 14, color: Colors.white.withAlpha(180), fontWeight: FontWeight.w300,), maxLines: 3, overflow: TextOverflow.ellipsis,),
                                  const SizedBox(height: 6,),
                                  Text(context.watch<PersonalProfileService>().getPersonalProfileInfo?.introduction ?? '-', style: TextStyle(fontSize: 14, color: Colors.white.withAlpha(180), fontWeight: FontWeight.w300,), maxLines: 2, overflow: TextOverflow.ellipsis,),
                                ],
                              ),
                            ],
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16,),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(child: GestureDetector(
                    onTap: (){
                      groupDetail(context,context.read<PersonalProfileService>().getPersonalProfileInfo?.groupId).then((group) {
                        if(group != null){
                          AutoRouter.of(context).push(GroupDetailRoute(info: group));
                        }else{
                          ComFun.showToast(msg: AppLocalizations.of(context)!.noGroup);
                        }
                      });
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xFFDEE4EB),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Image.asset('assets/icon/profile_my_group.png', width: 34, height: 34,),
                        ),
                        const SizedBox(height: 6,),
                        Text(AppLocalizations.of(context)!.myGroup, style:  const TextStyle(fontSize: 14),),
                      ],
                    ),
                  )
                  ),
                  Flexible(child:
                  GestureDetector(
                    onTap: (){
                      AutoRouter.of(context).push( const MyNetworkRoute());
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xFFDEE4EB),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Image.asset('assets/icon/profile_my_network.png', width: 34, height: 34,),
                        ),
                        const SizedBox(height: 6,),
                        Text(AppLocalizations.of(context)!.myNetwork, style:  const TextStyle(fontSize: 14),),
                      ],
                    ),
                  )
                    ,),
                  // Flexible(child:
                  // GestureDetector(
                  //   onTap: (){
                  //     AutoRouter.of(context).push(YourPicRoute());
                  //   },
                  //   child: Column(
                  //     children: [
                  //       Container(
                  //         width: 60,
                  //         height: 60,
                  //         alignment: Alignment.center,
                  //         decoration: BoxDecoration(
                  //           color: const Color(0xFFDEE4EB),
                  //           borderRadius: BorderRadius.circular(16),
                  //         ),
                  //         child: Image.asset('assets/icon/profile_your_pic.png', width: 34, height: 34,),
                  //       ),
                  //       const SizedBox(height: 6,),
                  //       Text(AppLocalizations.of(context)!.yourPIC, style: TextStyle(fontSize: 14),),
                  //     ],
                  //   ),
                  // )
                  //   ,),
                ],
              ),
              const SizedBox(height: 30,),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:  const EdgeInsets.only(left: 26),
                    child: Text(AppLocalizations.of(context)!.myAchievements, style:  const TextStyle(color: Color(0xFF013B7B), fontWeight: FontWeight.bold, fontSize: 18),),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.all(10).copyWith(right: 6),
                          child: Text(AppLocalizations.of(context)!.monthly, style: TextStyle(color: _achievementIndex == 0 ? Colors.blue.shade800 : Colors.black87, fontWeight: _achievementIndex == 0 ? FontWeight.bold : FontWeight.w400,),),
                        ),
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          _pageController.animateToPage(0, duration: const Duration(microseconds: 500), curve: Curves.easeInOutCirc);
                        },
                      ),
                      Container(width: 1.4, height: 14, color: Colors.black87,),
                      GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.all(10).copyWith(left: 6),
                          child: Text(AppLocalizations.of(context)!.lifetime, style: TextStyle(color: _achievementIndex == 1 ? Colors.blue.shade800 : Colors.black87, fontWeight: _achievementIndex == 1 ? FontWeight.bold : FontWeight.w400,),),
                        ),
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          _pageController.animateToPage(1,duration: const Duration(microseconds: 500), curve: Curves.easeInOutCirc);
                        },
                      ),
                      const SizedBox(width: 18,),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 4,),
              SizedBox(
                height: 250,
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (page){
                    _achievementIndex = page;
                    setState(() {});
                  },
                  children:  const [
                    MonthlyAchievement(),
                    LifetimeAchievement()
                  ],
                ),
              ),
              const SizedBox(height: 30,),
              Offstage(
                offstage: context.read<AuthService>().getLoginInfo?.token == null,
                child:  Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 26),
                      child: Text(AppLocalizations.of(context)!.myQRCode, style: const TextStyle(color: Color(0xFF013B7B), fontWeight: FontWeight.bold, fontSize: 18),),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      width: double.infinity,
                      margin:  const EdgeInsets.only(left: 26, right: 26),
                      padding: const  EdgeInsets.only(bottom: 30),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade800,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 30,),
                          Text(AppLocalizations.of(context)!.forEventCheckIn, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white,),),
                          const SizedBox(height: 36,),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: MediaQuery.of(context).size.width * 0.7,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: QrImage(
                              data: json.encode({ 'scene': 'mmc-profileQr', 'about': '' }),
                              version: QrVersions.auto,
                              size: 300,
                              gapless: false,
                              padding: const EdgeInsets.all(16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 120,),
            ],
          ),
        )
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          Row(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Badge(
                    animationType: BadgeAnimationType.fade,
                    elevation: 0,
                    badgeColor: (_messageNoReadEntity?.notification??0)>0 ? Colors.red : Colors.transparent,
                    position: const BadgePosition(bottom: 6, start: 12),
                    padding: const EdgeInsets.all(5),
                    badgeContent: Text((_messageNoReadEntity?.notification??0).toString(),style: TextStyle(fontSize: 12,color: (_messageNoReadEntity?.notification??0)>0 ? Colors.white : Colors.transparent),),
                    child: Image.asset('assets/icon/app_bar_ring.png', width: 20, height: 20,),
                  ),
                ),
                onTap: (){
                  AutoRouter.of(context).push(const MyInboxRoute());
                },
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: (){
                  AutoRouter.of(context).push(const SettingRoute());
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 16,left: 16,top: 16,bottom: 16),
                  child: Image.asset('assets/icon/app_bar_set.png', width: 20, height: 20,),
                ),
              ),
            ],
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


class MonthlyAchievement extends StatelessWidget {
  const MonthlyAchievement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 2, bottom: 2, left: 24, right: 24,),
          padding: const EdgeInsets.only(top: 16, bottom: 16, left: 12, right: 12,),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppLocalizations.of(context)!.joinedEvent, style: const TextStyle(color: Color(0xFF013B7B), fontWeight: FontWeight.bold, fontSize: 17),),
              Row(
                children: [
                  Text((context.watch<PersonalProfileService>().getPersonalProfileInfo?.achievement.joinEvent??0).toString(), style:  const  TextStyle(color: Color(0xFF013B7B), fontWeight: FontWeight.bold, fontSize: 17),),
                  const SizedBox(width: 4,),
                  getIsUp((context.watch<PersonalProfileService>().getPersonalProfileInfo?.achievement.joinEvent??0).compareTo(context.watch<PersonalProfileService>().getPersonalProfileInfo!.achievement.joinEventPre??0)),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 2, bottom: 2, left: 24, right: 24,),
          padding: const EdgeInsets.only(top: 16, bottom: 16, left: 12, right: 12,),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppLocalizations.of(context)!.referralSent, style: const TextStyle(color: Color(0xFF013B7B), fontWeight: FontWeight.bold, fontSize: 17),),
              Row(
                children: [
                  Text((Provider.of<PersonalProfileService>(context).getPersonalProfileInfo?.achievement.referralSend??0).toString(), style: const TextStyle(color: Color(0xFF013B7B), fontWeight: FontWeight.bold, fontSize: 17),),
                  const SizedBox(width: 4,),
                  getIsUp((Provider.of<PersonalProfileService>(context,listen: true).getPersonalProfileInfo?.achievement.referralSend??0).compareTo(Provider.of<PersonalProfileService>(context,listen: true).getPersonalProfileInfo!.achievement.prevReferralSend??0)),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 2, bottom: 2, left: 24, right: 24,),
          padding: const EdgeInsets.only(top: 16, bottom: 16, left: 12, right: 12,),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppLocalizations.of(context)!.referralReceived, style: const TextStyle(color: Color(0xFF013B7B), fontWeight: FontWeight.bold, fontSize: 17),),
              Row(
                children: [
                  Text((Provider.of<PersonalProfileService>(context,listen: true).getPersonalProfileInfo?.achievement.referralReceived??0).toString(), style: const  TextStyle(color: Color(0xFF013B7B), fontWeight: FontWeight.bold, fontSize: 17),),
                  const SizedBox(width: 4,),
                  getIsUp((Provider.of<PersonalProfileService>(context,listen: true).getPersonalProfileInfo?.achievement.referralReceived??0).compareTo(context.watch<PersonalProfileService>().getPersonalProfileInfo!.achievement.prevReferralReceived??0)),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 2, bottom: 2, left: 24, right: 24,),
          padding: const EdgeInsets.only(top: 16, bottom: 16, left: 12, right: 12,),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppLocalizations.of(context)!.thankYouNote, style: const TextStyle(color: Color(0xFF013B7B), fontWeight: FontWeight.bold, fontSize: 17),),
              Row(
                children: [
                  Text((context.watch<PersonalProfileService>().getPersonalProfileInfo?.achievement.thankYouNoteReceived??0).toString(), style:  const TextStyle(color: Color(0xFF013B7B), fontWeight: FontWeight.bold, fontSize: 17),),
                  const SizedBox(width: 4,),
                  getIsUp((context.watch<PersonalProfileService>().getPersonalProfileInfo?.achievement.thankYouNoteReceived??0).compareTo(context.watch<PersonalProfileService>().getPersonalProfileInfo!.achievement.prevThankYouNoteReceived??0))
                ],
              ),
            ],
          ),
        )
       ],
    );
  }

  getIsUp(int b) {
    if(b==-1){
      return Image.asset('assets/icon/item_down.png', width: 10, height: 10,);
    }else if(b==1){
      return Image.asset('assets/icon/item_up.png', width: 10, height: 10,);
    }else{
      return const Text("");
    }
  }
}


class LifetimeAchievement extends StatelessWidget {
  const LifetimeAchievement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 2, bottom: 2, left: 24, right: 24,),
          padding: const EdgeInsets.only(top: 16, bottom: 16, left: 12, right: 12,),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const  Text("Joined event", style: TextStyle(color: Color(0xFF013B7B), fontWeight: FontWeight.bold, fontSize: 17),),
              Row(
                children: [
                  Text((Provider.of<PersonalProfileService>(context,listen: true).getPersonalProfileInfo?.achievement.joinEvent??0).toString(), style:  const TextStyle(color: Color(0xFF013B7B), fontWeight: FontWeight.bold, fontSize: 17),),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 2, bottom: 2, left: 24, right: 24,),
          padding: const EdgeInsets.only(top: 16, bottom: 16, left: 12, right: 12,),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Referral sent", style: TextStyle(color: Color(0xFF013B7B), fontWeight: FontWeight.bold, fontSize: 17),),
              Row(
                children: [
                  Text((Provider.of<PersonalProfileService>(context,listen: true).getPersonalProfileInfo?.achievement.referralSendCount??0).toString(), style:  const  TextStyle(color: Color(0xFF013B7B), fontWeight: FontWeight.bold, fontSize: 17),),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 2, bottom: 2, left: 24, right: 24,),
          padding: const EdgeInsets.only(top: 16, bottom: 16, left: 12, right: 12,),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Referral received", style: TextStyle(color: Color(0xFF013B7B), fontWeight: FontWeight.bold, fontSize: 17),),
              Row(
                children: [
                  Text((Provider.of<PersonalProfileService>(context,listen: true).getPersonalProfileInfo?.achievement.referralReceivedCount??0).toString(), style:  const TextStyle(color: Color(0xFF013B7B), fontWeight: FontWeight.bold, fontSize: 17),),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 2, bottom: 2, left: 24, right: 24,),
          padding: const EdgeInsets.only(top: 16, bottom: 16, left: 12, right: 12,),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Thank you note", style:  TextStyle(color: Color(0xFF013B7B), fontWeight: FontWeight.bold, fontSize: 17),),
              Row(
                children: [
                  Text((Provider.of<PersonalProfileService>(context,listen: true).getPersonalProfileInfo?.achievement.thankYouNoteReceivedCount??0).toString(), style:  const TextStyle(color: Color(0xFF013B7B), fontWeight: FontWeight.bold, fontSize: 17),),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
