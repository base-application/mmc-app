import 'package:auto_route/auto_route.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mmc/router/router.gr.dart';
import 'package:mmc/utils/comfun.dart';
import 'package:mmc/utils/http_request.dart';
import 'package:mmc/widget/app_bar_home.dart';
import 'package:mmc/widget/bottom_button.dart';
import 'package:mmc/widget/country_choose.dart';

class SignUpPage extends StatefulWidget {
  ///1 注册   2 忘记密码
  final int type;
  const SignUpPage({Key? key, required this.type}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _registerPhoneNumberController = TextEditingController();

  String? _registerCountryCode;
  List<CountryCodeInfo> countryCodeDataList = [];
  @override
  void initState() {
    String? cacheCode = SpUtil.getString("phonecode");
    if(cacheCode!=null && cacheCode.isNotEmpty ){
      _registerCountryCode = SpUtil.getString("phonecode");
    }else{
      _registerCountryCode= "60";
    }
    super.initState();
  }

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
              padding: EdgeInsets.only(top: 50,bottom: MediaQuery.of(context).size.height *.2),
              child: Text(widget.type ==1 ? AppLocalizations.of(context)!.loginPageWelcome:AppLocalizations.of(context)!.forgotPasswordAsk.replaceAll("?", ""), style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFFFBB714),), textAlign: TextAlign.start,),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
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
                      countryCodeDataList = list.where((element) => element.phonecode != '' && element.nativeName != '').toList();
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
                const SizedBox(width: 8,),
                Expanded(child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: _registerPhoneNumberController,
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
                ),),
              ],
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
                  if(_registerPhoneNumberController.text.isEmpty){
                    return ComFun.showToast(msg: AppLocalizations.of(context)!.phoneNumberInput);
                  }
                  if(_registerCountryCode==null){
                    return ComFun.showToast(msg: AppLocalizations.of(context)!.chooseCountryCodeTip,);
                  }
                  sendSmsCode(context, phoneNumber: _registerPhoneNumberController.text.trim(),countryCode: _registerCountryCode!.trim() , type: widget.type, result: () {
                    AutoRouter.of(context).push(PhoneNumberVerificationRoute(phoneNumber:_registerPhoneNumberController.text.trim(),countryCode: _registerCountryCode!, type: widget.type));
                  });
                },
              ),
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
}
