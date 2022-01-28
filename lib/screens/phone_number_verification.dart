import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mmc/router/router.gr.dart';
import 'package:mmc/utils/comfun.dart';
import 'package:mmc/utils/http_request.dart';

class PhoneNumberVerificationPage extends StatefulWidget {
  final String phoneNumber;
  final String countryCode;
  final int type;
  const PhoneNumberVerificationPage({Key? key, required this.phoneNumber, required this.countryCode, required this.type}) : super(key: key);

  @override
  _PhoneNumberVerificationPageState createState() => _PhoneNumberVerificationPageState();
}

class _PhoneNumberVerificationPageState extends State<PhoneNumberVerificationPage> {
  final TextEditingController _registerSmsCodeController = TextEditingController();
  final FocusNode _registerSmsCodeFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          physics: const ClampingScrollPhysics(),
          children: [
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
              children: [
                Text(AppLocalizations.of(context)!.tipLoginKeyOTP, style: const TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold,),),
                const SizedBox(height: 8,),
                Text(AppLocalizations.of(context)!.tipLoginKeyOTPDescribe, style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.4), fontWeight: FontWeight.w400,),),
                const SizedBox(height: 40,),
                SizedBox(
                  height: 50,
                  child: Stack(
                    children: [
                      Opacity(
                        opacity: 0,
                        child: TextFormField(
                          controller: _registerSmsCodeController,
                          focusNode: _registerSmsCodeFocusNode,
                          keyboardType: TextInputType.number,
                          maxLength: 6,
                          cursorColor: Colors.blueAccent,
                          autofocus: true,
                          style: const TextStyle(textBaseline: TextBaseline.alphabetic),
                          decoration: const InputDecoration(
                            hintText: '',
                            hintStyle: TextStyle(fontSize: 14, color: Colors.black38),
                            contentPadding: EdgeInsets.only(top: 15, left: 14,),
                            counterText: '',
                            isDense: true,
                            border: InputBorder.none,
                          ),
                          onChanged: (_) {
                            setState(() {});
                          },
                        ),
                      ),
                      IgnorePointer(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [0, 1, 2, 3, 4, 5].map((codeIndex) => Container(
                            width: 50,
                            height: double.infinity,
                            alignment: Alignment.center,
                            child: Text(_registerSmsCodeController.text.trim().length > codeIndex ? _registerSmsCodeController.text.trim().substring(codeIndex, codeIndex + 1) : '', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black87,),),
                            decoration: BoxDecoration(
                              color: _registerSmsCodeController.text.trim().length == codeIndex ? Colors.amber.shade100 : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),).toList(),
                        ),
                      ),
                    ],
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
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(AppLocalizations.of(context)!.hintLoginNextBtn, style: const TextStyle(color: Color(0xFF002A67), fontSize: 17, fontWeight: FontWeight.bold, letterSpacing: 1),),
                        const SizedBox(width: 10,),
                        const Icon(Icons.arrow_forward_rounded, size: 18, color: Color(0xFF002A67),),
                      ],
                    ),
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      if(_registerSmsCodeController.text.length == 6){
                        AutoRouter.of(context).push(ConfirmPasswordRoute(verificationCode: _registerSmsCodeController.text, countryCode: widget.countryCode, phoneNumber: widget.phoneNumber, type: widget.type));
                      }
                    },
                  ),
                ),
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(AppLocalizations.of(context)!.inputRegisterNoReceiveOTP, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white,),),
                        const SizedBox(width: 6,),
                        Text(AppLocalizations.of(context)!.inputRegisterResendOTP, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFFBB714),),),
                      ],
                    ),
                  ),
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    sendSmsCode(context, phoneNumber: widget.phoneNumber,countryCode: widget.countryCode, type:1, result: () {
                      ComFun.showToast(msg: AppLocalizations.of(context)!.inputLoginSmsCodeSendSuccessTip);
                      setState(() {
                        _registerSmsCodeController.clear();
                      });
                      _registerSmsCodeFocusNode.requestFocus();
                    });
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
                Text(AppLocalizations.of(context)!.loginHaveAccountTip, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white,),),
                const SizedBox(width: 6,),
                Text(AppLocalizations.of(context)!.toSignIn, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFFBB714),),),
              ],
            ),
          ),
          behavior: HitTestBehavior.opaque,
          onTap: () {
            AutoRouter.of(context).push(const SignInRoute());
          },
        ),
      ),
    );
  }
}
