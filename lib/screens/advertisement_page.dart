import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mmc/bean/app_version_entity.dart';
import 'package:mmc/router/auth_guard.dart';
import 'package:mmc/router/router.gr.dart';
import 'package:mmc/utils/comfun.dart';
import 'package:mmc/utils/dialog.dart';
import 'package:mmc/utils/http_request.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class AdvertisementPage extends StatefulWidget {
  const AdvertisementPage({Key? key}) : super(key: key);

  @override
  _AdvertisementPageState createState() => _AdvertisementPageState();
}

class _AdvertisementPageState extends State<AdvertisementPage> {
  late Timer _timer;
  @override
  void initState() {
    checkVersion(context).then((value) {
      if(value==null){
        next();
      }else{
        updateVersion(value);
      }

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

  next(){
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
  }

  updateVersion(AppVersionEntity value){
    {
      showDialog(
        context: context,
        barrierColor: Colors.black.withAlpha(180),
        barrierDismissible: false,
        builder: (BuildContext context) {
          return DialogWidget(
            title: '',
            content: '',
            slideMargin: 4,
            showTitle: false,
            showBottomDo: false,
            borderRadius: 14,
            outTapDismiss: false,
            contentExtend: Row(
              children: [
                Expanded(child: Column(
                  children: [
                    const SizedBox(height: 30,),
                    Text(AppLocalizations.of(context)!.versionFound, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600,), textAlign: TextAlign.center,),
                    const SizedBox(height: 50,),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 130,
                          height: 48,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(const Color(0xFFFBB714)),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                              elevation: MaterialStateProperty.all(0),
                            ),
                            child: Text(AppLocalizations.of(context)!.yes, style: const TextStyle(color: Color(0xFF002A67), fontSize: 17, fontWeight: FontWeight.w600, letterSpacing: 0.2),),
                            onPressed: () async {
                              if(await canLaunch(value.url)){
                              launch(value.url);
                              }else{
                              ComFun.showToast(msg: AppLocalizations.of(context)!.urlNotOPen);
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 20,),
                        Container(
                          width: 130,
                          height: 48,
                          decoration: BoxDecoration(
                            border: Border.all(width: 2, color: const Color(0xFF346295)),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                              elevation: MaterialStateProperty.all(0),
                            ),
                            child: Text(AppLocalizations.of(context)!.cancel, style: const TextStyle(color: Color(0xFF002A67), fontSize: 17, fontWeight: FontWeight.w600, letterSpacing: 0.2),),
                            onPressed: () {
                              Navigator.of(context).pop();
                              next();
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40,),
                  ],
                )),
              ],
            ),
          );
        },
      );
    }
  }
}
