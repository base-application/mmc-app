import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mmc/router/router.gr.dart';
import 'package:mmc/utils/comfun.dart';

class ReferralReceivedPage extends StatefulWidget {
  const ReferralReceivedPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ReferralReceivedPageState();
  }
}

class _ReferralReceivedPageState extends State<ReferralReceivedPage> {

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
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
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
                            Text('My friend want to have an app have.  development………', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500,),),
                            const SizedBox(height: 12,),
                            Text('Wednesday, 3 June 2021 | 10.00am', style: TextStyle(fontSize: 13, color: Colors.white.withAlpha(180), fontWeight: FontWeight.w300,),),
                            const SizedBox(height: 4,),
                            Text('From Cecelia Tay', style: TextStyle(fontSize: 13, color: Colors.white.withAlpha(180), fontWeight: FontWeight.w300,),),
                            const SizedBox(height: 10,),
                            Opacity(
                              opacity: index == 0 ? 0 : 1,
                              child: Row(
                                children: [
                                  Text('Contacted', style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w300,),),
                                  Text(' | ', style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w300,),),
                                  Text(index == 2 ? 'Failed' : 'Success', style: TextStyle(fontSize: 13, color: index == 2 ? Color(0xFF8CBCFF) : Color(0xFFFFB809), fontWeight: FontWeight.w300,),),
                                ],
                              ),
                            ),
                          ],
                        ),
                        if (index == 0) Positioned(child: SizedBox(
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
                              AutoRouter.of(context).push(const ReferralReceivedContactedRoute());
                            },
                          ),
                        ), bottom: 4, right: 2,),
                        if (index == 1) Positioned(child: Image.asset('assets/icon/thank_you_z.png', width: 50,), bottom: 0, right: 0,),
                        if (index == 3) Positioned(child: Image.asset('assets/icon/thank_you_send.png', width: 44,), bottom: 0, right: 0,),
                      ],
                    ),
                  );
                },
              ),
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
