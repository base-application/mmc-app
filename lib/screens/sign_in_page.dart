import 'package:auto_route/auto_route.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mmc/bean/home_index_info_entity.dart';
import 'package:mmc/bean/login_info_entity.dart';
import 'package:mmc/bean/personal_profile_info_entity.dart';
import 'package:mmc/router/auth_guard.dart';
import 'package:mmc/router/router.gr.dart';
import 'package:mmc/utils/comfun.dart';
import 'package:mmc/utils/http.dart';
import 'package:mmc/utils/http_request.dart';
import 'package:provider/src/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isShowPwd = false; // 是否显示输入的密码

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.only(left: 16,right: 16),
      decoration: BoxDecoration(
        image: DecorationImage(image: Image.asset("assets/image/login_background.png").image,alignment: Alignment.topCenter),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF043D98),
            Color(0xFF0859D2),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(top: 50,bottom: 30),
              child: Text(AppLocalizations.of(context)!.loginPageWelcome, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFFFBB714),), textAlign: TextAlign.start,),
            ),
           Expanded(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Container(
                   height: 50,
                   decoration: BoxDecoration(
                     color: Colors.white,
                     borderRadius: BorderRadius.circular(10),
                   ),
                   child: TextFormField(
                     controller: _phoneNumberController,
                     keyboardType: TextInputType.number,
                     maxLength: 20,
                     cursorColor: Colors.blueAccent,
                     style: const TextStyle(textBaseline: TextBaseline.alphabetic),
                     decoration: InputDecoration(
                       hintText: AppLocalizations.of(context)!.hintLoginPhoneNumber,
                       hintStyle: const TextStyle(fontSize: 14, color: Colors.black38),
                       contentPadding: const EdgeInsets.only(top: 15, left: 14,),
                       counterText: '',
                       isDense: true,
                       border: InputBorder.none,
                     ),
                   ),
                 ),
                 const SizedBox(
                   height: 16,
                 ),
                 Container(
                   height: 50,
                   decoration: BoxDecoration(
                     color: Colors.white,
                     borderRadius: BorderRadius.circular(10),
                   ),
                   child: TextFormField(
                     controller: _passwordController,
                     keyboardType: TextInputType.multiline,
                     maxLength: 20,
                     cursorColor: Colors.blueAccent,
                     style: const TextStyle(textBaseline: TextBaseline.alphabetic),
                     decoration: InputDecoration(
                       hintText: AppLocalizations.of(context)!.hintLoginPassword,
                       hintStyle: const TextStyle(fontSize: 14, color: Colors.black38),
                       contentPadding: const EdgeInsets.only(top: 15, left: 14,),
                       counterText: '',
                       isDense: true,
                       border: InputBorder.none,
                       suffixIcon: IconButton(
                         splashColor: Colors.transparent,
                         highlightColor: Colors.transparent,
                         icon: Padding(
                           padding: const EdgeInsets.all(6),
                           child: Image.asset(_isShowPwd ? 'assets/icon/login_password_eye_open.png' : 'assets/icon/login_password_eye_close.png', width: 16, height: 16,),
                         ),
                         onPressed: () {
                           setState(() {
                             _isShowPwd = !_isShowPwd;
                           });
                         },
                       ),
                     ),
                     obscureText: !_isShowPwd,
                   ),
                 ),
                 const SizedBox(
                   height: 16,
                 ),
                 SizedBox(
                   width: MediaQuery.of(context).size.width * 0.9,
                   height: 50,
                   child: ElevatedButton(
                     style: ButtonStyle(
                       backgroundColor: MaterialStateProperty.all(const Color(0xFFFBB714)),
                       shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                       elevation: MaterialStateProperty.all(1),
                     ),
                     child: Text(AppLocalizations.of(context)!.signIn, style: const TextStyle(color: Color(0xFF002A67), fontSize: 17, fontWeight: FontWeight.bold, letterSpacing: 1),),
                     onPressed: () {
                       FocusScope.of(context).requestFocus(FocusNode());
                       // if (_countryCode == null || _countryCode!.trim() == '') {
                       //   ComFun.showToast(msg: AppLocalizations.of(context)!.chooseCountryCodeTip, err: true,);
                       // } else
                       if (_phoneNumberController.text.trim() == '') {
                         ComFun.showToast(msg: AppLocalizations.of(context)!.inputLoginAccountTip, err: true,);
                       } else if (_passwordController.text.trim() == '') {
                         ComFun.showToast(msg: AppLocalizations.of(context)!.inputLoginPasswordTip, err: true,);
                       } else {
                         _doSignIn();
                       }
                     },
                   ),
                 ),
                 GestureDetector(
                   child: Padding(
                     padding: const EdgeInsets.all(10),
                     child: Text(AppLocalizations.of(context)!.forgotPasswordAsk, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFFBB714),),),
                   ),
                   behavior: HitTestBehavior.opaque,
                   onTap: () {
                     AutoRouter.of(context).push(SignUpRoute(type: 2));
                   },
                 ),

               ],
             ),
           )
          ],
        ),
        bottomNavigationBar: GestureDetector(
          child: Padding(
            padding: EdgeInsets.only(left: 16,right: 16,bottom: MediaQuery.of(context).padding.bottom),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(AppLocalizations.of(context)!.loginNoAccountTip, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white,),),
                const SizedBox(width: 6,),
                Text(AppLocalizations.of(context)!.toSignUp, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFFBB714),),),
              ],
            ),
          ),
          behavior: HitTestBehavior.opaque,
          onTap: () {
            AutoRouter.of(context).push(SignUpRoute(type: 1));
          },
        ),
      ),
    );
  }


  /// 执行登录操作
  _doSignIn() {
    login(context, account: _phoneNumberController.text.trim(), password: _passwordController.text.trim(), endHideLoading: false, result: (LoginInfoEntity info) async {
      await saveLoginInfo(context, info);
      ///关联用户推送token
      try{
        FirebaseMessaging.instance.getToken().then((value) {
          if(value!=null){
            setToken(context, token: value, result: (v){});
          }
        });
      }catch(e){
        debugPrint("登陆关联推送失败");
      }
      // 登录成功，初始化用户及首页数据，初始化成功再认为是登录成功
      PersonalProfileInfoEntity profileInfo = await getUserDetailData(context, userId: info.id, silence: true);
      await savePersonalProfileInfo(context, info.id, profileInfo);
      AutoRouter.of(context).replaceAll([HomeRoute()]);
    });
  }
}
