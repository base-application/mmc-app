import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mmc/bean/personal_profile_info_entity.dart';
import 'package:mmc/router/auth_guard.dart';
import 'package:mmc/utils/comfun.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mmc/utils/comm_widget.dart';
import 'package:mmc/utils/event_bus.dart';
import 'package:mmc/utils/http.dart';
import 'package:mmc/utils/http_request.dart';
import 'package:provider/src/provider.dart';

class BusinessProfileCreatePage extends StatefulWidget {
  const BusinessProfileCreatePage({Key? key, this.info}) : super(key: key);

  final PersonalProfileInfoCompanyVos? info;

  @override
  State<StatefulWidget> createState() {
    return _BusinessProfileCreatePageState();
  }
}

class _BusinessProfileCreatePageState extends State<BusinessProfileCreatePage> {
  int? _companyId;
  bool _isEdit = true;

  String? _formCompanyLogo;
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _companyStreetController = TextEditingController();
  final TextEditingController _companyCityController = TextEditingController();
  final TextEditingController _companyPostcodeController = TextEditingController();
  final TextEditingController _companyWebsiteLinkController = TextEditingController();
  final TextEditingController _companyEmailAddressController = TextEditingController();
  final TextEditingController _companyPhoneNumberController = TextEditingController();
  final TextEditingController _companyFacebookController = TextEditingController();
  final TextEditingController _companyLinkedInController = TextEditingController();
  final TextEditingController _companyYoutubeChannelController = TextEditingController();
  final TextEditingController _companyInstagramController = TextEditingController();
  final TextEditingController _companySelfIntroductionController = TextEditingController();
  final TextEditingController _companyGoalsController = TextEditingController();
  final TextEditingController _companyAccomplishmentsController = TextEditingController();
  final TextEditingController _companyInterestsLookingForController = TextEditingController();
  final TextEditingController _companyProductServiceController = TextEditingController();
  final List<String> _formProducts = [];

