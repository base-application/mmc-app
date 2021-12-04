import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/style/picker_style.dart';
import 'package:mmc/bean/home_index_info_entity.dart';
import 'package:mmc/bean/login_info_entity.dart';
import 'package:mmc/bean/personal_profile_info_entity.dart';
import 'package:mmc/router/auth_guard.dart';
import 'package:mmc/utils/comfun.dart';
import 'package:mmc/utils/http.dart';
import 'package:mmc/utils/http_request.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mmc/utils/project_init.dart';
import 'package:provider/src/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, this.onLoginSuccess}) : super(key: key);

  final void Function(BuildContext context)? onLoginSuccess;

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  String? _pageType; // 页面显示状态 初进入、登录、注册、忘记密码
  int _signUpStep = 0; // 注册进度
  bool _isShowPwd = false; // 是否显示输入的密码
  bool _isShowPwdForRegister = false; // 是否显示注册或忘记密码时输入的密码
  bool _isShowPwdForRegisterAgain = false; // 是否显示注册或忘记密码时确认输入的密码

  List<CountryCodeInfo> countryCodeDataList = [];

  String? _countryCode;
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _registerCountryCode;
  final TextEditingController _registerPhoneNumberController = TextEditingController();
  final TextEditingController _registerSmsCodeController = TextEditingController();
  final TextEditingController _registerPasswordController = TextEditingController();
  final TextEditingController _registerPasswordAgainController = TextEditingController();

  final FocusNode _registerSmsCodeFocusNode = FocusNode();

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
        print(e);
      }

      // 登录成功，初始化用户及首页数据，初始化成功再认为是登录成功
      getUserDetailData(context, userId: info.id, silence: true, result: (PersonalProfileInfoEntity profileInfo) async {
        await savePersonalProfileInfo(context, info.id, profileInfo);
        getIndexData(context, silence: true, result: (HomeIndexInfoEntity info) async {
          context.read<HomeIndexDataService>().setHomeIndexInfo(info);
          dismissLoading();
          ComFun.showToast(msg: AppLocalizations.of(context)!.loginSuccessTip);
          widget.onLoginSuccess?.call(context);
        }, err: () {
          savePersonalProfileInfo(context, info.id, null);
          saveLoginInfo(context, null);
        });
      }, err: () {
        savePersonalProfileInfo(context, info.id, null);
        saveLoginInfo(context, null);
      });
    });
  }

  /// 确认执行修改密码或执行注册
  _signUpOrForgotConfirm() {
    if (_pageType == 'up') {
      register(context, countryCode: _registerCountryCode!, phoneNumber: _registerPhoneNumberController.text.trim(), verificationCode: _registerSmsCodeController.text.trim(), password: _registerPasswordController.text.trim(), result: () {
        ComFun.showToast(msg: AppLocalizations.of(context)!.registerSuccessTip);
        _countryCode = _registerCountryCode;
        _phoneNumberController.text = _registerPhoneNumberController.text.trim();
        _passwordController.clear();

        _registerPhoneNumberController.clear();
        _registerSmsCodeController.clear();
        _registerPasswordController.clear();
        _registerPasswordAgainController.clear();
        setState(() {
          _signUpStep = 0;
          _pageType = 'in';
        });
      });
    } else {
      forgotPassword(context, phoneNumber: _registerPhoneNumberController.text.trim(), verificationCode: _registerSmsCodeController.text.trim(), password: _registerPasswordController.text.trim(), result: () {
        ComFun.showToast(msg: AppLocalizations.of(context)!.passwordResetSuccessTip);
        _countryCode = _registerCountryCode;
        _phoneNumberController.text = _registerPhoneNumberController.text.trim();
        _passwordController.clear();

        _registerPhoneNumberController.clear();
        _registerSmsCodeController.clear();
        _registerPasswordController.clear();
        _registerPasswordAgainController.clear();
        setState(() {
          _signUpStep = 0;
          _pageType = 'in';
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadCountryCodeData();
  }

  @override
  Widget build(BuildContext context) {
    Widget _logoTxt() {
      if (_pageType == null) {
        return Positioned(
          child: Text(AppLocalizations.of(context)!.loginPageWelcome, style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.white,), textAlign: TextAlign.center,),
          top: 140,
        );
      }
      return Positioned(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Text(AppLocalizations.of(context)!.loginPageWelcome, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFFFBB714),), textAlign: TextAlign.start,),
        ),
        top: 140,
      );
    }

    return GestureDetector(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF043D98),
              Color(0xFF0859D2),
            ],
          ),
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              child: Image.asset('assets/image/login_e2.png', width: MediaQuery.of(context).size.width * 0.9, height: MediaQuery.of(context).size.width * 0.5, fit: BoxFit.fill,),
              top: 50,
            ),
            Positioned(
              child: Image.asset('assets/image/login_e1.png', width: MediaQuery.of(context).size.width * 0.3, height: MediaQuery.of(context).size.width * 0.84, fit: BoxFit.fill,),
              top: 160,
              left: 0,
            ),
            Positioned(
              child: Image.asset('assets/image/login_c.png', width: MediaQuery.of(context).size.width * 0.3, height: MediaQuery.of(context).size.width * 0.84, fit: BoxFit.fill,),
              top: 160,
              right: 0,
            ),
            _logoTxt(),
            if (_pageType == null) Positioned(
              child: Image.asset('assets/image/logo.png', width: MediaQuery.of(context).size.width * 0.36, height: MediaQuery.of(context).size.width * 0.36,),
              top: 266,
            ),
            if (_pageType == null) Positioned(
              child: SizedBox(
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
                    _phoneNumberController.clear();
                    _passwordController.clear();

                    _registerPhoneNumberController.clear();
                    _registerSmsCodeController.clear();
                    _registerPasswordController.clear();
                    _registerPasswordAgainController.clear();
                    setState(() {
                      _signUpStep = 0;
                      _pageType = 'in';
                    });
                  },
                ),
              ),
              bottom: 230,
            ),
            if (_pageType == null) Positioned(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(const Color(0xFF657C7F)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    elevation: MaterialStateProperty.all(1),
                  ),
                  child: Text(AppLocalizations.of(context)!.signUp, style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold, letterSpacing: 1),),
                  onPressed: () {
                    _phoneNumberController.clear();
                    _passwordController.clear();

                    _registerPhoneNumberController.clear();
                    _registerSmsCodeController.clear();
                    _registerPasswordController.clear();
                    _registerPasswordAgainController.clear();
                    setState(() {
                      _signUpStep = 0;
                      _pageType = 'up';
                    });
                  },
                ),
              ),
              bottom: 160,
            ),
            if (_pageType == 'in') Positioned(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.84,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(child: Container(
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
                        ),),
                      ],
                    ),
                    const SizedBox(height: 22,),
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
                    const SizedBox(height: 60,),
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
                    const SizedBox(height: 16,),
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(AppLocalizations.of(context)!.forgotPasswordAsk, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFFBB714),),),
                      ),
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        setState(() {
                          _signUpStep = 0;
                          _pageType = 'forgot';
                        });
                      },
                    ),
                  ],
                ),
              ),
              top: 250,
            ),
            if (_pageType == 'forgot' || _pageType == 'up') Positioned(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.84,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_signUpStep == 0) Row(
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
                            if (_registerCountryCode == null && countryCodeDataList.isNotEmpty) {
                              setState(() {
                                _registerCountryCode = countryCodeDataList[0].phonecode;
                              });
                            }
                            List<CountryCodeInfo> curr = countryCodeDataList.where((element) => element.phonecode == _registerCountryCode).toList();
                            Pickers.showSinglePicker(context,
                              data: countryCodeDataList.map((e) => '${e.phonecode} (${e.nativeName})').toList(),
                              selectData: _registerCountryCode != null && curr.isNotEmpty ? '${curr[0].phonecode} (${curr[0].nativeName})' : '',
                              pickerStyle: PickerStyle(
                                showTitleBar: false,
                                backgroundColor: const Color(0xFF0859D2),
                                textColor: Colors.white,
                                pickerHeight: MediaQuery.of(context).size.height * 0.6,
                                menuHeight: MediaQuery.of(context).size.height * 0.6,
                              ),
                              overlapTabBar: true,
                              onChanged: (p, index) {
                                setState(() {
                                  _registerCountryCode = countryCodeDataList[index].phonecode;
                                });
                              },
                            );
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
                    if (_signUpStep == 1 || _signUpStep == 2) const SizedBox(height: 10,),
                    if (_signUpStep == 1) Column(
                      mainAxisSize: MainAxisSize.min,
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
                      ],
                    ),
                    if (_signUpStep == 2) Column(
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
                            keyboardType: TextInputType.number,
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
                            keyboardType: TextInputType.number,
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
                      ],
                    ),
                    const SizedBox(height: 60,),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 50,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(const Color(0xFFFBB714)),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                          elevation: MaterialStateProperty.all(1),
                        ),
                        child: _signUpStep == 2 ? Text(AppLocalizations.of(context)!.hintLoginConfirmBtn, style: const TextStyle(color: Color(0xFF002A67), fontSize: 17, fontWeight: FontWeight.bold, letterSpacing: 1),) : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(AppLocalizations.of(context)!.hintLoginNextBtn, style: const TextStyle(color: Color(0xFF002A67), fontSize: 17, fontWeight: FontWeight.bold, letterSpacing: 1),),
                            const SizedBox(width: 10,),
                            const Icon(Icons.arrow_forward_rounded, size: 18, color: Color(0xFF002A67),),
                          ],
                        ),
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          if (_signUpStep < 2) {
                            bool _canToNext = true;
                            if (_signUpStep == 0) {
                              // 输入手机号码
                              if (_registerCountryCode == null || _registerCountryCode!.trim() == '') {
                                ComFun.showToast(msg: AppLocalizations.of(context)!.chooseCountryCodeTip, err: true,);
                                _canToNext = false;
                              } else if (_registerPhoneNumberController.text.trim() == '') {
                                ComFun.showToast(msg: AppLocalizations.of(context)!.inputLoginAccountTip, err: true,);
                                _canToNext = false;
                              }
                            } else if (_signUpStep == 1) {
                              // 输入短信验证码
                              if (_registerSmsCodeController.text.trim() == '') {
                                ComFun.showToast(msg: AppLocalizations.of(context)!.inputLoginSmsCodeTip, err: true,);
                                _canToNext = false;
                              } else if (_registerSmsCodeController.text.trim().length < 6) {
                                ComFun.showToast(msg: AppLocalizations.of(context)!.inputLoginSmsCodeErrTip, err: true,);
                                _canToNext = false;
                              }
                            }
                            if (_canToNext) {
                              if (_signUpStep == 0) {
                                sendSmsCode(context, phoneNumber: _registerPhoneNumberController.text.trim(),countryCode: _registerCountryCode!.trim() , type: _pageType == 'up' ? 1 : 2, result: () {
                                  ComFun.showToast(msg: AppLocalizations.of(context)!.inputLoginSmsCodeSendSuccessTip);
                                  setState(() {
                                    _signUpStep += 1;
                                  });
                                  _registerSmsCodeFocusNode.requestFocus();
                                });
                              } else {
                                setState(() {
                                  _signUpStep += 1;
                                });
                              }
                            }
                          } else {
                            if (_registerPasswordController.text.trim() == '') {
                              ComFun.showToast(msg: AppLocalizations.of(context)!.inputRegisterPasswordTip, err: true,);
                            } else if (_registerPasswordAgainController.text.trim() == '') {
                              ComFun.showToast(msg: AppLocalizations.of(context)!.inputRegisterPasswordAgainTip, err: true,);
                            } else if (_registerPasswordController.text.trim() != _registerPasswordAgainController.text.trim()) {
                              ComFun.showToast(msg: AppLocalizations.of(context)!.inputRegisterPasswordUnlikeTip, err: true,);
                            } else {
                              _signUpOrForgotConfirm();
                            }
                          }
                        },
                      ),
                    ),
                    if (_signUpStep == 1) const SizedBox(height: 16,),
                    if (_signUpStep == 1) GestureDetector(
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
                        sendSmsCode(context, phoneNumber: _registerPhoneNumberController.text.trim(),countryCode: _registerCountryCode!, type: _pageType == 'up' ? 1 : 2, result: () {
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
              ),
              top: 250,
            ),
            if (_pageType == null) Positioned(
              child: Text(AppLocalizations.of(context)!.inputLoginSurfAsAGuestTip, style: const TextStyle(fontSize: 13, color: Colors.white,),),
              bottom: 120,
            ),
            if (_pageType == 'in') Positioned(
              child: GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Text(AppLocalizations.of(context)!.loginNoAccountTip, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white,),),
                      const SizedBox(width: 6,),
                      Text(AppLocalizations.of(context)!.toSignUp, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFFBB714),),),
                    ],
                  ),
                ),
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  _phoneNumberController.clear();
                  _passwordController.clear();

                  _registerPhoneNumberController.clear();
                  _registerSmsCodeController.clear();
                  _registerPasswordController.clear();
                  _registerPasswordAgainController.clear();
                  setState(() {
                    _signUpStep = 0;
                    _pageType = 'up';
                  });
                },
              ),
              bottom: 80,
            ),
            if (_pageType == 'up') Positioned(
              child: GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Text(AppLocalizations.of(context)!.loginHaveAccountTip, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white,),),
                      const SizedBox(width: 6,),
                      Text(AppLocalizations.of(context)!.toSignIn, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFFBB714),),),
                    ],
                  ),
                ),
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  // _countryCode = _registerCountryCode;
                  // _phoneNumberController.text = '';
                  _passwordController.clear();

                  _registerPhoneNumberController.clear();
                  _registerSmsCodeController.clear();
                  _registerPasswordController.clear();
                  _registerPasswordAgainController.clear();
                  setState(() {
                    _signUpStep = 0;
                    _pageType = 'in';
                  });
                },
              ),
              bottom: 80,
            ),
            Positioned(
              child: IgnorePointer(
                ignoring: _pageType != 'forgot',
                child: GestureDetector(
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: _pageType == 'forgot' ? 1 : 0,
                    child: Container(
                      width: 50,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.black87.withAlpha(100),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(Icons.clear, size: 24, color: Colors.white.withAlpha(100),),
                    ),
                  ),
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    _passwordController.clear();
                    // _countryCode = '';
                    // _phoneNumberController.text = '';
                    setState(() {
                      _signUpStep = 0;
                      _pageType = null;
                    });
                  },
                ),
              ),
              top: 50,
              left: 30,
            ),
          ],
        ),
      ),
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
    );
  }

  /// 加载本地国家城市区号
  _loadCountryCodeData() async {
    getCountryCodeData(context, result: (List<CountryCodeInfo> list) {
      countryCodeDataList = list.where((element) => element.phonecode != '' && element.nativeName != '').toList();

      List<CountryCodeInfo> curLocalData = countryCodeDataList.where((element) => element.timezones != null && element.timezones!.where((element) => element.abbreviation == DateTime.now().timeZoneName).isNotEmpty).toList();
      // if (curLocalData.isNotEmpty) countryCodeDataList = curLocalData;
      setState(() {
        _countryCode = curLocalData.isNotEmpty ? curLocalData.first.phonecode : null;
        _registerCountryCode = curLocalData.isNotEmpty ? curLocalData.first.phonecode : null;
      });
    }, err: () async {
      String data = await DefaultAssetBundle.of(context).loadString('assets/json/countries.json');
      List<dynamic> list = json.decode(data)['data'];
      List<CountryCodeInfo> dataList = list.map((e) => CountryCodeInfo.fromJson(e)).where((element) => element.phonecode != '' && element.nativeName != '').toList();
      countryCodeDataList = dataList;

      List<CountryCodeInfo> curLocalData = countryCodeDataList.where((element) => element.timezones != null && element.timezones!.where((element) => element.abbreviation == DateTime.now().timeZoneName).isNotEmpty).toList();
      // if (curLocalData.isNotEmpty) countryCodeDataList = curLocalData;
      setState(() {
        _countryCode = curLocalData.isNotEmpty ? curLocalData.first.phonecode : null;
        _registerCountryCode = curLocalData.isNotEmpty ? curLocalData.first.phonecode : null;
      });
    });
  }
}

