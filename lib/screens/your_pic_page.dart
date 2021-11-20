import 'package:flutter/material.dart';
import 'package:mmc/utils/comfun.dart';

class YourPicPage extends StatefulWidget {
  const YourPicPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _YourPicPageState();
  }
}

class _YourPicPageState extends State<YourPicPage> {

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
      title: 'Your Pic',
      body: ScrollConfiguration(
        behavior: CusBehavior(),
        child: _scroll(),
      ),
    );
  }
}
