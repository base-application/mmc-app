import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mmc/bean/advertisement_entity.dart';
import 'package:mmc/bean/app_version_entity.dart';
import 'package:mmc/bean/personal_profile_info_entity.dart';
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
  AdvertisementEntity? _advertisementEntity;
  int time = 3;
  @override
  void initState() {
    advertisementPull(context).then((value) {
      _advertisementEntity = value;
      setState(() {});
      advTime();
    }).catchError((e){
      advTime();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: _advertisementEntity!=null ?
          Image.network(
            Provider.of<SystemSetService>(context, listen: false).baseUrl + _advertisementEntity!.advertisementPoster,
            fit: BoxFit.cover,
            errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace,){
              return Image.asset("assets/image/app_launch.png",fit: BoxFit.cover);
            },
          ) :
          Image.asset("assets/image/app_launch.png",fit: BoxFit.cover),
        ),
        Positioned(
            top: MediaQuery.of(context).padding.top,
            right: 20,
            child: Container(
              width: 50,
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(50)
              ),
              child: Text(time.toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
            ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  advTime(){
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if(time>0){
        time--;
        setState(() {});
      }else{
        _timer.cancel();
        checkAppVersion();
      }
    });
  }

  checkAppVersion(){
    checkVersion(context).then((value) {
      if(value==null){
        next();
      }else{
        updateVersion(value);
      }
    }).catchError((e){
      netWorkError();
    });
  }
  netWorkError(){
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
                  Text(AppLocalizations.of(context)!.netWorkError, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600,), textAlign: TextAlign.center,),
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
                          onPressed: () {
                            checkAppVersion();
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
                           exit(0);
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

  updateVersion(AppVersionEntity value){
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

  next(){
    initLoginInfo(context).then((value){
      if(Provider.of<AuthService>(context, listen: false).getLoginInfo?.token != null){
        ///完善资料
        if(ComFun.isPerfect(context)){
          AutoRouter.of(context).replaceAll([HomeRoute(),PersonalProfileSetRoute()]);
        }else{
          AutoRouter.of(context).replaceAll([HomeRoute()]);
        }
      }else{
        AutoRouter.of(context).replaceAll([WelcomeRoute()]);
      }
    });
  }
}
