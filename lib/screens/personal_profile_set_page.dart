import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/style/picker_style.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';
import 'package:flutter_pickers/time_picker/model/pduration.dart';
import 'package:mmc/bean/personal_profile_info_entity.dart';
import 'package:mmc/bean/state_item_info_entity.dart';
import 'package:mmc/router/auth_guard.dart';
import 'package:mmc/screens/state_choose.dart';
import 'package:mmc/utils/comfun.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mmc/utils/comm_widget.dart';
import 'package:mmc/utils/http.dart';
import 'package:mmc/utils/http_request.dart';
import 'package:mmc/widget/app_bar_home.dart';
import 'package:mmc/widget/country_choose.dart';
import 'package:mmc/widget/input_select.dart';
import 'dart:developer' as developer;

import 'package:provider/provider.dart';

class PersonalProfileSetPage extends StatefulWidget {
  const PersonalProfileSetPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PersonalProfileSetPageState();
  }
}

class _PersonalProfileSetPageState extends State<PersonalProfileSetPage> {
  String? _formUserHead;
  final TextEditingController _yourNameController = TextEditingController();
  String? _formDateOfBirth;
  CountryCodeInfo? _formCountry;
  StateItemInfoEntity? _formState;
  String? _formIndustry;
  String? _formOccupation;
  final TextEditingController _selfIntroductionController = TextEditingController();
  final TextEditingController _yourPhoneNumberController = TextEditingController();
  final TextEditingController _yourWhatsAppController = TextEditingController();
  final TextEditingController _yourFacebookController = TextEditingController();
  final TextEditingController _yourLinkedInController = TextEditingController();
  final TextEditingController _yourYoutubeChannelController = TextEditingController();
  final TextEditingController _yourInstagramController = TextEditingController();

  List<StateItemInfoEntity> _aboutState = []; // 所选国家相关城市

  bool edit = false;

  @override
  void initState() {
    super.initState();
    _initFormData();
  }

