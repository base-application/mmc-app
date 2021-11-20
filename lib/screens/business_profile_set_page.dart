import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mmc/bean/personal_profile_info_entity.dart';
import 'package:mmc/router/auth_guard.dart';
import 'package:mmc/router/router.gr.dart';
import 'package:mmc/utils/comfun.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mmc/utils/comm_widget.dart';
import 'package:mmc/utils/dialog.dart';
import 'package:mmc/utils/event_bus.dart';
import 'package:mmc/utils/http_request.dart';
import 'package:provider/src/provider.dart';

class BusinessProfileSetPage extends StatefulWidget {
  const BusinessProfileSetPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BusinessProfileSetPageState();
  }
}

class _BusinessProfileSetPageState extends State<BusinessProfileSetPage> {
  List<PersonalProfileInfoCompanyVos> companyVos = [];

  late StreamSubscription _companyListInfoChangeEvent;

  @override
  void initState() {
    super.initState();
    _companyListInfoChangeEvent = eventBus.on<CompanyListInfoChangeEvent>().listen((event) async {
      _getDataList(silence: true);
    });
    _getDataList();
  }

  @override
  void dispose() {
    _companyListInfoChangeEvent.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget _scroll() {
      return SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.only(top: 10, left: 26, right: 26, bottom: 30,),
          height: companyVos.isEmpty ? MediaQuery.of(context).size.height - 200 : null,
          child: Column(
            children: [
              if (companyVos.isEmpty) Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 50,),
                child: Text(AppLocalizations.of(context)!.createBusinessProfileTip, style: const TextStyle(fontSize: 14, color: Colors.black87,), textAlign: TextAlign.center,),
              ),
              if (companyVos.isNotEmpty) ListView.builder(
                padding: EdgeInsets.zero.copyWith(bottom: 20),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: companyVos.length,
                itemBuilder: (ctx, index) {
                  PersonalProfileInfoCompanyVos companyItem = companyVos[index];
                  return Container(
                    height: 80,
                    margin: const EdgeInsets.only(top: 10,),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF043B94),
                          Color(0xFF095BD4),
                        ],
                      ),
                    ),
                    child: GestureDetector(
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          SizedBox(
                            height: 80,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(child: Row(
                                  children: [
                                    const SizedBox(width: 14,),
                                    netImgWrap(context,
                                      width: 50,
                                      height: 50,
                                      radius: 10,
                                      url: companyItem.companyLogo,
                                      errorWidget: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.amber,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10,),
                                    Expanded(child: Text(companyItem.companyName ?? '', style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold,), overflow: TextOverflow.ellipsis,),),
                                  ],
                                ),),
                                Container(
                                  width: 72,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0xFF043B94),
                                        Color(0xFF095BD4),
                                      ],
                                    ),
                                  ),
                                  child: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.white,),
                                ),
                              ],
                            ),
                          ),
                          Slidable(
                            actionPane: const SlidableStrechActionPane(),
                            actionExtentRatio: 0.2,
                            child: Container(),
                            secondaryActions: [
                              SlideAction(
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0xFF043B94),
                                        Color(0xFF095BD4),
                                      ],
                                    ),
                                  ),
                                  child: const Icon(Icons.delete_forever_rounded, color: Colors.white,),
                                ),
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    barrierColor: Colors.black.withAlpha(180),
                                    barrierDismissible: true,
                                    builder: (BuildContext context) {
                                      return DialogWidget(
                                        title: '',
                                        content: '',
                                        slideMargin: 4,
                                        showTitle: false,
                                        showBottomDo: false,
                                        borderRadius: 14,
                                        outTapDismiss: true,
                                        contentExtend: Row(
                                          children: [
                                            Expanded(child: Column(
                                              children: [
                                                const SizedBox(height: 30,),
                                                Text(AppLocalizations.of(context)!.confirmDeleteCompany, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600,), textAlign: TextAlign.center,),
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
                                                          Navigator.of(context).pop();
                                                          deleteCompany(context, companyId: companyItem.companyId, result: () {
                                                            ComFun.showToast(msg: AppLocalizations.of(context)!.deleteCompanySuccessToast);
                                                            _getDataList();
                                                          });
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
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        AutoRouter.of(context).push(BusinessProfileCreateRoute(info: companyItem));
                      },
                    ),
                  );
                },
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 80,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(const Color(0xFFDFE5ED)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    elevation: MaterialStateProperty.all(0),
                  ),
                  child: const Icon(Icons.add_circle_rounded, size: 26, color: Color(0xFF013B7B),),
                  onPressed: () async {
                    AutoRouter.of(context).push(BusinessProfileCreateRoute());
                  },
                ),
              ),
              const SizedBox(height: 120,),
            ],
          ),
        ),
      );
    }

    return PageContainer(
      title: 'Business Profile',
      titleBarBgColor: Colors.white,
      body: _scroll(),
      onRefresh: () async {
        _getDataList();
      },
    );
  }

  /// 获取公司列表数据
  Future _getDataList({ bool silence = false }) async {
    return getUserDetailData(context, userId: context.read<AuthService>().getLoginInfo!.id, silence: silence, result: (PersonalProfileInfoEntity info) async {
      savePersonalProfileInfo(context, context.read<AuthService>().getLoginInfo!.id, info);
      companyVos = info.companyVos;
      setState(() {});
    });
  }
}
