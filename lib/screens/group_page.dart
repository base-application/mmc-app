import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mmc/bean/group_item_info_entity.dart';
import 'package:mmc/router/auth_guard.dart';
import 'package:mmc/router/router.gr.dart';
import 'package:mmc/utils/comfun.dart';
import 'package:mmc/utils/comm_widget.dart';
import 'package:mmc/utils/http_request.dart';
import 'package:provider/provider.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GroupPageState();
  }
}

class _GroupPageState extends State<GroupPage> {
  final List<GroupItemInfoEntity> pageList = [];

  final TextEditingController _groupSearchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getPageData();
  }

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      title: AppLocalizations.of(context)!.pageGroupTitle,
      bodyTop: Container(
        height: 40,
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 4,),
        decoration: BoxDecoration(
          color: const Color(0xFFFBB714),
          borderRadius: BorderRadius.circular(40)
        ),
        child: TextFormField(
          controller: _groupSearchController,
          cursorColor: Colors.blueAccent,
          textAlign: TextAlign.center,
          style: const TextStyle(textBaseline: TextBaseline.alphabetic),
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.pageGroupHeadSearchTip,
            hintStyle: const TextStyle(fontSize: 14, color: Color(0xFF002A67)),
            contentPadding: const EdgeInsets.only(top: 10,),
            isDense: true,
            border: InputBorder.none,
          ),
          onEditingComplete: () {
            FocusScope.of(context).requestFocus(FocusNode());
            _getPageData(groupName: _groupSearchController.text.trim());
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20),)
        ),
        child: Stack(
          children: [
            ScrollConfiguration(
              behavior: CusBehavior(),
              child: pageList.isEmpty ? stateNoDate(inRef: true) : GridView.builder(
                padding: EdgeInsets.zero.copyWith(top: 30, bottom: 30, left: 22, right: 22,),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 3 / 4,
                ),
                itemCount: pageList.length,
                itemBuilder: (BuildContext context, int index) {
                  GroupItemInfoEntity itemInfo = pageList[index];
                  return GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.only(top: 18, left: 10, right: 10,),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color(0xFF043484),
                            Color(0xFF2B5BDC),
                          ],
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(itemInfo.groupName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Color(0xFFFBB714)), textAlign: TextAlign.center,),
                          const SizedBox(height: 18,),
                          const Text('Refer and support:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),),
                          const SizedBox(height: 24,),
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Text('MYR', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white), textAlign: TextAlign.center, maxLines: 4, overflow: TextOverflow.ellipsis,),
                                    const SizedBox(width: 4,),
                                    Text(itemInfo.thankYouNote.formatNumber() ?? '0', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w400, color: Colors.white), textAlign: TextAlign.center, maxLines: 4, overflow: TextOverflow.ellipsis,),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 14,),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: ((itemInfo.userInfoVos ?? []).length > 4 ? 4 : (itemInfo.userInfoVos ?? []).length) * 16 + 6,
                                height: 22,
                                child: StatefulBuilder(builder: (ctx, setSta) {
                                  List<Widget> _item() {
                                    List<Widget> items = [];
                                    (itemInfo.userInfoVos ?? []).take(4).toList().asMap().forEach((index, value) {
                                      items.add(Positioned(
                                        child: Container(
                                          width: 22,
                                          height: 22,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.all(Radius.circular(100)),
                                            border: Border.all(width: 1, color: Colors.white,),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(100),
                                            child: netImgWrap(context,
                                              url: value.picture,
                                              errorWidget: Image.asset('assets/image/personal_head_empty.png', fit: BoxFit.fitWidth, width: 22, height: 22,),
                                            ),
                                          ),
                                        ),
                                        left: index * 16,
                                      ));
                                    });
                                    return items;
                                  }
                                  return Stack(
                                    fit: StackFit.loose,
                                    children: _item(),
                                  );
                                }),
                              ),
                              if ((itemInfo.userInfoVos ?? []).length > 4) const SizedBox(width: 6,),
                              if ((itemInfo.userInfoVos ?? []).length > 4) Text('+${(itemInfo.userInfoVos ?? []).length - 4}', style: TextStyle(fontSize: 16, color: Colors.amber.shade500,),),
                            ],
                          ),
                          const SizedBox(height: 18,),
                        ],
                      ),
                    ),
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      if(Provider.of<AuthService>(context, listen: false).getLoginInfo?.token == null){
                        AutoRouter.of(context).push(SignUpRoute(type: 1));
                      }else{
                        AutoRouter.of(context).push(GroupDetailRoute(info: itemInfo));
                      }
                    },
                  );
                },
              ),
            ),
            Positioned(child: Container(
              height: 12,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.white.withOpacity(0),
                  ],
                ),
              ),
            ),),
          ],
        ),
      ),
      onRefresh: () async {
        _getPageData();
      },
    );
  }

  Future _getPageData({ String? groupName }) async {
    return await getGroupListUserData(context, groupName: groupName, result: (List<GroupItemInfoEntity> list) {
      setState(() {
        pageList.clear();
        pageList.addAll(list);
      });
    });
  }
}
