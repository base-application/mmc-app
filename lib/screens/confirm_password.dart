import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mmc/router/router.gr.dart';
import 'package:mmc/utils/comfun.dart';
import 'package:mmc/utils/http_request.dart';

class ConfirmPasswordPage extends StatefulWidget {
  final String phoneNumber;
  final String countryCode;
  final String verificationCode;
  final int type;
  const ConfirmPasswordPage({Key? key, required this.phoneNumber, required this.countryCode, required this.verificationCode, required this.type}) : super(key: key);

  @override
  _ConfirmPasswordPageState createState() => _ConfirmPasswordPageState();
}

class _ConfirmPasswordPageState extends State<ConfirmPasswordPage> {
  final TextEditingController _registerPasswordController = TextEditingController();
  bool _isShowPwdForRegister = false; // 是否显示注册或忘记密码时输入的密码
  final TextEditingController _registerPasswordAgainController = TextEditingController();
  bool _isShowPwdForRegisterAgain = false; // 是否显示注册或忘记密码时确认输入的密码




  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
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
          physics: ClampingScrollPhysics(),
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(top: 50,bottom: 30),
              child: Text(widget.type == 1 ? AppLocalizations.of(context)!.loginPageWelcome : AppLocalizations.of(context)!.forgotPasswordAsk.replaceAll("?", ""), style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFFFBB714),), textAlign: TextAlign.start,),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(AppLocalizations.of(context)!.tipLoginKeyPassword, style: const TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold,),),
                const SizedBox(height: 8,),
                Text(AppLocalizations.of(context)!.tipLoginKeyPasswordDescribe, style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.4), fontWeight: FontWeight.w400,),),
                const SizedBox(height: 40,),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: _registerPasswordController,
                    keyboardType: TextInputType.text,
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
                          child: Image.asset(_isShowPwdForRegister ? 'assets/icon/login_password_eye_open.png' : 'assets/icon/login_password_eye_close.png', width: 16, height: 16,),
                        ),
                        onPressed: () {
                          setState(() {
                            _isShowPwdForRegister = !_isShowPwdForRegister;
                          });
                        },
                      ),
                    ),
                    obscureText: !_isShowPwdForRegister,
                  ),
                ),
                const SizedBox(height: 22,),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: _registerPasswordAgainController,
                    keyboardType: TextInputType.text,
                    maxLength: 20,
                    cursorColor: Colors.blueAccent,
                    style: const TextStyle(textBaseline: TextBaseline.alphabetic),
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.hintLoginConfirmPassword,
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
                          child: Image.asset(_isShowPwdForRegisterAgain ? 'assets/icon/login_password_eye_open.png' : 'assets/icon/login_password_eye_close.png', width: 16, height: 16,),
                        ),
                        onPressed: () {
                          setState(() {
                            _isShowPwdForRegisterAgain = !_isShowPwdForRegisterAgain;
                          });
                        },
                      ),
                    ),
                    obscureText: !_isShowPwdForRegisterAgain,
                  ),
                ),
                const SizedBox(height: 16,),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(const Color(0xFFFBB714)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                      elevation: MaterialStateProperty.all(1),
                    ),
                    child: Text(AppLocalizations.of(context)!.hintLoginConfirmBtn, style: const TextStyle(color: Color(0xFF002A67), fontSize: 17, fontWeight: FontWeight.bold, letterSpacing: 1),),
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      _signUpOrForgotConfirm();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        bottomNavigationBar: GestureDetector(
          child: Padding(
            padding: EdgeInsets.only(left: 16,right: 16,bottom: MediaQuery.of(context).padding.bottom),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(AppLocalizations.of(context)!.loginHaveAccountTip, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white,),),
                const SizedBox(width: 6,),
                Text(AppLocalizations.of(context)!.toSignIn, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFFBB714),),),
              ],
            ),
          ),
          behavior: HitTestBehavior.opaque,
          onTap: () {
            AutoRouter.of(context).push(SignInRoute());
          },
        ),
      ),
    );
  }
  _signUpOrForgotConfirm(){
    if(widget.type == 1){
      register(context, countryCode: widget.countryCode, phoneNumber: widget.phoneNumber, verificationCode: widget.verificationCode, password: _registerPasswordController.text.trim(), result: () {
        ComFun.showToast(msg: AppLocalizations.of(context)!.registerSuccessTip);
        AutoRouter.of(context).replaceAll([SignInRoute()]);
      });
    }
    if(widget.type == 2){

      forgotPassword(context, phoneNumber: widget.phoneNumber,  verificationCode: widget.verificationCode, password: _registerPasswordController.text.trim(), result: () {
        ComFun.showToast(msg: AppLocalizations.of(context)!.passwordResetSuccessTip);
        AutoRouter.of(context).replaceAll([SignInRoute()]);
      });
    }
  }
}