  @override
  Widget build(BuildContext context) {
    Widget _scroll() {
      return SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 10, left: 26, right: 26, bottom: 30,),
          child: Column(
            children: [
              GestureDetector(
                child: Container(
                  padding: const EdgeInsets.only(top: 12, bottom: 12, left: 16, right: 16,),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 0.6, color: Colors.grey.shade300,)
                  ),
                  child: Row(
                    children: [
                      netImgWrap(context,
                        width: 120,
                        height: 162,
                        radius: 14,
                        url: _formUserHead ?? context.watch<AuthService>().getLoginInfo?.avatar,
                        errorWidget: Image.asset('assets/image/personal_head_empty.png', width: 100, fit: BoxFit.cover,),
                      ),
                      const SizedBox(width: 12,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('* Your Profile Picture', style: TextStyle(fontSize: 13, color: Colors.black.withOpacity(0.6),),),
                          const SizedBox(height: 6,),
                          Text('Suggestion size: 120*162', style: TextStyle(fontSize: 13, color: Colors.black.withOpacity(0.6),),),
                        ],
                      ),
                    ],
                  ),
                ),
                behavior: HitTestBehavior.opaque,
                onTap: () async {
                  String uploadPath = await httpUpload(context,x: 3,y: 4);
                  if(uploadPath.isNotEmpty){
                    _formUserHead = uploadPath;
                  }
                  setState(() {});
                },
              ),
              const SizedBox(height: 30,),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/icon/form_required.png', width: 8, height: 8,),
                          const SizedBox(width: 6,),
                          Text(AppLocalizations.of(context)!.personalProfileFormYourName, style: TextStyle(fontSize: 15, color: Colors.black87.withAlpha(220),),),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      Container(
                        width: double.infinity,
                        height: 44,
                        padding: const EdgeInsets.only(left: 10, right: 10,),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 0.6, color: Colors.grey.shade300,)
                        ),
                        child: TextFormField(
                          controller: _yourNameController,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.blueAccent,
                          style: const TextStyle(textBaseline: TextBaseline.alphabetic),
                          readOnly: !edit,
                          decoration: InputDecoration(
                            hintText: getHit(AppLocalizations.of(context)!.personalProfileFormYourNameHint),
                            hintStyle: const TextStyle(fontSize: 14, color: Colors.black38),
                            contentPadding: const EdgeInsets.only(top: 12,),
                            counterText: '',
                            isDense: true,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // Image.asset('assets/icon/form_required.png', width: 8, height: 8,),
                          // const SizedBox(width: 6,),
                          Text(AppLocalizations.of(context)!.personalProfileFormDateOfBirth, style: TextStyle(fontSize: 15, color: Colors.black87.withAlpha(220),),),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      GestureDetector(
                        child: Container(
                          width: double.infinity,
                          height: 44,
                          padding: const EdgeInsets.only(left: 14, right: 10,),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 0.6, color: Colors.grey.shade300,)
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(_formDateOfBirth ?? getHit(AppLocalizations.of(context)!.personalProfileFormDateOfBirthHint), style: TextStyle(fontSize: 14, color: _formDateOfBirth == null ? Colors.black38 : Colors.black87,), overflow: TextOverflow.ellipsis,),
                              ),
                              if(edit) const Icon(Icons.arrow_drop_down_rounded, size: 22, color: Colors.black54,),
                            ],
                          ),
                        ),
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          if(!edit) return;
                          FocusScope.of(context).requestFocus(FocusNode());
                          Pickers.showDatePicker(context,
                            mode: DateMode.YMD,
                            maxDate: PDuration.now(),
                            pickerStyle: PickerStyle(
                              showTitleBar: false,
                              backgroundColor: Colors.white,
                              textColor: Colors.black87,
                              pickerHeight: MediaQuery.of(context).size.height * 0.4,
                              menuHeight: MediaQuery.of(context).size.height * 0.4,
                            ),
                            onChanged: (res) {
                              setState(() {
                                _formDateOfBirth = DateUtil.formatDate(DateTime.utc(res.year!, res.month!, res.day!), format: 'yyyy-MM-dd');
                              });
                            },
                          );
                        },
                      ),
                    ],
                  ),),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/icon/form_required.png', width: 8, height: 8,),
                          const SizedBox(width: 6,),
                          Text(AppLocalizations.of(context)!.personalProfileFormCountry, style: TextStyle(fontSize: 15, color: Colors.black87.withAlpha(220),),),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      GestureDetector(
                        child: Container(
                          width: double.infinity,
                          height: 44,
                          padding: const EdgeInsets.only(left: 14, right: 10,),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 0.6, color: Colors.grey.shade300,)
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(getName() ?? getHit(AppLocalizations.of(context)!.personalProfileFormCountryHint), style: TextStyle(fontSize: 14, color: _formCountry == null ? Colors.black38 : Colors.black87,), overflow: TextOverflow.ellipsis,),
                              ),
                              if(edit)const Icon(Icons.arrow_drop_down_rounded, size: 22, color: Colors.black54,),
                            ],
                          ),
                        ),
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          if(!edit) return ;
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
                                _formCountry = country;
                                _formState = null;
                                _getStateData();
                                setState(() {});
                              }
                            });
                          });
                        },
                      ),
                    ],
                  ),),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/icon/form_required.png', width: 8, height: 8,),
                          const SizedBox(width: 6,),
                          Text(AppLocalizations.of(context)!.personalProfileFormState, style: TextStyle(fontSize: 15, color: Colors.black87.withAlpha(220),),),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      GestureDetector(
                        child: Container(
                          width: double.infinity,
                          height: 44,
                          padding: const EdgeInsets.only(left: 14, right: 10,),
                          decoration: BoxDecoration(
                              color: _formCountry != null && _aboutState.isNotEmpty ? Colors.white : Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 0.6, color: Colors.grey.shade300,)
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(_formState?.name ?? getHit(AppLocalizations.of(context)!.personalProfileFormStateHint), style: TextStyle(fontSize: 14, color: _formState == null ? Colors.black38 : Colors.black87,), overflow: TextOverflow.ellipsis,),
                              ),
                              if(edit)const Icon(Icons.arrow_drop_down_rounded, size: 22, color: Colors.black54,),
                            ],
                          ),
                        ),
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          if(!edit) return;
                          FocusScope.of(context).requestFocus(FocusNode());
                          if (_formCountry != null && _aboutState.isNotEmpty) {
                            _chooseState();
                          }
                        },
                      ),
                    ],
                  ),),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // Image.asset('assets/icon/form_required.png', width: 8, height: 8,),
                          // const SizedBox(width: 6,),
                          Text(AppLocalizations.of(context)!.personalProfileFormIndustry, style: TextStyle(fontSize: 15, color: Colors.black87.withAlpha(220),),),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      GestureDetector(
                        child: Container(
                          width: double.infinity,
                          height: 44,
                          padding: const EdgeInsets.only(left: 14, right: 10,),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 0.6, color: Colors.grey.shade300,)
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(_formIndustry ?? getHit(AppLocalizations.of(context)!.personalProfileFormIndustryHint), style: TextStyle(fontSize: 14, color: _formIndustry == null ? Colors.black38 : Colors.black87,), overflow: TextOverflow.ellipsis,),
                              ),
                              if(edit) const Icon(Icons.arrow_drop_down_rounded, size: 22, color: Colors.black54,),
                            ],
                          ),
                        ),
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          if(!edit) return;
                          FocusScope.of(context).requestFocus(FocusNode());
                          _chooseIndustry();
                        },
                      ),
                    ],
                  ),),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/icon/form_required.png', width: 8, height: 8,),
                          const SizedBox(width: 6,),
                          Text(AppLocalizations.of(context)!.personalProfileFormYourOccupation, style: TextStyle(fontSize: 15, color: Colors.black87.withAlpha(220),),),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      GestureDetector(
                        child: Container(
                          width: double.infinity,
                          height: 44,
                          padding: const EdgeInsets.only(left: 14, right: 10,),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 0.6, color: Colors.grey.shade300,)
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(_formOccupation ?? getHit(AppLocalizations.of(context)!.personalProfileFormYourOccupationHint), style: TextStyle(fontSize: 14, color: _formOccupation == null ? Colors.black38 : Colors.black87,), overflow: TextOverflow.ellipsis,),
                              ),
                              if(edit) const Icon(Icons.arrow_drop_down_rounded, size: 22, color: Colors.black54,),
                            ],
                          ),
                        ),
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          if(!edit) return;
                          FocusScope.of(context).requestFocus(FocusNode());
                          _chooseOccupation();
                        },
                      ),
                    ],
                  ),),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppLocalizations.of(context)!.personalProfileFormSelfIntroduction, style: TextStyle(fontSize: 15, color: Colors.black87.withAlpha(220),),),
                      const SizedBox(height: 8,),
                      Container(
                        width: double.infinity,
                        height: 110,
                        padding: const EdgeInsets.only(left: 10, right: 10,),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 0.6, color: Colors.grey.shade300,)
                        ),
                        child: TextFormField(
                          controller: _selfIntroductionController,
                          keyboardType: TextInputType.text,
                          maxLength: 100,
                          maxLines: 4,
                          readOnly: !edit,
                          cursorColor: Colors.blueAccent,
                          style: const TextStyle(textBaseline: TextBaseline.alphabetic),
                          decoration: InputDecoration(
                            hintText: getHit(AppLocalizations.of(context)!.personalProfileFormSelfIntroductionHint),
                            hintStyle: const TextStyle(fontSize: 14, color: Colors.black38),
                            contentPadding: const EdgeInsets.only(top: 10,),
                            counterText: '',
                            isDense: true,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/icon/form_required.png', width: 8, height: 8,),
                          const SizedBox(width: 6,),
                          Text(AppLocalizations.of(context)!.personalProfileFormYourPhoneNumber, style: TextStyle(fontSize: 15, color: Colors.black87.withAlpha(220),),),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      Container(
                        width: double.infinity,
                        height: 44,
                        padding: const EdgeInsets.only(left: 10, right: 10,),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 0.6, color: Colors.grey.shade300,)
                        ),
                        child: TextFormField(
                          controller: _yourPhoneNumberController,
                          keyboardType: TextInputType.phone,
                          cursorColor: Colors.blueAccent,
                          readOnly: !edit,
                          style: const TextStyle(textBaseline: TextBaseline.alphabetic),
                          decoration: InputDecoration(
                            hintText: getHit(AppLocalizations.of(context)!.personalProfileFormYourPhoneNumberHint),
                            hintStyle: const TextStyle(fontSize: 14, color: Colors.black38),
                            contentPadding: const EdgeInsets.only(top: 12,),
                            counterText: '',
                            isDense: true,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // Image.asset('assets/icon/form_required.png', width: 8, height: 8,),
                          // const SizedBox(width: 6,),
                          Text(AppLocalizations.of(context)!.personalProfileFormYourWhatsapp, style: TextStyle(fontSize: 15, color: Colors.black87.withAlpha(220),),),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      Container(
                        width: double.infinity,
                        height: 44,
                        padding: const EdgeInsets.only(left: 10, right: 10,),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 0.6, color: Colors.grey.shade300,)
                        ),
                        child: TextFormField(
                          controller: _yourWhatsAppController,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.blueAccent,
                          readOnly: !edit,
                          style: const TextStyle(textBaseline: TextBaseline.alphabetic),
                          decoration: InputDecoration(
                            hintText: getHit(AppLocalizations.of(context)!.personalProfileFormYourWhatsappHint),
                            hintStyle: const TextStyle(fontSize: 14, color: Colors.black38),
                            contentPadding: const EdgeInsets.only(top: 12,),
                            counterText: '',
                            isDense: true,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // Image.asset('assets/icon/form_required.png', width: 8, height: 8,),
                          // const SizedBox(width: 6,),
                          Text(AppLocalizations.of(context)!.personalProfileFormYourFacebook, style: TextStyle(fontSize: 15, color: Colors.black87.withAlpha(220),),),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      Container(
                        width: double.infinity,
                        height: 44,
                        padding: const EdgeInsets.only(left: 10, right: 10,),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 0.6, color: Colors.grey.shade300,)
                        ),
                        child: TextFormField(
                          controller: _yourFacebookController,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.blueAccent,
                          readOnly: !edit,
                          style: const TextStyle(textBaseline: TextBaseline.alphabetic),
                          decoration: InputDecoration(
                            hintText: getHit(AppLocalizations.of(context)!.personalProfileFormYourFacebookHint),
                            hintStyle: const TextStyle(fontSize: 14, color: Colors.black38),
                            contentPadding: const EdgeInsets.only(top: 12,),
                            counterText: '',
                            isDense: true,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // Image.asset('assets/icon/form_required.png', width: 8, height: 8,),
                          // const SizedBox(width: 6,),
                          Text(AppLocalizations.of(context)!.personalProfileFormYourLinkedIn, style: TextStyle(fontSize: 15, color: Colors.black87.withAlpha(220),),),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      Container(
                        width: double.infinity,
                        height: 44,
                        padding: const EdgeInsets.only(left: 10, right: 10,),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 0.6, color: Colors.grey.shade300,)
                        ),
                        child: TextFormField(
                          readOnly: !edit,
                          controller: _yourLinkedInController,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.blueAccent,
                          style: const TextStyle(textBaseline: TextBaseline.alphabetic),
                          decoration: InputDecoration(
                            hintText: getHit(AppLocalizations.of(context)!.personalProfileFormYourLinkedInHint),
                            hintStyle: const TextStyle(fontSize: 14, color: Colors.black38),
                            contentPadding: const EdgeInsets.only(top: 12,),
                            counterText: '',
                            isDense: true,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // Image.asset('assets/icon/form_required.png', width: 8, height: 8,),
                          // const SizedBox(width: 6,),
                          Text(AppLocalizations.of(context)!.personalProfileFormYourYoutubeChannel, style: TextStyle(fontSize: 15, color: Colors.black87.withAlpha(220),),),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      Container(
                        width: double.infinity,
                        height: 44,
                        padding: const EdgeInsets.only(left: 10, right: 10,),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 0.6, color: Colors.grey.shade300,)
                        ),
                        child: TextFormField(
                          readOnly: !edit,
                          controller: _yourYoutubeChannelController,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.blueAccent,
                          style: const TextStyle(textBaseline: TextBaseline.alphabetic),
                          decoration: InputDecoration(
                            hintText: getHit(AppLocalizations.of(context)!.personalProfileFormYourYoutubeChannelHint),
                            hintStyle: const TextStyle(fontSize: 14, color: Colors.black38),
                            contentPadding: const EdgeInsets.only(top: 12,),
                            counterText: '',
                            isDense: true,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // Image.asset('assets/icon/form_required.png', width: 8, height: 8,),
                          // const SizedBox(width: 6,),
                          Text(AppLocalizations.of(context)!.personalProfileFormYourInstagram, style: TextStyle(fontSize: 15, color: Colors.black87.withAlpha(220),),),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      Container(
                        width: double.infinity,
                        height: 44,
                        padding: const EdgeInsets.only(left: 10, right: 10,),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 0.6, color: Colors.grey.shade300,)
                        ),
                        child: TextFormField(
                          readOnly: !edit,
                          controller: _yourInstagramController,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.blueAccent,
                          style: const TextStyle(textBaseline: TextBaseline.alphabetic),
                          decoration: InputDecoration(
                            hintText: getHit(AppLocalizations.of(context)!.personalProfileFormYourInstagramHint),
                            hintStyle: const TextStyle(fontSize: 14, color: Colors.black38),
                            contentPadding: const EdgeInsets.only(top: 12,),
                            counterText: '',
                            isDense: true,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),),
                ],
              ),
              const SizedBox(height: 30,),
            ],
          ),
        ),
      );
    }

    return  Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Personal Profile"),
        actions: [
          if(!edit) IconButton(onPressed: (){
            edit = true;
            setState(() {});
          }, icon: ImageIcon(Image.asset("assets/icon/edit.png").image)),
          if(edit) TextButton(
              onPressed: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                await _doSave();
                setState(() {});
              },
              child: Text(AppLocalizations.of(context)!.save,style: const TextStyle(color: Color(0xffFBB714),fontWeight: FontWeight.bold),)
          )
        ],
      ),
      body: ScrollConfiguration(
        behavior: CusBehavior(),
        child: _scroll(),
      ),
    );
  }

  _initFormData() {
    _formUserHead = context.read<AuthService>().getLoginInfo!.avatar;
    PersonalProfileInfoEntity personalProfileInfo = context.read<PersonalProfileService>().getPersonalProfileInfo!;
    if (personalProfileInfo.name != null) _yourNameController.text = personalProfileInfo.name!;
    if (personalProfileInfo.birthday != null) _formDateOfBirth = DateUtil.formatDate(DateTime.fromMillisecondsSinceEpoch(personalProfileInfo.birthday!), format: 'yyyy-MM-dd');
    developer.log("国家代码");
    developer.log( WidgetsBinding.instance?.window.locale.languageCode??"");
    getCountryCodeData(context, silence: true, result: (List<CountryCodeInfo> list) {
      CountryCodeInfo? initCountry;
      if(personalProfileInfo.country !=null){
        initCountry = list.firstWhere((element) => element.id == personalProfileInfo.country!);
      }else{
        initCountry = list.firstWhere((element) => element.iso2 == WidgetsBinding.instance?.window.locale.countryCode!);
      }
      _formCountry = initCountry;
      setState(() {});
      getStateDataByCountryCode(context, silence: true, countryCode: _formCountry!.iso2, result: (List<StateItemInfoEntity> list) {
        setState(() {
          _aboutState = list;
        });
        if(personalProfileInfo.state!=null){
          List<StateItemInfoEntity> initState = list.where((element) => element.id == personalProfileInfo.state!).toList();
          if (initState.isNotEmpty) {
            _formState = initState.first;
          }
        }
      });
    });
    _formIndustry = personalProfileInfo.industry;
    _formOccupation = personalProfileInfo.occupation;
    _selfIntroductionController.text = personalProfileInfo.introduction ?? '';
    _yourPhoneNumberController.text = personalProfileInfo.concatNumber ?? '';
    _yourWhatsAppController.text = personalProfileInfo.whatsapp ?? '';
    _yourFacebookController.text = personalProfileInfo.facebook ?? '';
    _yourLinkedInController.text = personalProfileInfo.linkedin ?? '';
    _yourYoutubeChannelController.text = personalProfileInfo.youtube ?? '';
    _yourInstagramController.text = personalProfileInfo.instagram ?? '';
  }

  _getStateData() {
    getStateDataByCountryCode(context, silence: true, countryCode: _formCountry!.iso2, result: (List<StateItemInfoEntity> list) {
      setState(() {
        _aboutState = list;
      });
    });
  }

  /// 选择城市
  /// 前提是已选国家，_formCountry
  _chooseState() {
    if (_aboutState.isNotEmpty) {
      showModalBottomSheet<StateItemInfoEntity?>(
          context: context,
          isScrollControlled: true,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * .8,
            minHeight: MediaQuery.of(context).size.height * .4,
          ),
          builder: (BuildContext context) {
            return StateChoose(states: _aboutState,);
          }).then((country) {
        if(country!=null){
          _formState = country;
          setState(() {});
        }
      });
    }
  }

  /// 选择行业
  _chooseIndustry() {
    getIndustryData(context, silence: false, result: (List<String> industryList) {
      showModalBottomSheet<String?>(
          context: context,
          isScrollControlled: true,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * .8,
            minHeight: MediaQuery.of(context).size.height * .4,
          ),
          builder: (BuildContext context) {
            return InputSelect(name: industryList,hitText: AppLocalizations.of(context)!.keyIndustryHit,);
          }).then((industry) {
        if(industry!=null){
          _formIndustry = industry;
          setState(() {});
        }
      });
    });
  }

  void _chooseOccupation() {
    showModalBottomSheet<String?>(
        context: context,
        isScrollControlled: true,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * .8,
          minHeight: MediaQuery.of(context).size.height * .4,
        ),
        builder: (BuildContext context) {
          return InputSelect(name: json.decode(AppLocalizations.of(context)!.position).cast<String>(), hitText: AppLocalizations.of(context)!.keyPositionHit,);
        }).then((industry) {
      if(industry!=null){
        _formOccupation = industry;
        setState(() {});
      }
    });
  }

  /// 保存个人资料
  _doSave() async {
    if (_formUserHead == null) {
      ComFun.showToast(msg: 'Please choose your profile picture');
      return;
    }
    if (_yourNameController.text.trim() == '') {
      ComFun.showToast(msg: 'Please fill your name');
      return;
    }

    if (_formCountry == null) {
      ComFun.showToast(msg: 'Please choose your country');
      return;
    }
    if(_formState == null){
      ComFun.showToast(msg: 'Please choose your state');
      return;
    }
    if (_formOccupation==null || _formOccupation == '') {
      ComFun.showToast(msg: 'Please fill your occupation');
      return;
    }
    if (_yourPhoneNumberController.text.trim() == '') {
      ComFun.showToast(msg: 'Please fill your phone number');
      return;
    }
    await userInfoUpdate(context,
      picture: _formUserHead!,
      name: _yourNameController.text.trim(),
      birthday:(_formDateOfBirth!=null ? DateTime.parse(_formDateOfBirth!).millisecondsSinceEpoch : null),
      country: _formCountry?.id,
      state: _formState?.id,
      industry: _formIndustry, // 行业
      occupation: _formOccupation!,
      introduction: _selfIntroductionController.text.trim(),
      concatNumber: _yourPhoneNumberController.text.trim(),
      whatsapp: _yourWhatsAppController.text.trim(),
      facebook: _yourFacebookController.text.trim(),
      linkedin: _yourLinkedInController.text.trim(),
      youtube: _yourYoutubeChannelController.text.trim(),
      instagram: _yourInstagramController.text.trim(),
      userId: context.read<AuthService>().getLoginInfo!.id,
      result: (PersonalProfileInfoEntity info) {
        ComFun.showToast(msg: AppLocalizations.of(context)!.updateProfileInfoSuccessToast);
        context.read<AuthService>().setAvatar(_formUserHead);
        saveLoginInfo(context, context.read<AuthService>().getLoginInfo);
        savePersonalProfileInfo(context, context.read<AuthService>().getLoginInfo!.id, info);
        AutoRouter.of(context).pop();
      },
    );
    edit = false;
  }

  getName() {
    if(context.read<SystemSetService>().appLanguage == "en"){
     return _formCountry?.name;
    }else{
      return _formCountry?.translations.cn??"";
    }
  }

  getHit(String text){
    if(edit){
      return text;
    }else{
      return  AppLocalizations.of(context)!.notFilled;
    }
  }

}
