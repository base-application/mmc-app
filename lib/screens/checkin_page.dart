import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:mmc/router/auth_guard.dart';
import 'package:mmc/utils/comfun.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mmc/utils/comm_widget.dart';
import 'package:provider/src/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    Widget _scrollMain = SingleChildScrollView(
      controller: _pageScrollController,
      child: Column(
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
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(top: 10, bottom: 18, left: 16, right: 16,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(10).copyWith(right: 0, bottom: 14),
                    child: const Text('History', style: TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w500),),
                  ),
                  behavior: HitTestBehavior.opaque,
                  onTap: () {},
                ),
                const SizedBox(height: 6,),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 6,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 4,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('June 3', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87,),),
                            const SizedBox(height: 2,),
                            Text('WED', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black87,),),
                          ],
                        ),
                        const SizedBox(width: 14,),
                        Expanded(child: Container(
                          height: MediaQuery.of(context).size.width * 0.4,
                          margin: const EdgeInsets.only(bottom: 30),
                          padding: const EdgeInsets.only(left: 14, right: 14, top: 12,),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('How to manage cash flow and risk', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold,),),
                              const SizedBox(height: 10,),
                              Expanded(child: Text('Wednesday, 3 June 2021 | 8.00am', style: TextStyle(fontSize: 13, color: Colors.white.withAlpha(180), fontWeight: FontWeight.w300,),),),
                              const SizedBox(height: 10,),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 40,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(const Color(0xFFFBB714)),
                                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                                      elevation: MaterialStateProperty.all(0),
                                    ),
                                    child: Text(AppLocalizations.of(context)!.checkOutSubmitBtn, style: const TextStyle(color: Color(0xFF013B7B), fontWeight: FontWeight.w500,),),
                                    onPressed: () async {
                                      FocusScope.of(context).requestFocus(FocusNode());
                                    },
                                  )
                              ),
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
                          ),
                        )),
                      ],
                    );
                  },
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
      child: Stack(
        children: [
          NotificationListener(
            child: _scrollMain,
            onNotification: (Notification notification) => _pageScrollNotification(notification),
          ),
          Positioned(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0, MediaQuery.of(context).padding.bottom != 0 ? 0.2 : 0.3],
                  colors: [
                    Colors.white.withAlpha(0),
                    Colors.white,
                  ],
                ),
              ),
              padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: MediaQuery.of(context).padding.bottom != 0 ? 120 : 100),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 54,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(const Color(0xFFFBB714)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                        elevation: MaterialStateProperty.all(0),
                      ),
                      child: Text(AppLocalizations.of(context)!.checkInSubmitBtn, style: const TextStyle(color: Color(0xFF013B7B), fontSize: 16, fontWeight: FontWeight.bold,),),
                      onPressed: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                    ),
                  ),
                ],
              ),
            ),
            bottom: 0,
            left: 0,
          ),
        ],
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
