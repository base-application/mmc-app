import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mmc/bean/group_item_entity.dart';
import 'package:mmc/bean/image_vo_entity.dart';
import 'package:mmc/bean/network_item_info_entity.dart';
import 'package:mmc/utils/comfun.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mmc/utils/comm_widget.dart';
import 'package:mmc/utils/http.dart';
import 'package:mmc/utils/http_request.dart';

class SendingReferralPage extends StatefulWidget {
  const SendingReferralPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SendingReferralPageState();
  }
}

class _SendingReferralPageState extends State<SendingReferralPage> {
  GroupItemEntity? _formToGroup;
  final TextEditingController _sendReferralWhyDetailController = TextEditingController();
  final List<ImageVoEntity> _formUpload = [];
  NetworkItemInfoEntity? _receivedUser;

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      title: AppLocalizations.of(context)!.pageSendReferralTitle,
      body: ScrollConfiguration(
        behavior: CusBehavior(),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 10, left: 26, right: 26, bottom: 30,),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 12, bottom: 12, left: 14, right: 14,),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFBB714),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(AppLocalizations.of(context)!.referralTitle, style: const TextStyle(fontSize: 16, color: Color(0xFF013B7B)),),
                ),
                const SizedBox(height: 30,),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/icon/form_required.png', width: 8, height: 8,),
                            const SizedBox(width: 6,),
                            Text(AppLocalizations.of(context)!.sendReferralToLabel, style: TextStyle(fontSize: 15, color: Colors.black87.withAlpha(200),),),
                          ],
                        ),
                        const SizedBox(height: 8,),
                        GestureDetector(
                          child: Container(
                            width: double.infinity,
                            height: 44,
                            padding: const EdgeInsets.only(left: 14, right: 10,),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(width: 0.6, color: Colors.grey.shade300,)
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(_formToGroup?.groupName ?? AppLocalizations.of(context)!.sendReferralFormItemHintChooseGroupIfAny, style: TextStyle(fontSize: 14, color: _formToGroup == null ? Colors.black38 : Colors.black87,), overflow: TextOverflow.ellipsis,),
                                ),
                                const Icon(Icons.arrow_drop_down_rounded, size: 22, color: Colors.black54,),
                              ],
                            ),
                          ),
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            getGroupListData(context, result: (List<GroupItemEntity> list) {
                              showModalBottomSheet(
                                  context: context,
                                  constraints: BoxConstraints(
                                    maxHeight: MediaQuery.of(context).size.height/2,
                                    minHeight: MediaQuery.of(context).size.height/3,
                                  ),
                                  builder: (BuildContext context) {
                                    return  ListView.separated(
                                      padding: EdgeInsets.only(top: 20,bottom: MediaQuery.of(context).padding.bottom),
                                      itemCount: list.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return GestureDetector(
                                          onTap: (){
                                            _formToGroup = list[index];
                                            setState(() {});
                                            Navigator.of(context).pop();
                                          },
                                          child:  Padding(
                                            padding: const EdgeInsets.only(left: 16,right: 16,top: 5,bottom: 5),
                                            child: Text(list[index].groupName),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (BuildContext context, int index) {
                                        return const Divider();
                                      },
                                    );
                                  });
                            });
                          },
                        ),
                      ],
                    ),),
                  ],
                ),
                const SizedBox(height: 12,),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          child: Container(
                            width: double.infinity,
                            height: 44,
                            padding: const EdgeInsets.only(left: 14, right: 10,),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(width: 0.6, color: Colors.grey.shade300,)
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(_receivedUser?.name ?? AppLocalizations.of(context)!.sendReferralFormItemHintChooseNetwork, style: TextStyle(fontSize: 14, color: _receivedUser == null ? Colors.black38 : Colors.black87,), overflow: TextOverflow.ellipsis,),
                                ),
                                const Icon(Icons.arrow_drop_down_rounded, size: 22, color: Colors.black54,),
                              ],
                            ),
                          ),
                          behavior: HitTestBehavior.opaque,
                          onTap: _showNetWork,
                        ),
                      ],
                    ),),
                  ],
                ),
                const SizedBox(height: 30,),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/icon/form_required.png', width: 8, height: 8,),
                            const SizedBox(width: 6,),
                            Text(AppLocalizations.of(context)!.sendReferralWhyLabel, style: TextStyle(fontSize: 15, color: Colors.black87.withAlpha(200),),),
                          ],
                        ),
                        const SizedBox(height: 8,),
                        Text(AppLocalizations.of(context)!.sendReferralWhyDetail, style: TextStyle(fontSize: 14, color: Colors.black87.withAlpha(140),),),
                        const SizedBox(height: 10,),
                        Container(
                          width: double.infinity,
                          height: 110,
                          padding: const EdgeInsets.only(left: 10, right: 10,),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 0.6, color: Colors.grey.shade300,)
                          ),
                          child: TextFormField(
                            controller: _sendReferralWhyDetailController,
                            keyboardType: TextInputType.text,
                            maxLength: 100,
                            maxLines: 4,
                            cursorColor: Colors.blueAccent,
                            style: const TextStyle(textBaseline: TextBaseline.alphabetic),
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!.sendReferralWhyDetailHint,
                              hintStyle: const TextStyle(fontSize: 14, color: Colors.black38),
                              contentPadding: const EdgeInsets.only(top: 10,),
                              // counterText: '',
                              isDense: true,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),),
                  ],
                ),
                const SizedBox(height: 30,),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLocalizations.of(context)!.sendReferralUploadNameCardLabel, style: TextStyle(fontSize: 15, color: Colors.black87.withAlpha(200),),),
                        const SizedBox(height: 8,),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 18,
                            mainAxisSpacing: 18,
                          ),
                          itemCount: _formUpload.length + 1,
                          itemBuilder: (BuildContext context, int index) {
                            if (index < _formUpload.length) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFDEE5ED),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: netImgWrap(context,
                                  url: _formUpload[index].url,
                                  radius: 12,
                                  fit: BoxFit.fitHeight,
                                  errorWidget: Container(color: Colors.grey.shade300,),
                              ));
                            }
                            return GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFDEE5ED),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(Icons.add_circle, color: Color(0xFF0753C4), size: 26,),
                              ),
                              behavior: HitTestBehavior.opaque,
                              onTap: () async {
                                String uploadPath = await httpUpload(context);
                                ImageVoEntity e = ImageVoEntity();
                                e.url = uploadPath;
                                _formUpload.add(e);
                                setState(() {});
                              },
                            );
                          },
                        ),
                      ],
                    ),),
                  ],
                ),
                const SizedBox(height: 40,),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 46,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(const Color(0xFFFBB714)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                      elevation: MaterialStateProperty.all(0),
                    ),
                    child: Text(AppLocalizations.of(context)!.sendReferralSubmitBtn, style: const TextStyle(color: Color(0xFF013B7B), fontWeight: FontWeight.w500,),),
                    onPressed: () async {
                      if(_sendReferralWhyDetailController.text.isEmpty){
                        ComFun.showToast(msg:AppLocalizations.of(context)!.referralReason);
                        return;
                      }
                      if(_formUpload.isEmpty){
                        ComFun.showToast(msg:AppLocalizations.of(context)!.referralImage);
                        return;
                      }
                      if(_receivedUser==null){
                        ComFun.showToast(msg:AppLocalizations.of(context)!.referralReceivedUser);
                        return;
                      }
                      sendReferral(context, reason: _sendReferralWhyDetailController.text, images: _formUpload,receivedUser: _receivedUser!.userId, result: (v) {
                        AutoRouter.of(context).pop();
                      });
                    },
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showNetWork() {
    getMyNetwork(context,groupId: _formToGroup?.groupId,result: (List<NetworkItemInfoEntity> list) {
      if(list.isEmpty){
        ComFun.showToast(msg: AppLocalizations.of(context)!.notHaveNetwork);
        return;
      }
      showModalBottomSheet(
          isDismissible: false,
          isScrollControlled: true,
          context: context,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height/1.5,
            minHeight: MediaQuery.of(context).size.height/3,
          ),
          builder: (BuildContext context) {
            return NetWorkSelect(list: list, onTap: (v) {
              _receivedUser = v;
              setState(() {});
              AutoRouter.of(context).pop();
            },);
          });
    });
  }
}



