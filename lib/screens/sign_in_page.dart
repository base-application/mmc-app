import 'package:auto_route/auto_route.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mmc/bean/login_info_entity.dart';
import 'package:mmc/bean/personal_profile_info_entity.dart';
import 'package:mmc/router/auth_guard.dart';
import 'package:mmc/router/router.gr.dart';
import 'package:mmc/utils/comfun.dart';
import 'package:mmc/utils/http_request.dart';
import 'package:mmc/widget/app_bar_home.dart';
import 'package:mmc/widget/country_choose.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isShowPwd = false; // 是否显示输入的密码
  String? _registerCountryCode;

  @override
  void initState() {
    String? cacheCode = SpUtil.getString("phonecode");
    if(cacheCode!=null && cacheCode.isNotEmpty ){
      _registerCountryCode = SpUtil.getString("phonecode");
    }else{
      _registerCountryCode = "60";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding:  const EdgeInsets.all(16),
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
            if(Navigator.canPop(context)) Align(
              alignment: Alignment.centerLeft,
              child: FloatingActionButton(
                elevation: 0,
                backgroundColor: Colors.white24,
                child: const Icon(CupertinoIcons.left_chevron),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(top: 30),
              child: Text(AppLocalizations.of(context)!.loginPageWelcomeTo, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Color(0xFFFBB714),), textAlign: TextAlign.start,),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(top: 30,bottom: 50),
              child: Text(AppLocalizations.of(context)!.masterMind, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Color(0xFFFBB714),), textAlign: TextAlign.start,),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      child: Container(
                        width: 100,
                        height: 50,
                        padding: const EdgeInsets.only(left: 14, right: 10,),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(_registerCountryCode ?? AppLocalizations.of(context)!.hintLoginCountryCode,
                                style: TextStyle(fontSize: 14, color: _registerCountryCode == null ? Colors.black38 : Colors.black87,),
                                overflow: TextOverflow.ellipsis,),
                            ),
                            const Icon(Icons.arrow_drop_down_rounded, size: 22, color: Colors.black54,),
                          ],
                        ),
                      ),
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        getCountryCodeData(context,silence: false, result: (List<CountryCodeInfo> list) {
                          List<CountryCodeInfo> countryCodeDataList = list.where((element) => element.phonecode != '' && element.nativeName != '').toList();
                          showModalBottomSheet<CountryCodeInfo?>(
                              context: context,
                              isScrollControlled: true,
                              constraints: BoxConstraints(
                                maxHeight: MediaQuery.of(context).size.height * .8,
                                minHeight: MediaQuery.of(context).size.height * .4,
                              ),
                              builder: (BuildContext context) {
                                return CountryChoose(curLocalData: countryCodeDataList,);
                              }).then((country) {
                            if(country!=null){
                              _registerCountryCode = country.phonecode;
                              SpUtil.putString("phonecode", country.phonecode);
                              setState(() {});
                            }
                          });
                        });
                      },
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      child: Container(
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
                    )
                    ),
                  ],
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
          ],
        ),
        bottomNavigationBar:  GestureDetector(
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
      if(ComFun.isPerfect(context)){
        AutoRouter.of(context).replaceAll([ const HomeRoute(), const PersonalProfileSetRoute()]);
      }else{
        AutoRouter.of(context).replaceAll([ const HomeRoute()]);
      }

    },err: (){
      savePersonalProfileInfo(context, context.read<AuthService>().getLoginInfo!.id, null);
      saveLoginInfo(context, null);
    });
  }
}
