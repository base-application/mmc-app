import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mmc/router/auth_guard.dart';
import 'package:mmc/router/router.gr.dart';
import 'package:mmc/utils/comfun.dart';
import 'package:provider/provider.dart';

class AdvertisementPage extends StatefulWidget {
  const AdvertisementPage({Key? key}) : super(key: key);

  @override
  _AdvertisementPageState createState() => _AdvertisementPageState();
}

class _AdvertisementPageState extends State<AdvertisementPage> {
  late Timer _timer;
  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 3), (t) {
      initLoginInfo(context).then((value){
        if(Provider.of<AuthService>(context, listen: false).getLoginInfo?.token != null){
          AutoRouter.of(context).replaceAll([const HomeRoute()]);
        }else{
          AutoRouter.of(context).replaceAll([const WelcomeRoute()]);
        }
      });
      _timer.cancel();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("广告"),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
