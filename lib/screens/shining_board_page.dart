import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mmc/router/router.gr.dart';
import 'package:mmc/utils/comfun.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShiningBoardPage extends StatefulWidget {
  const ShiningBoardPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ShiningBoardPageState();
  }
}

class _ShiningBoardPageState extends State<ShiningBoardPage> {


  @override
  Widget build(BuildContext context) {
    final List<ShiningBoardInfo> _menus = [
      ShiningBoardInfo(
        key: 'mostReferralSent',
        imgBg: 'assets/icon/shind_board4.png',
        label: AppLocalizations.of(context)!.mostReferralSent,
        desc: AppLocalizations.of(context)!.mostReferralSentDesc,
      ),
      ShiningBoardInfo(
        key: 'mostReferralReceived',
        imgBg: 'assets/icon/shind_board1.png',
        label: AppLocalizations.of(context)!.mostReferralReceived,
        desc: AppLocalizations.of(context)!.mostReferralReceivedDesc,
      ),
      ShiningBoardInfo(
        key: 'thankYouNote',
        imgBg: 'assets/icon/shind_board2.png',
        label: AppLocalizations.of(context)!.mostThankYouNote,
        desc: AppLocalizations.of(context)!.mostThankYouNoteDesc,
      ),
      ShiningBoardInfo(
        key: 'eventSupporter',
        imgBg: 'assets/icon/shind_board3.png',
        label: AppLocalizations.of(context)!.eventSupporter,
        desc: AppLocalizations.of(context)!.eventSupporterDesc,
      ),
    ];

    return PageContainer(
      title: 'Shining Board',
      pageBg: Colors.white,
      body: SafeArea(
        bottom: true,
        top: false,
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 30, left: 24, right: 24,),
          shrinkWrap: true,
          itemCount: _menus.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              child: Container(
                margin: const EdgeInsets.only(top: 16),
                decoration: BoxDecoration(
                    color: const Color(0xffE8E9EF),
                    borderRadius: BorderRadius.circular(18)
                ),
                child:Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          image: DecorationImage(image: Image.asset("assets/icon/shining_board.png").image,fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(18)
                      ),
                      child: Row(
                          children: [
                            Image.asset(_menus[index].imgBg),
                            Text(_menus[index].label, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, color:Color(0xffFBB714), fontSize: 20,))
                          ]
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                          color: Color(0xffE8E9EF),
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(18),bottomLeft: Radius.circular(18))
                      ),
                      child: Text(_menus[index].desc),
                    )
                  ],
                ),
              ),
              behavior: HitTestBehavior.opaque,
              onTap: () {
                AutoRouter.of(context).push(ShiningBoardDetailRoute(about: _menus[index],));
              },
            );
          },
        ),
      ),
    );
  }
}

class ShiningBoardInfo {
  final String key;
  final String imgBg;
  final String label;
  final String desc;

  const ShiningBoardInfo({ required this.key, required this.imgBg, required this.label,required this.desc });
}
