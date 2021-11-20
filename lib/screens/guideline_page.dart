import 'package:flutter/material.dart';
import 'package:mmc/utils/comfun.dart';

class GuidelinePage extends StatefulWidget {
  const GuidelinePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GuidelinePageState();
  }
}

class _GuidelinePageState extends State<GuidelinePage> {

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