class CountryCodeInfo {
  final int id;
  final String iso2;
  final String phonecode;
  final String nativeName;
  final List<CountryCodeTimezonesInfo>? timezones;

  CountryCodeInfo.fromJson(Map<String, dynamic> result):
        id = result.containsKey('id') && result['id'] != null ? result['id'] : 0,
        iso2 = result.containsKey('iso2') && result['iso2'] != null ? result['iso2'] : '',
        phonecode = result.containsKey('phonecode') && result['phonecode'] != null ? result['phonecode'] : '',
        nativeName = result.containsKey('nativeName') && result['nativeName'] != null ? result['nativeName'] : '',
        timezones = result.containsKey('nativeName') ? (json.decode(result['timezones']) as List).map((v) => CountryCodeTimezonesInfo.fromJson(v)).toList() : [];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['iso2'] = iso2;
    data['phonecode'] = phonecode;
    data['nativeName'] = nativeName;
    data['timezones'] = timezones;
    return data;
  }
}

class CountryCodeTimezonesInfo {
  final String zoneName;
  final String abbreviation;

  CountryCodeTimezonesInfo.fromJson(Map<String, dynamic> result):
        zoneName = result.containsKey('zoneName') && result['zoneName'] != null ? result['zoneName'] : '',
        abbreviation = result.containsKey('abbreviation') && result['abbreviation'] != null ? result['abbreviation'] : '';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['zoneName'] = zoneName;
    data['abbreviation'] = abbreviation;
    return data;
  }
}
