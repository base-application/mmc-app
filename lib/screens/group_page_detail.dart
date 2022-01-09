import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mmc/bean/group_item_info_entity.dart';
import 'package:mmc/bean/personal_profile_info_entity.dart';
import 'package:mmc/router/router.gr.dart';
import 'package:mmc/utils/comfun.dart';
import 'package:mmc/utils/comm_widget.dart';
import 'package:mmc/utils/dialog.dart';
import 'package:mmc/utils/http_request.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GroupDetailPage extends StatefulWidget {
  const GroupDetailPage({Key? key, required this.info}) : super(key: key);

  final GroupItemInfoEntity info;

  @override
  State<StatefulWidget> createState() {
    return _GroupDetailPageState();
  }
}

class _GroupDetailPageState extends State<GroupDetailPage> {
  final Map<String, int> _gradeSet = {
    'President': 1,
    'Vice President': 2,
    'Secretary': 3,
    'treasurer': 4,
  };
  int? _getGradeSet(String positionName) {
    int? _set;
    _gradeSet.forEach((key, value) {
      if (key.toLowerCase() == positionName.toLowerCase()) {
        _set = value;
        return;
      }
    });
    return _set;
  }

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      title: widget.info.groupName,
      bodyTop: Container(
        padding: const EdgeInsets.only(top: 20, bottom: 20, left: 18, right: 18),
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(child: Container(
              height: 60,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Color(0xFFFBB713),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(14), bottomLeft: Radius.circular(14),)
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Total refer', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Color(0xFF0B43A0),),),
                  const SizedBox(width: 6,),
                  Text(widget.info.refer.formatNumber() ?? '0', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0B43A0),),),
                ],
              ),
            ),),
            Container(
              width: 1,
              height: 60,
              color: Colors.white,
            ),
            Expanded(child: Container(
              height: 60,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Color(0xFFFBB713),
                borderRadius: BorderRadius.only(topRight: Radius.circular(14), bottomRight: Radius.circular(14),)
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Total support', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Color(0xFF0B43A0),),),
                  const SizedBox(width: 6,),
                  Text(widget.info.thankYouNote.formatNumber() ?? '0', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0B43A0),),),
                ],
              ),
            ),),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF0B43A0),
              Color(0xFF2B5BDC),
            ],
          ),
        ),
        child: ScrollConfiguration(
          behavior: CusBehavior(),
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 20, bottom: 20, left: 22, right: 22,),
            itemCount: widget.info.userInfoVos?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              GroupItemInfoUserInfoVos item = (widget.info.userInfoVos ?? []).elementAt(index);
              return GestureDetector(
                onTap: (){
                  FocusScope.of(context).requestFocus(FocusNode());
                  AutoRouter.of(context).push<PersonalProfileInfoEntity>(NetworkPersonRoute(userId: item.userId,)).then((value) {
                    if(value!=null){
                      item.name = value.name;
                      item.industry = value.industry;
                      item.picture = value.picture;
                      item.positionName = value.positionName;
                      item.friend = value.friend;
                    }
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 12,),
                  child: Row(
                    children: [
                      netImgWrap(context,
                        width: 66,
                        height: 66,
                        radius: 66,
                        url: item.picture,
                        errorWidget: Image.asset('assets/image/personal_head_empty.png', fit: BoxFit.fitWidth, width: 66, height: 66,),
                      ),
                      const SizedBox(width: 12,),
                      Expanded(child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.name ?? '', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white,),),
                          const SizedBox(height: 8,),
                          Text(item.industry ?? '', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: Colors.white.withAlpha(180),), maxLines: 2, overflow: TextOverflow.ellipsis,),
                        ],
                      ),),
                      const SizedBox(width: 4,),
                      item.positionName != null && _getGradeSet(item.positionName!) != null ? Image.asset('assets/icon/group_user_grade_${_getGradeSet(item.positionName!)}.png', width: 30, height: 30,) : const SizedBox(width: 30,),
                      const SizedBox(width: 12,),
                      GestureDetector(
                        child: Image.asset(item.friend == true ? 'assets/icon/item_like.png' : 'assets/icon/item_no_like.png', width: 26, height: 26,),
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          showDialog(
                            context: context,
                            barrierColor: Colors.black.withAlpha(180),
                            barrierDismissible: true,
                            builder: (BuildContext ctx) {
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
                                        Padding(
                                          padding: const EdgeInsets.only(left: 14, right: 14,),
                                          child: Text(item.friend == true ? AppLocalizations.of(ctx)!.confirmUndoApplyFriend : AppLocalizations.of(ctx)!.confirmApplyFriend, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600,), textAlign: TextAlign.center,),
                                        ),
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
                                                child: Text(AppLocalizations.of(ctx)!.yes, style: const TextStyle(color: Color(0xFF002A67), fontSize: 17, fontWeight: FontWeight.w600, letterSpacing: 0.2),),
                                                onPressed: () {
                                                  Navigator.of(ctx).pop();
                                                  userFollowAdd(context, userId: item.userId, result: () {
                                                    ComFun.showToast(msg: item.friend == true ? AppLocalizations.of(context)!.friendUndoApplySuccessToast : AppLocalizations.of(context)!.friendApplySuccessToast);
                                                    setState(() {
                                                      item.friend = !(item.friend == true);
                                                    });
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
                                                child: Text(AppLocalizations.of(ctx)!.cancel, style: const TextStyle(color: Color(0xFF002A67), fontSize: 17, fontWeight: FontWeight.w600, letterSpacing: 0.2),),
                                                onPressed: () {
                                                  Navigator.of(ctx).pop();
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
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
