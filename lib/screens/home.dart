import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mmc/utils/comfun.dart';
import 'package:mmc/utils/event_bus.dart';
import 'package:mmc/widget/navigator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  late StreamSubscription _loginOutTimeEvent; // 使用过程中登录token过期事件

  @override
  void initState() {
    super.initState();
    _loginOutTimeEvent = eventBus.on<LoginOutTimeEvent>().listen((event) async {
      ComFun.outLogin(context);
    });
  }

  @override
  void dispose() {
    _loginOutTimeEvent.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const NavigatorPage();
  }
}
