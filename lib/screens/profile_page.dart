import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:mmc/router/auth_guard.dart';
import 'package:mmc/router/router.gr.dart';
import 'package:mmc/utils/comfun.dart';
import 'package:mmc/utils/comm_widget.dart';
import 'package:provider/src/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

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

  final Map<String, String> _groupZ = {
    'Crystal': 'assets/image/profile_z.png',
    'Elite': 'assets/image/profile_z.png',
    'Premiere': 'assets/image/profile_z.png',
    'MMC': 'assets/image/profile_z.png',
    'Platinum': 'assets/image/profile_z.png',
    'Titanium': 'assets/image/profile_z.png',
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
  Widget build(BuildContext context) {
    Widget _scrollMain = SingleChildScrollView(
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
                              const SizedBox(height: 10,),
                              Text(context.watch<PersonalProfileService>().getPersonalProfileInfo?.name ?? '-', style: const TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold,),),
                              const SizedBox(height: 5,),
                              Text('ID:${context.watch<PersonalProfileService>().getPersonalProfileInfo?.userId}', style: TextStyle(fontSize: 15, color: Colors.white.withAlpha(180), fontWeight: FontWeight.w300,),),
                              const SizedBox(height: 12,),
                              Text(context.watch<PersonalProfileService>().getPersonalProfileInfo?.industry ?? '-', style: TextStyle(fontSize: 15, color: Colors.white.withAlpha(180), fontWeight: FontWeight.w300,), maxLines: 3, overflow: TextOverflow.ellipsis,),
                              const SizedBox(height: 6,),
                              Text(context.watch<PersonalProfileService>().getPersonalProfileInfo?.introduction ?? '-', style: TextStyle(fontSize: 15, color: Colors.white.withAlpha(180), fontWeight: FontWeight.w300,), maxLines: 3, overflow: TextOverflow.ellipsis,),
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
              Flexible(child: Column(
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
                  const Text('My group', style: TextStyle(fontSize: 14),),
                ],
              ),),
              Flexible(child: Column(
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
                  const Text('My network', style: TextStyle(fontSize: 14),),
                ],
              ),),
              Flexible(child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFFDEE4EB),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Image.asset('assets/icon/profile_your_pic.png', width: 34, height: 34,),
                  ),
                  const SizedBox(height: 6,),
                  const Text('Your PIC', style: TextStyle(fontSize: 14),),
                ],
              ),),
              Flexible(child: GestureDetector(
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
                    ),
                    const SizedBox(height: 6,),
                    const Text('', style: TextStyle(fontSize: 14),),
                  ],
                ),
                behavior: HitTestBehavior.opaque,
                onTap: () {
                },
              ),),
            ],
          ),
          const SizedBox(height: 30,),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 26),
                child: Text('My achievements', style: TextStyle(color: Color(0xFF013B7B), fontWeight: FontWeight.bold, fontSize: 18),),
              ),
              Row(
                children: [
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.all(10).copyWith(right: 6),
                      child: Text('Monthly', style: TextStyle(color: _achievementIndex == 0 ? Colors.blue.shade800 : Colors.black87, fontWeight: _achievementIndex == 0 ? FontWeight.bold : FontWeight.w400,),),
                    ),
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      setState(() {
                        _achievementIndex = 0;
                      });
                    },
                  ),
                  Container(width: 1.4, height: 14, color: Colors.black87,),
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.all(10).copyWith(left: 6),
                      child: Text('Lifetime', style: TextStyle(color: _achievementIndex == 1 ? Colors.blue.shade800 : Colors.black87, fontWeight: _achievementIndex == 1 ? FontWeight.bold : FontWeight.w400,),),
                    ),
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      setState(() {
                        _achievementIndex = 1;
                      });
                    },
                  ),
                  const SizedBox(width: 18,),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4,),
          Column(
            children: ['Joined event', 'Referral sent', 'Referral received', 'Thank you note'].map((e) => Container(
              margin: const EdgeInsets.only(top: 2, bottom: 2, left: 24, right: 24,),
              padding: const EdgeInsets.only(top: 16, bottom: 16, left: 12, right: 12,),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(e, style: const TextStyle(color: Color(0xFF013B7B), fontWeight: FontWeight.bold, fontSize: 17),),
                  Row(
                    children: [
                      Text('981', style: TextStyle(color: Color(0xFF013B7B), fontWeight: FontWeight.bold, fontSize: 17),),
                      const SizedBox(width: 4,),
                      Image.asset('assets/icon/item_down.png', width: 10, height: 10,),
                    ],
                  ),
                ],
              ),
            )).toList(),
          ),
          const SizedBox(height: 30,),
          Padding(
            padding: EdgeInsets.only(left: 26),
            child: Text('My QR code', style: TextStyle(color: Color(0xFF013B7B), fontWeight: FontWeight.bold, fontSize: 18),),
          ),
          const SizedBox(height: 20,),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 26, right: 26),
            padding: EdgeInsets.only(bottom: 30),
            decoration: BoxDecoration(
              color: Colors.blue.shade800,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const SizedBox(height: 30,),
                const Text('For event check in', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white,),),
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
          const SizedBox(height: 120,),
        ],
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
}