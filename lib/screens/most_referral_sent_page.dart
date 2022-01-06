import 'package:flutter/material.dart';
import 'package:mmc/utils/comfun.dart';

class MostReferralSentPage extends StatefulWidget {
  const MostReferralSentPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MostReferralSentPageState();
  }
}

class _MostReferralSentPageState extends State<MostReferralSentPage> {

  @override
  Widget build(BuildContext context) {
    Widget _scroll() {
      return SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 10, left: 26, right: 26, bottom: 30,),
          child: Column(
            children: const [
              Text("")
            ],
          ),
        ),
      );
    }

    return PageContainer(
      title: 'Most referral sent',
      body: ScrollConfiguration(
        behavior: CusBehavior(),
        child: _scroll(),
      ),
    );
  }
}
