import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:mmc/bean/referral_entity.dart';
import 'package:mmc/router/router.gr.dart';
import 'package:mmc/utils/comfun.dart';
import 'package:mmc/utils/http_request.dart';

class ReferralReceivedPage extends StatefulWidget {
  const ReferralReceivedPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ReferralReceivedPageState();
  }
}

class _ReferralReceivedPageState extends State<ReferralReceivedPage> {
  late Future<List<ReferralEntity>> _future;
  @override
  void initState() {
    _future = receivedList(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget _scroll() {
      return SingleChildScrollView(
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
                child: Text('Referral received from our MMC network.Get ready to contact. WooHoo~~~', style: TextStyle(fontSize: 16, color: Color(0xFF013B7B)),),
              ),
              const SizedBox(height: 14,),
             FutureBuilder(
               future: _future,
               builder: (BuildContext context, AsyncSnapshot<List<ReferralEntity>> snapshot) {
                 if(snapshot.connectionState == ConnectionState.done){
                   if(!snapshot.hasData){
                     return  Center(
                         child: Image.asset('assets/image/no_data.png', height: 140,)
                     );
                   }
                   return  ListView.builder(
                     shrinkWrap: true,
                     physics: const NeverScrollableScrollPhysics(),
                     itemCount: snapshot.data!.length,
                     itemBuilder: (BuildContext context, int index) {
                       return ReferralCard(referralEntity: snapshot.data![index],
                         onChange: (ReferralEntity v) {
                          snapshot.data![index] = v;
                          setState(() {});
                         },);
                     },
                   );
                 }else{
                   return  Center(
                     child: Image.asset('assets/image/no_data.png', height: 140,)
                   );
                 }

               },)
            ],
          ),
        ),
      );
    }

    return PageContainer(
      title: 'Referral Received',
      body: ScrollConfiguration(
        behavior: CusBehavior(),
        child: _scroll(),
      ),
    );
  }
}



class ReferralCard extends StatefulWidget {
  final ReferralEntity referralEntity;
  final Function(ReferralEntity v) onChange;
  const ReferralCard({Key? key, required this.referralEntity, required this.onChange}) : super(key: key);

  @override
  _ReferralCardState createState() => _ReferralCardState();
}

class _ReferralCardState extends State<ReferralCard> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14,),
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 14, right: 14,),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF043B94),
            Color(0xFF095BD4),
          ],
        ),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.referralEntity.reason??'………', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500,),),
              const SizedBox(height: 12,),
              Text(DateFormat('EEEE, d MMMM yyyy | h:mm a', Localizations.localeOf(context).languageCode == 'en' ? 'en_US' : 'zh_CN').format(DateTime.fromMillisecondsSinceEpoch(widget.referralEntity.sendTime??0)), style: TextStyle(fontSize: 13, color: Colors.white.withAlpha(180), fontWeight: FontWeight.w300,),),
              const SizedBox(height: 4,),
              Text('From '+ (widget.referralEntity.fromName??""), style: TextStyle(fontSize: 13, color: Colors.white.withAlpha(180), fontWeight: FontWeight.w300,),),
              const SizedBox(height: 10,),
              Opacity(
                opacity: widget.referralEntity.status==1 ? 0 : 1,
                child: Row(
                  children: [
                    Text('Contacted', style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w300,),),
                    Text(' | ', style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w300,),),
                    Text(widget.referralEntity.status == 3 ? 'Failed' : 'Success', style: TextStyle(fontSize: 13, color: widget.referralEntity.status == 3 ? Color(0xFF8CBCFF) : Color(0xFFFFB809), fontWeight: FontWeight.w300,),),
                  ],
                ),
              ),
            ],
          ),
          if ( widget.referralEntity.status == 1) Positioned(child: SizedBox(
            width: 90,
            height: 36,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(const Color(0xFFFBB714)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                elevation: MaterialStateProperty.all(0),
              ),
              child: const Text('Contacted', style: TextStyle(color: Color(0xFF013B7B), fontSize: 12, fontWeight: FontWeight.w600,),),
              onPressed: () {
                AutoRouter.of(context).push<ReferralEntity?>(ReferralReceivedContactedRoute(referralEntity: widget.referralEntity)).then((value){
                  if(value!=null){
                    widget.referralEntity.status = value.status;
                    widget.onChange(value);
                  }
                });
              },
            ),
          ), bottom: 4, right: 2,),
          if (widget.referralEntity.status != 1&&(widget.referralEntity.thank??true)) Positioned(
            bottom: 0, right: 0,
            child: GestureDetector(
              onTap: (){

              },
              child: Image.asset('assets/icon/thank_you_z.png', width: 50,),
            )),
          if (widget.referralEntity.status != 1&&!(widget.referralEntity.thank??false)) Positioned(
              bottom: 0, right: 0,
              child: GestureDetector(
                onTap: (){
                  AutoRouter.of(context).push<bool>(SendThankYouNoteRoute(referralId: widget.referralEntity.referralId!)).then((value) {
                    if(value??false){
                      widget.referralEntity.thank = true;
                      widget.onChange(widget.referralEntity);
                    }
                  });
                },
                child: Image.asset('assets/icon/thank_you_send.png', width: 44,),
              )),
        ],
      ),
    );
  }
}