class NetWorkSelect extends StatefulWidget {
  final List<NetworkItemInfoEntity> list;
  final Function(NetworkItemInfoEntity) onTap;
  const NetWorkSelect({Key? key, required this.list, required this.onTap}) : super(key: key);

  @override
  _NetWorkSelectState createState() => _NetWorkSelectState();
}

class _NetWorkSelectState extends State<NetWorkSelect> {
  List<NetworkItemInfoEntity> _list =[];
  @override
  void initState() {
    _list = widget.list;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16,right: 16,bottom: MediaQuery.of(context).padding.bottom,top: 10),
      child:  Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.sendReferralWhyDetailHint,
                      hintStyle: const TextStyle(fontSize: 14, color: Colors.black38),
                      contentPadding: const EdgeInsets.all(10),
                      isDense: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300)
                      ),
                    ),
                    onChanged: (v){
                      if(v.isEmpty){
                        _list = widget.list;
                      }else{
                        _list = widget.list.where((element) => element.name!.toLowerCase().contains(v.toLowerCase())).toList();
                      }
                      setState((){});
                    },
                  )
              ),
              const SizedBox(width: 10,),
              GestureDetector(
                  onTap: (){
                    AutoRouter.of(context).pop();
                  },
                  child: const Icon(CupertinoIcons.clear_circled))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView.separated(
                itemCount: _list.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: (){
                      widget.onTap(_list[index]);
                    },
                    child: Row(
                      children: [
                        netImgWrap(context, errorWidget: Image.asset('assets/image/personal_head_empty.png', fit: BoxFit.fitWidth,width: 40,height: 40),url: _list[index].picture,width: 40,height: 40,radius: 30),
                        const SizedBox(width: 20,),
                        Text(_list[index].name??"")
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },)
          )
        ],
      ),
    );
  }
}
