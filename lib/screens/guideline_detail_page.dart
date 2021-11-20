import 'package:flutter/material.dart';
import 'package:mmc/utils/comfun.dart';

class GuidelineDetailPage extends StatefulWidget {
  const GuidelineDetailPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GuidelineDetailPageState();
  }
}

class _GuidelineDetailPageState extends State<GuidelineDetailPage> {

  @override
  Widget build(BuildContext context) {
    Widget _scroll() {
      return SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 10, left: 26, right: 26, bottom: 30,),
          child: Column(
            children: [
            ],
          ),
        ),
      );
    }

    return PageContainer(
      title: 'Guideline',
      body: ScrollConfiguration(
        behavior: CusBehavior(),
        child: _scroll(),
      ),
    );
  }
}
