import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mmc/bean/referral_entity.dart';
import 'package:mmc/router/auth_guard.dart';
import 'package:mmc/utils/comfun.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mmc/utils/http_request.dart';
import 'package:provider/src/provider.dart';

class ReferralReceivedContactedPage extends StatefulWidget {
  final ReferralEntity referralEntity;
  const ReferralReceivedContactedPage({Key? key, required this.referralEntity}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ReferralReceivedContactedPageState();
  }
}

class _ReferralReceivedContactedPageState extends State<ReferralReceivedContactedPage> {
  bool _confirmSend = false;
  int _chooseSuccess = 2;
  final TextEditingController _fileMessage = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget _scroll() {
      return SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 14, left: 26, right: 26, bottom: 30,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: Container(
                    padding: const EdgeInsets.only(top: 14, bottom: 14, left: 18, right: 18,),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFBB714),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text('From '+ (widget.referralEntity.fromName??""), style: TextStyle(fontSize: 14, color: Color(0xFF013B7B), fontWeight: FontWeight.w400,),),
                  ),),
                ],
              ),
              const SizedBox(height: 28,),
              Text('Description', style: TextStyle(fontSize: 14, color: Colors.black87.withAlpha(200), fontWeight: FontWeight.w500,),),
              const SizedBox(height: 8,),
              Container(
                padding: const EdgeInsets.only(top: 12, bottom: 12, left: 16, right: 16,),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 0.6, color: Colors.grey.shade300,)
                ),
                child: Text(widget.referralEntity.fromName??"", style: TextStyle(fontSize: 13, color: Colors.black87.withAlpha(200), fontWeight: FontWeight.w500,),),
              ),
              const SizedBox(height: 28,),
              Text('Name Card', style: TextStyle(fontSize: 14, color: Colors.black87.withAlpha(200), fontWeight: FontWeight.w500,),),
              const SizedBox(height: 8,),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.7 * 10 / 16,
                child: ScrollConfiguration(
                  behavior: CusBehavior(),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.referralEntity.picture?.length??0,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.width * 0.7 * 9 / 16,
                        margin: EdgeInsets.only(right: index < 2 - 1 ? 20 : 0),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: context.read<SystemSetService>().baseUrl + widget.referralEntity.picture![index].url,
                          placeholder: (BuildContext context, String url,) {
                            return Container(color: Colors.grey.shade300,);
                          },
                          fit: BoxFit.fill,
                          errorWidget: (BuildContext context, String url, dynamic error,) {
                            return Container(color: Colors.grey.shade300,);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget _sendConfirm() {
      return Container(
        padding: const EdgeInsets.only(top: 40, left: 22, right: 22,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('You have clicked contacted button, may we know how the status?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87,),),
            const SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 140,
                  height: 48,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.6, color: Colors.deepOrange),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(_chooseSuccess == 2 ? Colors.deepOrange : Colors.white),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                      elevation: MaterialStateProperty.all(0),
                    ),
                    child: Text(AppLocalizations.of(context)!.btnSuccess, style: TextStyle(color: _chooseSuccess == 2 ? Colors.white : Colors.deepOrange, fontSize: 16, fontWeight: FontWeight.bold,),),
                    onPressed: () async {
                      setState(() {
                        _chooseSuccess = 2;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 18,),
                Container(
                  width: 140,
                  height: 48,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.6, color: Colors.indigo),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(_chooseSuccess == 3 ? Colors.indigo : Colors.white),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                      elevation: MaterialStateProperty.all(0),
                    ),
                    child: Text(AppLocalizations.of(context)!.btnFail, style: TextStyle(color: _chooseSuccess == 3 ? Colors.white : Colors.indigo, fontSize: 16, fontWeight: FontWeight.bold,),),
                    onPressed: () async {
                      setState(() {
                        _chooseSuccess = 3;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 26,),
            if (_chooseSuccess == 3) Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('If fail, please fill in reason below:', style: TextStyle(fontSize: 14, color: Colors.deepOrange, fontWeight: FontWeight.bold,),),
                const SizedBox(height: 8,),
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
                    controller: _fileMessage,
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.blueAccent,
                    maxLines: 4,
                    style: const TextStyle(textBaseline: TextBaseline.alphabetic),
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(fontSize: 14, color: Colors.black38),
                      contentPadding: EdgeInsets.only(top: 12,),
                      counterText: '',
                      isDense: true,
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return PageContainer(
      title: 'Referral Received',
      titleBarBgColor: Colors.white,
      pageBg: _confirmSend ? Colors.white : null,
      body: !_confirmSend ? Stack(
        fit: StackFit.expand,
        children: [
          ScrollConfiguration(
            behavior: CusBehavior(),
            child: _scroll(),
          ),
          Positioned(child: Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 52,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(const Color(0xFFFBB714)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                  elevation: MaterialStateProperty.all(0),
                ),
                child: Text(AppLocalizations.of(context)!.btnContacted, style: const TextStyle(color: Color(0xFF013B7B), fontSize: 16, fontWeight: FontWeight.bold,),),
                onPressed: () async {
                  setState(() {
                    _confirmSend = true;
                  });
                },
              ),
            ),
          ), bottom: MediaQuery.of(context).padding.bottom + 20, left: 0,),
        ],
      ) : Stack(
        fit: StackFit.expand,
        children: [
          _sendConfirm(),
          Positioned(child: Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 52,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(const Color(0xFFFBB714)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                  elevation: MaterialStateProperty.all(0),
                ),
                child: Text(AppLocalizations.of(context)!.btnSend, style: const TextStyle(color: Color(0xFF013B7B), fontSize: 16, fontWeight: FontWeight.bold,),),
                onPressed: () async {
                  if(_chooseSuccess == 3 && _fileMessage.text.isEmpty){
                    ComFun.showToast(msg: "添加消息");
                    return;
                  }
                  received(context, referralId: widget.referralEntity.referralId!, status: _chooseSuccess,failMessage: _fileMessage.text,result: (o) {
                    if(o){
                      widget.referralEntity.status = _chooseSuccess;
                      AutoRouter.of(context).pop<ReferralEntity?>(widget.referralEntity);
                    }
                  });
                },
              ),
            ),
          ), bottom: MediaQuery.of(context).padding.bottom + 20, left: 0,),
        ],
      ),
    );
  }
}