  @override
  void initState() {
    super.initState();
    if (widget.info != null) {
      _isEdit = false;
      _companyId = widget.info!.companyId;
      _initPageData();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget _scroll() {
      return SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 10, left: 26, right: 26, bottom: 30,),
          child: Column(
            children: [
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
                          Text(AppLocalizations.of(context)!.businessProfileFormCompanyLogo, style: TextStyle(fontSize: 15, color: Colors.black87.withAlpha(220),),),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      GestureDetector(
                        child: netImgWrap(context,
                          width: 80,
                          height: 80,
                          url: _formCompanyLogo,
                          radius: 14,
                          errorWidget: Container(
                            width: 80,
                            height: 80,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: Color(0xFFDFE5ED),
                            ),
                            child: _isEdit ? const Icon(Icons.add_circle_rounded, size: 36, color: Color(0xFF013B7B),) : Container(),
                          ),
                        ),
                        behavior: HitTestBehavior.opaque,
                        onTap: () async {
                          if (_isEdit) {
                            String uploadPath = await httpUpload(context);
                            _formCompanyLogo = uploadPath;
                            setState(() {});
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
                          Image.asset('assets/icon/form_required.png', width: 8, height: 8,),
                          const SizedBox(width: 6,),
                          Text(AppLocalizations.of(context)!.businessProfileFormCompanyName, style: TextStyle(fontSize: 15, color: Colors.black87.withAlpha(220),),),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      Container(
                        width: double.infinity,
                        height: 44,
                        padding: const EdgeInsets.only(left: 10, right: 10,),
                        decoration: BoxDecoration(
                            color: _isEdit ? Colors.white : Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 0.6, color: Colors.grey.shade300,)
                        ),
                        child: TextFormField(
                          controller: _companyNameController,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.blueAccent,
                          readOnly: !_isEdit,
                          style: const TextStyle(textBaseline: TextBaseline.alphabetic),
                          decoration: InputDecoration(
                            hintText: _isEdit ? AppLocalizations.of(context)!.businessProfileFormCompanyNameHint : '',
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
                          Image.asset('assets/icon/form_required.png', width: 8, height: 8,),
                          const SizedBox(width: 6,),
                          Text(AppLocalizations.of(context)!.businessProfileFormCompanyAddress, style: TextStyle(fontSize: 15, color: Colors.black87.withAlpha(220),),),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      Container(
                        width: double.infinity,
                        height: 44,
                        padding: const EdgeInsets.only(left: 10, right: 10,),
                        decoration: BoxDecoration(
                            color: _isEdit ? Colors.white : Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 0.6, color: Colors.grey.shade300,)
                        ),
                        child: TextFormField(
                          controller: _companyStreetController,
                          keyboardType: TextInputType.streetAddress,
                          cursorColor: Colors.blueAccent,
                          readOnly: !_isEdit,
                          style: const TextStyle(textBaseline: TextBaseline.alphabetic),
                          decoration: InputDecoration(
                            hintText: _isEdit ? AppLocalizations.of(context)!.businessProfileFormCompanyAddressStreetHint : '',
                            hintStyle: const TextStyle(fontSize: 14, color: Colors.black38),
                            contentPadding: const EdgeInsets.only(top: 12,),
                            counterText: '',
                            isDense: true,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 2,),
                      Container(
                        width: double.infinity,
                        height: 44,
                        padding: const EdgeInsets.only(left: 10, right: 10,),
                        decoration: BoxDecoration(
                            color: _isEdit ? Colors.white : Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 0.6, color: Colors.grey.shade300,)
                        ),
                        child: TextFormField(
                          controller: _companyCityController,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.blueAccent,
                          readOnly: !_isEdit,
                          style: const TextStyle(textBaseline: TextBaseline.alphabetic),
                          decoration: InputDecoration(
                            hintText: _isEdit ? AppLocalizations.of(context)!.businessProfileFormCompanyAddressCityHint : '',
                            hintStyle: const TextStyle(fontSize: 14, color: Colors.black38),
                            contentPadding: const EdgeInsets.only(top: 12,),
                            counterText: '',
                            isDense: true,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 2,),
                      Container(
                        width: double.infinity,
                        height: 44,
                        padding: const EdgeInsets.only(left: 10, right: 10,),
                        decoration: BoxDecoration(
                            color: _isEdit ? Colors.white : Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 0.6, color: Colors.grey.shade300,)
                        ),
                        child: TextFormField(
                          controller: _companyPostcodeController,
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.blueAccent,
                          readOnly: !_isEdit,
                          style: const TextStyle(textBaseline: TextBaseline.alphabetic),
                          decoration: InputDecoration(
                            hintText: _isEdit ? AppLocalizations.of(context)!.businessProfileFormCompanyAddressPostcodeHint : '',
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
                          Image.asset('assets/icon/form_required.png', width: 8, height: 8,),
                          const SizedBox(width: 6,),
                          Text(AppLocalizations.of(context)!.businessProfileFormCompanyWebsiteLink, style: TextStyle(fontSize: 15, color: Colors.black87.withAlpha(220),),),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      Container(
                        width: double.infinity,
                        height: 44,
                        padding: const EdgeInsets.only(left: 10, right: 10,),
                        decoration: BoxDecoration(
                            color: _isEdit ? Colors.white : Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 0.6, color: Colors.grey.shade300,)
                        ),
                        child: TextFormField(
                          controller: _companyWebsiteLinkController,
                          keyboardType: TextInputType.url,
                          cursorColor: Colors.blueAccent,
                          readOnly: !_isEdit,
                          style: const TextStyle(textBaseline: TextBaseline.alphabetic),
                          decoration: InputDecoration(
                            hintText: _isEdit ? AppLocalizations.of(context)!.businessProfileFormCompanyWebsiteLinkHint : '',
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
                          Text(AppLocalizations.of(context)!.businessProfileFormCompanyEmailAddress, style: TextStyle(fontSize: 15, color: Colors.black87.withAlpha(220),),),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      Container(
                        width: double.infinity,
                        height: 44,
                        padding: const EdgeInsets.only(left: 10, right: 10,),
                        decoration: BoxDecoration(
                            color: _isEdit ? Colors.white : Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 0.6, color: Colors.grey.shade300,)
                        ),
                        child: TextFormField(
                          controller: _companyEmailAddressController,
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Colors.blueAccent,
                          readOnly: !_isEdit,
                          style: const TextStyle(textBaseline: TextBaseline.alphabetic),
                          decoration: InputDecoration(
                            hintText: _isEdit ? AppLocalizations.of(context)!.businessProfileFormCompanyEmailAddressHint : '',
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
                          Text(AppLocalizations.of(context)!.businessProfileFormCompanyPhoneNumber, style: TextStyle(fontSize: 15, color: Colors.black87.withAlpha(220),),),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      Container(
                        width: double.infinity,
                        height: 44,
                        padding: const EdgeInsets.only(left: 10, right: 10,),
                        decoration: BoxDecoration(
                            color: _isEdit ? Colors.white : Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 0.6, color: Colors.grey.shade300,)
                        ),
                        child: TextFormField(
                          controller: _companyPhoneNumberController ,
                          keyboardType: TextInputType.phone,
                          cursorColor: Colors.blueAccent,
                          readOnly: !_isEdit,
                          style: const TextStyle(textBaseline: TextBaseline.alphabetic),
                          decoration: InputDecoration(
                            hintText: _isEdit ? AppLocalizations.of(context)!.businessProfileFormCompanyPhoneNumberHint : '',
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
                          Text(AppLocalizations.of(context)!.businessProfileFormCompanyYourFacebook, style: TextStyle(fontSize: 15, color: Colors.black87.withAlpha(220),),),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      Container(
                        width: double.infinity,
                        height: 44,
                        padding: const EdgeInsets.only(left: 10, right: 10,),
                        decoration: BoxDecoration(
                            color: _isEdit ? Colors.white : Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 0.6, color: Colors.grey.shade300,)
                        ),
                        child: TextFormField(
                          controller: _companyFacebookController,
                          keyboardType: TextInputType.url,
                          cursorColor: Colors.blueAccent,
                          readOnly: !_isEdit,
                          style: const TextStyle(textBaseline: TextBaseline.alphabetic),
                          decoration: InputDecoration(
                            hintText: _isEdit ? AppLocalizations.of(context)!.businessProfileFormCompanyYourFacebookHint : '',
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
                          Text(AppLocalizations.of(context)!.businessProfileFormCompanyYourLinkedIn, style: TextStyle(fontSize: 15, color: Colors.black87.withAlpha(220),),),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      Container(
                        width: double.infinity,
                        height: 44,
                        padding: const EdgeInsets.only(left: 10, right: 10,),
                        decoration: BoxDecoration(
                            color: _isEdit ? Colors.white : Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 0.6, color: Colors.grey.shade300,)
                        ),
                        child: TextFormField(
                          controller: _companyLinkedInController,
                          keyboardType: TextInputType.url,
                          cursorColor: Colors.blueAccent,
                          readOnly: !_isEdit,
                          style: const TextStyle(textBaseline: TextBaseline.alphabetic),
                          decoration: InputDecoration(
                            hintText: _isEdit ? AppLocalizations.of(context)!.businessProfileFormCompanyYourLinkedInHint : '',
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
                          Text(AppLocalizations.of(context)!.businessProfileFormCompanyYourYoutubeChannel, style: TextStyle(fontSize: 15, color: Colors.black87.withAlpha(220),),),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      Container(
                        width: double.infinity,
                        height: 44,
                        padding: const EdgeInsets.only(left: 10, right: 10,),
                        decoration: BoxDecoration(
                            color: _isEdit ? Colors.white : Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 0.6, color: Colors.grey.shade300,)
                        ),
                        child: TextFormField(
                          controller: _companyYoutubeChannelController,
                          keyboardType: TextInputType.url,
                          cursorColor: Colors.blueAccent,
                          readOnly: !_isEdit,
                          style: const TextStyle(textBaseline: TextBaseline.alphabetic),
                          decoration: InputDecoration(
                            hintText: _isEdit ? AppLocalizations.of(context)!.businessProfileFormCompanyYourYoutubeChannelHint : '',
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
                          Text(AppLocalizations.of(context)!.businessProfileFormCompanyYourInstagram, style: TextStyle(fontSize: 15, color: Colors.black87.withAlpha(220),),),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      Container(
                        width: double.infinity,
                        height: 44,
                        padding: const EdgeInsets.only(left: 10, right: 10,),
                        decoration: BoxDecoration(
                            color: _isEdit ? Colors.white : Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 0.6, color: Colors.grey.shade300,)
                        ),
                        child: TextFormField(
                          controller: _companyInstagramController,
                          keyboardType: TextInputType.url,
                          cursorColor: Colors.blueAccent,
                          readOnly: !_isEdit,
                          style: const TextStyle(textBaseline: TextBaseline.alphabetic),
                          decoration: InputDecoration(
                            hintText: _isEdit ? AppLocalizations.of(context)!.businessProfileFormCompanyYourInstagramHint : '',
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
                          Image.asset('assets/icon/form_required.png', width: 8, height: 8,),
                          const SizedBox(width: 6,),
                          Text(AppLocalizations.of(context)!.businessProfileFormCompanySelfIntroduction, style: TextStyle(fontSize: 15, color: Colors.black87.withAlpha(220),),),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      Container(
                        width: double.infinity,
                        height: 110,
                        padding: const EdgeInsets.only(left: 10, right: 10,),
                        decoration: BoxDecoration(
                            color: _isEdit ? Colors.white : Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 0.6, color: Colors.grey.shade300,)
                        ),
                        child: TextFormField(
                          controller: _companySelfIntroductionController,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.blueAccent,
                          readOnly: !_isEdit,
                          maxLines: 4,
                          style: const TextStyle(textBaseline: TextBaseline.alphabetic),
                          decoration: InputDecoration(
                            hintText: _isEdit ? AppLocalizations.of(context)!.businessProfileFormCompanySelfIntroductionHint : '',
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
                          Text(AppLocalizations.of(context)!.businessProfileFormCompanyGoals, style: TextStyle(fontSize: 15, color: Colors.black87.withAlpha(220),),),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      Container(
                        width: double.infinity,
                        height: 110,
                        padding: const EdgeInsets.only(left: 10, right: 10,),
                        decoration: BoxDecoration(
                            color: _isEdit ? Colors.white : Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 0.6, color: Colors.grey.shade300,)
                        ),
                        child: TextFormField(
                          controller: _companyGoalsController,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.blueAccent,
                          readOnly: !_isEdit,
                          maxLines: 4,
                          style: const TextStyle(textBaseline: TextBaseline.alphabetic),
                          decoration: InputDecoration(
                            hintText: _isEdit ? AppLocalizations.of(context)!.businessProfileFormCompanyGoalsHint : '',
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
                          Text(AppLocalizations.of(context)!.businessProfileFormCompanyAccomplishments, style: TextStyle(fontSize: 15, color: Colors.black87.withAlpha(220),),),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      Container(
                        width: double.infinity,
                        height: 110,
                        padding: const EdgeInsets.only(left: 10, right: 10,),
                        decoration: BoxDecoration(
                            color: _isEdit ? Colors.white : Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 0.6, color: Colors.grey.shade300,)
                        ),
                        child: TextFormField(
                          controller: _companyAccomplishmentsController,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.blueAccent,
                          readOnly: !_isEdit,
                          maxLines: 4,
                          style: const TextStyle(textBaseline: TextBaseline.alphabetic),
                          decoration: InputDecoration(
                            hintText: _isEdit ? AppLocalizations.of(context)!.businessProfileFormCompanyAccomplishmentsHint : '',
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
                          Text(AppLocalizations.of(context)!.businessProfileFormCompanyInterests, style: TextStyle(fontSize: 15, color: Colors.black87.withAlpha(220),),),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      Container(
                        width: double.infinity,
                        height: 110,
                        padding: const EdgeInsets.only(left: 10, right: 10,),
                        decoration: BoxDecoration(
                            color: _isEdit ? Colors.white : Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 0.6, color: Colors.grey.shade300,)
                        ),
                        child: TextFormField(
                          controller: _companyInterestsLookingForController,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.blueAccent,
                          readOnly: !_isEdit,
                          maxLines: 4,
                          style: const TextStyle(textBaseline: TextBaseline.alphabetic),
                          decoration: InputDecoration(
                            hintText: _isEdit ? AppLocalizations.of(context)!.businessProfileFormCompanyInterestsHint : '',
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
                          Text(AppLocalizations.of(context)!.businessProfileFormCompanyProduct, style: TextStyle(fontSize: 15, color: Colors.black87.withAlpha(220),),),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      Container(
                        width: double.infinity,
                        height: 110,
                        padding: const EdgeInsets.only(left: 10, right: 10,),
                        decoration: BoxDecoration(
                            color: _isEdit ? Colors.white : Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 0.6, color: Colors.grey.shade300,)
                        ),
                        child: TextFormField(
                          controller: _companyProductServiceController,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.blueAccent,
                          readOnly: !_isEdit,
                          maxLines: 4,
                          style: const TextStyle(textBaseline: TextBaseline.alphabetic),
                          decoration: InputDecoration(
                            hintText: _isEdit ? AppLocalizations.of(context)!.businessProfileFormCompanyProductHint : '',
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
              if (_isEdit || _formProducts.isNotEmpty) Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // Image.asset('assets/icon/form_required.png', width: 8, height: 8,),
                          // const SizedBox(width: 6,),
                          Text(AppLocalizations.of(context)!.businessProfileFormCompanyAddProduct, style: TextStyle(fontSize: 15, color: Colors.black87.withAlpha(220),),),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      GridView.builder(
                        padding: const EdgeInsets.only(top: 8),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 9 / 12,
                        ),
                        itemCount: _formProducts.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          if (index < _formProducts.length) {
                            return GestureDetector(
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  netImgWrap(context,
                                    url: _formProducts[index],
                                    radius: 14,
                                    errorWidget: Container(
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFDFE5ED),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    child: Icon(Icons.cancel_rounded, size: 18, color: Colors.black87.withAlpha(180),),
                                    top: -2,
                                    right: 0,
                                  ),
                                ],
                              ),
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                _formProducts.removeAt(index);
                                setState(() {});
                              },
                            );
                          }
                          return GestureDetector(
                            child: netImgWrap(context,
                              url: null,
                              radius: 14,
                              errorWidget: Container(
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFDFE5ED),
                                ),
                                child: const Icon(Icons.add_circle_rounded, size: 36, color: Color(0xFF013B7B),),
                              ),
                            ),
                            behavior: HitTestBehavior.opaque,
                            onTap: () async {
                              String uploadPath = await httpUpload(context);
                              _formProducts.add(uploadPath);
                              setState(() {});
                            },
                          );
                        },
                      ),
                    ],
                  ),),
                ],
              ),
              if (_isEdit) const SizedBox(height: 40,),
              if (_isEdit) SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 46,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(const Color(0xFFFBB714)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    elevation: MaterialStateProperty.all(0),
                  ),
                  child: Text(AppLocalizations.of(context)!.save, style: const TextStyle(color: Color(0xFF013B7B), fontSize: 16, fontWeight: FontWeight.bold,),),
                  onPressed: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    _doSave();
                  },
                ),
              ),
              const SizedBox(height: 80,),
            ],
          ),
        ),
      );
    }

    return PageContainer(
      title: 'Personal Profile',
      resizeToAvoidBottomInset: true,
      body: ScrollConfiguration(
        behavior: CusBehavior(),
        child: _scroll(),
      ),
      rightBtn: ({ int? homeIndex }) {
        return {
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: _isEdit ? const Text('') : const Icon(Icons.create_rounded, size: 22,),
          ): (ctx) {
            if (!_isEdit) {
              _isEdit = true;
            }
            setState(() {});
          },
        };
      },
    );
  }

  _initPageData() {
    _formCompanyLogo = widget.info!.companyLogo;
    _companyNameController.text = widget.info!.companyName ?? '';
    _companyStreetController.text = widget.info!.companyAddress ?? '';
    _companyCityController.text = widget.info!.city ?? '';
    _companyPostcodeController.text = widget.info!.postCode ?? '';
    _companyWebsiteLinkController.text = widget.info!.companyWebsite ?? '';
    _companyEmailAddressController.text = widget.info!.companyEmail ?? '';
    _companyPhoneNumberController.text = widget.info!.companyPhone ?? '';
    _companyFacebookController.text = widget.info!.companyFacebook ?? '';
    _companyLinkedInController.text = widget.info!.companyLinkedin ?? '';
    _companyYoutubeChannelController.text = widget.info!.companyYoutube ?? '';
    _companyInstagramController.text = widget.info!.companyInstagram ?? '';
    _companySelfIntroductionController.text = widget.info!.companyIntroduction ?? '';
    _companyGoalsController.text = widget.info!.companyGoals ?? '';
    _companyAccomplishmentsController.text = widget.info!.companyAccomplishments ?? '';
    _companyInterestsLookingForController.text = widget.info!.companyInterests ?? '';
    _companyProductServiceController.text = widget.info!.serviceIntroduction ?? '';
    _formProducts.clear();
    _formProducts.addAll(widget.info!.producePictures.map((e) => e.producePicture).toList());
  }

  /// 保存个人资料
  _doSave() {
    if (_formCompanyLogo == null) {
      ComFun.showToast(msg: 'Please choose your company logo');
      return;
    }
    if (_companyNameController.text.trim() == '') {
      ComFun.showToast(msg: 'Please fill your company name');
      return;
    }
    if (_companyStreetController.text.trim() == '') {
      ComFun.showToast(msg: 'Please fill your company street');
      return;
    }
    if (_companyCityController.text.trim() == '') {
      ComFun.showToast(msg: 'Please fill your company city');
      return;
    }
    if (_companyPostcodeController.text.trim() == '') {
      ComFun.showToast(msg: 'Please fill your company postcode');
      return;
    }
    if (_companyWebsiteLinkController.text.trim() == '') {
      ComFun.showToast(msg: 'Please fill your company website link');
      return;
    }
    if (_companySelfIntroductionController.text.trim() == '') {
      ComFun.showToast(msg: 'Please fill your company self introduction');
      return;
    }
    companyInfoAddOrUpdate(context,
      companyId: _companyId,
      companyLogo: _formCompanyLogo!,
      companyName: _companyNameController.text.trim(),
      companyAddress: _companyStreetController.text.trim(),
      companyCity: _companyCityController.text.trim(),
      companyPostcode: _companyPostcodeController.text.trim(),
      companyWebsite: _companyWebsiteLinkController.text.trim(),
      companyEmail: _companyEmailAddressController.text.trim(),
      companyPhone: _companyPhoneNumberController.text.trim(),
      companyFacebook: _companyFacebookController.text.trim(),
      companyLinkedin: _companyLinkedInController.text.trim(),
      companyYoutube: _companyYoutubeChannelController.text.trim(),
      companyInstagram: _companyInstagramController.text.trim(),
      companyIntroduction: _companySelfIntroductionController.text.trim(),
      companyGoals: _companyGoalsController.text.trim(),
      companyAccomplishments: _companyAccomplishmentsController.text.trim(),
      companyInterests: _companyInterestsLookingForController.text.trim(),
      serviceIntroduction: _companyProductServiceController.text.trim(),
      producePictures: _formProducts.map((e) => { 'companyId': _companyId, 'producePicture': e }).toList(),
      userId: context.read<AuthService>().getLoginInfo!.id,
      result: (int companyId) {
        _companyId = companyId;
        ComFun.showToast(msg: AppLocalizations.of(context)!.updateProfileInfoSuccessToast);
        eventBus.fire(CompanyListInfoChangeEvent());
      },
    );
  }
}
