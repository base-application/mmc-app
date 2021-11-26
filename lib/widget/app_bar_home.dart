
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mmc/router/auth_guard.dart';
import 'package:mmc/utils/comm_widget.dart';
import 'package:mmc/utils/st.dart';
import 'package:provider/src/provider.dart';

GlobalKey<_HomeAppBarState> childKeyHomeAppBar = GlobalKey();
class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeAppBarState();
  }

  @override
  Size get preferredSize {
    return const Size.fromHeight(80);
  }
}

class _HomeAppBarState extends State<HomeAppBar> {

  changeNavigationTo(int index) {
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: 26, right: 26),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalizations.of(context)!.homeIndexHello, style: const  TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black87,),),
              const SizedBox(height: 2,),
              Text(context.watch<PersonalProfileService>().getPersonalProfileInfo?.name ?? '-', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87,),),
            ],
          ),
          GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) { return St(); }));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: netImgWrap(context,
                width: 50,
                height: 50,
                url: context.watch<AuthService>().getLoginInfo?.avatar,
                errorWidget: Image.asset('assets/image/personal_head_empty.png', width: 50, height: 50, fit: BoxFit.fitWidth,),
              ),
            ),
          )
        ],
      ),
    );
  }
}
