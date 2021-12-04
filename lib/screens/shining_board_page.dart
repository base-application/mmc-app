import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mmc/router/router.gr.dart';
import 'package:mmc/utils/comfun.dart';
import 'package:mmc/utils/comm_widget.dart';

class ShiningBoardPage extends StatefulWidget {
  const ShiningBoardPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ShiningBoardPageState();
  }
}

class _ShiningBoardPageState extends State<ShiningBoardPage> {
  final List<ShiningBoardInfo> _menus = [
    const ShiningBoardInfo(
      key: 'mostReferralSent',
      imgBg: 'assets/icon/most_referral_sent.png',
      label: 'Most referral\nsent',
    ),
    const ShiningBoardInfo(
      key: 'mostReferralReceived',
      imgBg: 'assets/icon/most_referral_received.png',
      label: 'Most referral\nreceived',
    ),
    const ShiningBoardInfo(
      key: 'thankYouNote',
      imgBg: 'assets/icon/thank_you_note.png',
      label: 'Thank you\nnote',
    ),
    const ShiningBoardInfo(
      key: 'eventSupporter',
      imgBg: 'assets/icon/event_supporter.png',
      label: 'Event\nsupporter',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    Widget _scroll() {
      return GridView.builder(
        padding: const EdgeInsets.only(top: 30, left: 24, right: 24,),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _menus.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 22,
          mainAxisSpacing: 22,
          childAspectRatio: 5 / 6,
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image.asset(_menus[index].imgBg),
                Positioned(child: Text(_menus[index].label, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 20,),), bottom: 26,),
              ],
            ),
            behavior: HitTestBehavior.opaque,
            onTap: () {
              AutoRouter.of(context).push(ShiningBoardDetailRoute(about: _menus[index],));
            },
          );
        },
      );
    }

    return PageContainer(
      title: 'Shining Board',
      pageBg: Colors.white,
      body: _scroll(),
    );
  }
}

class ShiningBoardInfo {
  final String key;
  final String imgBg;
  final String label;

  const ShiningBoardInfo({ required this.key, required this.imgBg, required this.label });
}
