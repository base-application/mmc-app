import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/style/picker_style.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';
import 'package:flutter_pickers/time_picker/model/pduration.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mmc/bean/grade_level_info_entity.dart';
import 'package:mmc/bean/group_item_entity.dart';
import 'package:mmc/router/auth_guard.dart';
import 'package:mmc/utils/comfun.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mmc/utils/comm_widget.dart';
import 'package:mmc/utils/http.dart';
import 'package:mmc/utils/http_request.dart';
import 'package:provider/src/provider.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CreateEventPageState();
  }
}

class _CreateEventPageState extends State<CreateEventPage> {
  bool _showGroupSelectItem = false;
  final List<GradeLevelInfoEntity> _formEventFor = [];
  final List<GroupItemEntity> _formGroup = [];
  final TextEditingController _formTitleController = TextEditingController();
  final TextEditingController _formDescriptionController = TextEditingController();
  String? _formStartDate;
  String? _formStartTime;
  String? _formEndDate;
  String? _formEndTime;
  final TextEditingController _formLocationController = TextEditingController();
  final TextEditingController _formRespectiveLinkController = TextEditingController();
  final List<String> _formPoster = [];

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
                          Text(AppLocalizations.of(context)!.createEventFormEventFor, style: TextStyle(fontSize: 15, color: Colors.black87.withAlpha(220),),),
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
                                child: Text(_formEventFor.isEmpty ? AppLocalizations.of(context)!.createEventFormEventForHint : _formEventFor.map((e) => e.gradeName).join(','), style: TextStyle(fontSize: 14, color: _formEventFor.isEmpty ? Colors.black38 : Colors.black87,), overflow: TextOverflow.ellipsis,),
                              ),
                              const Icon(Icons.arrow_drop_down_rounded, size: 22, color: Colors.black54,),
                            ],
                          ),
                        ),
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          _showGradeSelect();
                        },
                      ),
                    ],
                  ),),
                ],
              ),
              if (_showGroupSelectItem) const SizedBox(height: 20,),
              if (_showGroupSelectItem) Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // Image.asset('assets/icon/form_required.png', width: 8, height: 8,),
                          // const SizedBox(width: 6,),
                          Text(AppLocalizations.of(context)!.createEventFormGroup, style: TextStyle(fontSize: 15, color: Colors.black87.withAlpha(220),),),
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
                                child: Text(_formGroup.isEmpty ? AppLocalizations.of(context)!.createEventFormGroupHint : _formGroup.map((e) => e.groupName).join(','), style: TextStyle(fontSize: 14, color: _formGroup.isEmpty ? Colors.black38 : Colors.black87,), overflow: TextOverflow.ellipsis,),
                              ),
                              const Icon(Icons.arrow_drop_down_rounded, size: 22, color: Colors.black54,),
                            ],
                          ),
                        ),
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          _showGroupSelect();
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
                          Text(AppLocalizations.of(context)!.createEventFormTitle, style: TextStyle(fontSize: 15, color: Colors.black87.withAlpha(220),),),
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
                          controller: _formTitleController,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.blueAccent,
                          style: const TextStyle(textBaseline: TextBaseline.alphabetic),
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.createEventFormTitleHint,
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
                          Text(AppLocalizations.of(context)!.createEventFormDescription, style: TextStyle(fontSize: 15, color: Colors.black87.withAlpha(220),),),
                        ],
                      ),
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
                          controller: _formDescriptionController,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.blueAccent,
                          maxLines: 4,
                          style: const TextStyle(textBaseline: TextBaseline.alphabetic),
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.createEventFormDescriptionHint,
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
                          Text(AppLocalizations.of(context)!.createEventFormStartDateTime, style: TextStyle(fontSize: 15, color: Colors.black87.withAlpha(220),),),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      Row(
                        children: [
                          GestureDetector(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.45,
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
                                    child: Text(_formStartDate ?? AppLocalizations.of(context)!.createEventFormStartDateHint, style: TextStyle(fontSize: 14, color: _formStartDate == null ? Colors.black38 : Colors.black87,), overflow: TextOverflow.ellipsis,),
                                  ),
                                  const Icon(Icons.arrow_drop_down_rounded, size: 22, color: Colors.black54,),
                                ],
                              ),
                            ),
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              if (_formStartDate == null) {
                                setState(() {
                                  _formStartDate = DateUtil.formatDate(DateTime.now(), format: 'yyyy-MM-dd');
                                });
                              }
                              Pickers.showDatePicker(context,
                                mode: DateMode.YMD,
                                selectDate: _formStartDate != null ? PDuration.parse(DateTime.parse(_formStartDate!)) : null,
                                minDate: PDuration.now(),
                                maxDate: _formEndDate != null ? PDuration.parse(DateTime.parse(_formEndDate!)) : null,
                                pickerStyle: PickerStyle(
                                  showTitleBar: false,
                                  backgroundColor: Colors.white,
                                  textColor: Colors.black87,
                                  pickerHeight: MediaQuery.of(context).size.height * 0.4,
                                  menuHeight: MediaQuery.of(context).size.height * 0.4,
                                ),
                                onChanged: (res) {
                                  setState(() {
                                    _formStartDate = DateUtil.formatDate(DateTime.utc(res.year!, res.month!, res.day!), format: 'yyyy-MM-dd');
                                  });
                                },
                              );
                            },
                          ),
                          const SizedBox(width: 12,),
                          Expanded(child: GestureDetector(
                            child: Container(
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
                                    child: Text(_formStartTime ?? AppLocalizations.of(context)!.createEventFormStartTimeHint, style: TextStyle(fontSize: 14, color: _formStartTime == null ? Colors.black38 : Colors.black87,), overflow: TextOverflow.ellipsis,),
                                  ),
                                  const Icon(Icons.arrow_drop_down_rounded, size: 22, color: Colors.black54,),
                                ],
                              ),
                            ),
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              if (_formStartTime == null) {
                                setState(() {
                                  _formStartTime = DateUtil.formatDate(DateTime.now(), format: 'HH:mm');
                                });
                              }
                              Pickers.showDatePicker(context,
                                mode: DateMode.HM,
                                selectDate: _formStartTime != null ? PDuration.parse(DateTime.parse('2000-01-01 $_formStartTime')) : null,
                                minDate: PDuration.now(),
                                maxDate: _formEndTime != null ? PDuration.parse(DateTime.parse('2000-01-01 $_formEndTime')) : null,
                                pickerStyle: PickerStyle(
                                  showTitleBar: false,
                                  backgroundColor: Colors.white,
                                  textColor: Colors.black87,
                                  pickerHeight: MediaQuery.of(context).size.height * 0.4,
                                  menuHeight: MediaQuery.of(context).size.height * 0.4,
                                ),
                                onChanged: (res) {
                                  setState(() {
                                    _formStartTime = DateUtil.formatDate(DateTime.utc(res.year!, res.month!, res.day!, res.hour!, res.minute!), format: 'HH:mm');
                                  });
                                },
                              );
                            },
                          ),),
                        ],
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
                          Text(AppLocalizations.of(context)!.createEventFormEndDateTime, style: TextStyle(fontSize: 15, color: Colors.black87.withAlpha(220),),),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      Row(
                        children: [
                          GestureDetector(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.45,
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
                                    child: Text(_formEndDate ?? AppLocalizations.of(context)!.createEventFormEndDateHint, style: TextStyle(fontSize: 14, color: _formEndDate == null ? Colors.black38 : Colors.black87,), overflow: TextOverflow.ellipsis,),
                                  ),
                                  const Icon(Icons.arrow_drop_down_rounded, size: 22, color: Colors.black54,),
                                ],
                              ),
                            ),
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              if (_formEndDate == null) {
                                if (_formStartDate != null) {
                                  setState(() {
                                    _formEndDate = DateUtil.formatDate(DateTime.parse(_formStartDate!), format: 'yyyy-MM-dd');
                                  });
                                } else {
                                  setState(() {
                                    _formEndDate = DateUtil.formatDate(DateTime.now(), format: 'yyyy-MM-dd');
                                  });
                                }
                              }
                              Pickers.showDatePicker(context,
                                mode: DateMode.YMD,
                                selectDate: _formEndDate != null ? PDuration.parse(DateTime.parse(_formEndDate!)) : null,
                                minDate: _formStartDate != null ? PDuration.parse(DateTime.parse(_formStartDate!)) : PDuration.now(),
                                pickerStyle: PickerStyle(
                                  showTitleBar: false,
                                  backgroundColor: Colors.white,
                                  textColor: Colors.black87,
                                  pickerHeight: MediaQuery.of(context).size.height * 0.4,
                                  menuHeight: MediaQuery.of(context).size.height * 0.4,
                                ),
                                onChanged: (res) {
                                  setState(() {
                                    _formEndDate = DateUtil.formatDate(DateTime.utc(res.year!, res.month!, res.day!), format: 'yyyy-MM-dd');
                                  });
                                },
                              );
                            },
                          ),
                          const SizedBox(width: 12,),
                          Expanded(child: GestureDetector(
                            child: Container(
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
                                    child: Text(_formEndTime ?? AppLocalizations.of(context)!.createEventFormEndTimeHint, style: TextStyle(fontSize: 14, color: _formEndTime == null ? Colors.black38 : Colors.black87,), overflow: TextOverflow.ellipsis,),
                                  ),
                                  const Icon(Icons.arrow_drop_down_rounded, size: 22, color: Colors.black54,),
                                ],
                              ),
                            ),
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              if (_formEndTime == null) {
                                if (_formStartTime != null) {
                                  setState(() {
                                    _formEndTime = DateUtil.formatDate(DateTime.parse('2000-01-01 $_formStartTime'), format: 'HH:mm');
                                  });
                                } else {
                                  setState(() {
                                    _formEndTime = DateUtil.formatDate(DateTime.now(), format: 'HH:mm');
                                  });
                                }
                              }
                              Pickers.showDatePicker(context,
                                mode: DateMode.HM,
                                selectDate: _formEndTime != null ? PDuration.parse(DateTime.parse('2000-01-01 $_formEndTime')) : null,
                                minDate: _formStartTime != null ? PDuration.parse(DateTime.parse('2000-01-01 $_formStartTime')) : PDuration.now(),
                                pickerStyle: PickerStyle(
                                  showTitleBar: false,
                                  backgroundColor: Colors.white,
                                  textColor: Colors.black87,
                                  pickerHeight: MediaQuery.of(context).size.height * 0.4,
                                  menuHeight: MediaQuery.of(context).size.height * 0.4,
                                ),
                                onChanged: (res) {
                                  setState(() {
                                    _formEndTime = DateUtil.formatDate(DateTime.utc(res.year!, res.month!, res.day!, res.hour!, res.minute!), format: 'HH:mm');
                                  });
                                },
                              );
                            },
                          ),),
                        ],
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
                          Text(AppLocalizations.of(context)!.createEventFormLocation, style: TextStyle(fontSize: 15, color: Colors.black87.withAlpha(220),),),
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
                          controller: _formLocationController,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.blueAccent,
                          style: const TextStyle(textBaseline: TextBaseline.alphabetic),
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.createEventFormLocationHint,
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
                          Text(AppLocalizations.of(context)!.createEventFormRespectiveLink, style: TextStyle(fontSize: 15, color: Colors.black87.withAlpha(220),),),
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
                          controller: _formRespectiveLinkController,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.blueAccent,
                          style: const TextStyle(textBaseline: TextBaseline.alphabetic),
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.createEventFormRespectiveLinkHint,
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
                          Text(AppLocalizations.of(context)!.createEventFormPoster, style: TextStyle(fontSize: 15, color: Colors.black87.withAlpha(220),),),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      ListView.builder(itemBuilder: (BuildContext context, int index) {
                        if (index < _formPoster.length) {
                          return Container(
                            height: 170,
                            margin: const EdgeInsets.only(bottom: 16),
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: netImgWrap(context,
                              url: _formPoster[index],
                              errorWidget: Container(color: Colors.grey.shade300,),
                            ),
                          );
                        }
                        return GestureDetector(
                          child: Container(
                            height: 170,
                            decoration: BoxDecoration(
                              color: const Color(0xFFDEE5EE),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(Icons.add_circle_rounded, size: 34, color: Color(0xFF0541A2),),
                          ),
                          behavior: HitTestBehavior.opaque,
                          onTap: () async {

                            String uploadPath = await httpUpload(context);
                          _formPoster.add(uploadPath);
                            setState(() {});
                          },
                        );
                      }, itemCount: _formPoster.length + 1, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),),
                    ],
                  ),),
                ],
              ),
              const SizedBox(height: 40,),
              SizedBox(
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
                    _saveData();
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
      title: 'Create Event',
      titleBarBgColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: ScrollConfiguration(
        behavior: CusBehavior(),
        child: _scroll(),
      ),
    );
  }

  _showGradeSelect() {
    getGradeListData(context, result: (List<GradeLevelInfoEntity> list) {
      showModalBottomSheet(context: context, builder: (BuildContext context) {
        return GridView.builder(
          padding: const EdgeInsets.only(top: 14, bottom: 14, left: 18, right: 18,),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 3 / 1,
          ),
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return StatefulBuilder(builder: (ctx, setSta) {
              bool isChoose = _formEventFor.where((element) => element.gradeId == list[index].gradeId).isNotEmpty;
              return GestureDetector(
                child: Stack(
                  fit: StackFit.expand,
                  alignment: Alignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isChoose ? Colors.teal.shade100 : Colors.teal.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(list[index].gradeName, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500,), textAlign: TextAlign.center,),
                    ),
                    if (isChoose) const Positioned(
                      child: Icon(Icons.album_outlined, size: 14,),
                      left: 4,
                      top: 4,
                    ),
                  ],
                ),
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  int inIndex = _formEventFor.indexWhere((element) => element.gradeId == list[index].gradeId);
                  if (inIndex >= 0) {
                    _formEventFor.removeAt(inIndex);
                  } else {
                    _formEventFor.add(list[index]);
                  }
                  _showGroupSelectItem = _formEventFor.where((element) => element.gradeId > 3).isNotEmpty;
                  setSta(() {});
                  setState(() {});
                },
              );
            });
          },
        );
      });
    });
  }

  _showGroupSelect() {
    getGroupListData(context, result: (List<GroupItemEntity> list) {
      showModalBottomSheet(context: context, builder: (BuildContext context) {
        return GridView.builder(
          padding: const EdgeInsets.only(top: 14, bottom: 14, left: 18, right: 18,),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 3 / 1,
          ),
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return StatefulBuilder(builder: (ctx, setSta) {
              bool isChoose = _formGroup.where((element) => element.groupId == list[index].groupId).isNotEmpty;
              return GestureDetector(
                child: Stack(
                  fit: StackFit.expand,
                  alignment: Alignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isChoose ? Colors.teal.shade100 : Colors.teal.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(list[index].groupName, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500,), textAlign: TextAlign.center,),
                    ),
                    if (isChoose) const Positioned(
                      child: Icon(Icons.album_outlined, size: 14,),
                      left: 4,
                      top: 4,
                    ),
                  ],
                ),
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  int inIndex = _formGroup.indexWhere((element) => element.groupId == list[index].groupId);
                  if (inIndex >= 0) {
                    _formGroup.removeAt(inIndex);
                  } else {
                    _formGroup.add(list[index]);
                  }
                  setSta(() {});
                  setState(() {});
                },
              );
            });
          },
        );
      });
    });
  }

  _saveData() {
    if (_formEventFor.isEmpty) {
      ComFun.showToast(msg: 'Please fill event for', err: true);
      return false;
    }
    if (_formTitleController.text.trim() == '') {
      ComFun.showToast(msg: 'Please fill title', err: true);
      return false;
    }
    if (_formDescriptionController.text.trim() == '') {
      ComFun.showToast(msg: 'Please fill description', err: true);
      return false;
    }
    if (_formStartDate == null) {
      ComFun.showToast(msg: 'Please fill start date', err: true);
      return false;
    }
    if (_formStartTime == null) {
      ComFun.showToast(msg: 'Please fill start time', err: true);
      return false;
    }
    if (_formEndDate == null) {
      ComFun.showToast(msg: 'Please fill end date', err: true);
      return false;
    }
    if (_formEndTime == null) {
      ComFun.showToast(msg: 'Please fill end time', err: true);
      return false;
    }
    if (_formLocationController.text.trim() == '') {
      ComFun.showToast(msg: 'Please fill location', err: true);
      return false;
    }
    if (_formRespectiveLinkController.text.trim() == '') {
      ComFun.showToast(msg: 'Please fill respective link', err: true);
      return false;
    }
    if (_formPoster.isEmpty) {
      ComFun.showToast(msg: 'Please choose poster', err: true);
      return false;
    }
    createEventData(context,
      grades: _formEventFor,
      groups: _formGroup.isNotEmpty ? _formGroup : null,
      eventTitle: _formTitleController.text.trim(),
      eventDescription: _formDescriptionController.text.trim(),
      eventStartTime: DateUtil.getDateTime('$_formStartDate $_formStartTime')!.millisecondsSinceEpoch,
      eventEndTime: DateUtil.getDateTime('$_formEndDate $_formEndTime')!.millisecondsSinceEpoch,
      eventLocation: _formLocationController.text.trim(),
      eventMapLink: _formRespectiveLinkController.text.trim(),
      eventPoster: _formPoster,
      result: () {
        ComFun.showToast(msg: 'event create success');
        Navigator.of(context).pop();
      },
    );
  }
}
