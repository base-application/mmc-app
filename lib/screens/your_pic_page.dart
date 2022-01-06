import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mmc/router/auth_guard.dart';
import 'package:mmc/utils/comm_widget.dart';
import 'package:provider/provider.dart';

class YourPicPage extends StatefulWidget {
  const YourPicPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _YourPicPageState();
  }
}

class _YourPicPageState extends State<YourPicPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  const Text("Your Pic"),),
      body: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color:  const Color(0xff015EDB),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding:  const EdgeInsets.all(16),
              child: Row(
                children: [
                  netImgWrap(context,
                    width: 64,
                    height: 64,
                    radius: 50,
                    url: Provider.of(context)
                        .watch<AuthService>().getLoginInfo?.avatar,
                    errorWidget: Image.asset('assets/image/personal_head_empty.png', width: 64,height: 64, fit: BoxFit.fitWidth,),
                  ),
                  const SizedBox(width: 10,),
                  Text(Provider.of(context)
                      .watch<AuthService>().getLoginInfo?.nickname??"-",style:  const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)
                ],
              ),
            ),
            Container(
              padding:  const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(colors: [Colors.white.withOpacity(0.5),Colors.white.withOpacity(0.8)],begin:Alignment.topCenter,end:Alignment.bottomCenter)

              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.email,color: Color(0xff013B7B),),
                      const SizedBox(width: 10,),
                      Text(Provider.of(context)
                          .watch<PersonalProfileService>().getPersonalProfileInfo?.email??"-",style:  const TextStyle(color: Color(0xff013B7B),fontSize: 14))
                    ],
                  ),
                  const Divider(color: Colors.white,height: 20,),
                  Row(
                    children: [
                      const Icon(Icons.phone,color: Color(0xff013B7B)),
                      const SizedBox(width: 10,),
                      Text(Provider.of(context)
                          .watch<PersonalProfileService>().getPersonalProfileInfo?.concatNumber??"-",style:  const TextStyle(color: Color(0xff013B7B),fontSize: 14))
                    ],
                  ),
                  const Divider(color: Colors.white,height: 20,),
                  Row(
                    children: [
                      const  Icon(CupertinoIcons.chat_bubble_2,color: Color(0xff013B7B)),
                      const SizedBox(width: 10,),
                      Text(Provider.of(context)
                          .watch<PersonalProfileService>().getPersonalProfileInfo?.whatsapp ??"-",style:  const TextStyle(color: Color(0xff013B7B),fontSize: 14))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
