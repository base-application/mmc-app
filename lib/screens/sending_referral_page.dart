import 'package:flutter/material.dart';
import 'package:mmc/utils/comfun.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SendingReferralPage extends StatefulWidget {
  const SendingReferralPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SendingReferralPageState();
  }
}

class _SendingReferralPageState extends State<SendingReferralPage> {
  String? _formToGroup;
  String? _formToNetwork;
  final TextEditingController _sendReferralWhyDetailController = TextEditingController();
  final List<String> _formUpload = [];

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      title: AppLocalizations.of(context)!.pageSendReferralTitle,
      body: ScrollConfiguration(
        behavior: CusBehavior(),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 10, left: 26, right: 26, bottom: 30,),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 12, bottom: 12, left: 14, right: 14,),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFBB714),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text('Sending referral to someone who you feel can  help your friend or business partner.', style: TextStyle(fontSize: 16, color: Color(0xFF013B7B)),),
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
                            Text(AppLocalizations.of(context)!.sendReferralToLabel, style: TextStyle(fontSize: 15, color: Colors.black87.withAlpha(200),),),
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
                                  child: Text(_formToGroup ?? AppLocalizations.of(context)!.sendReferralFormItemHintChooseGroupIfAny, style: TextStyle(fontSize: 14, color: _formToGroup == null ? Colors.black38 : Colors.black87,), overflow: TextOverflow.ellipsis,),
                                ),
                                const Icon(Icons.arrow_drop_down_rounded, size: 22, color: Colors.black54,),
                              ],
                            ),
                          ),
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            // List<CountryCodeInfo> curr = countryCodeDataList.where((element) => element.phonecode == _registerCountryCode).toList();
                            // Pickers.showSinglePicker(context,
                            //   data: countryCodeDataList.map((e) => '${e.phonecode} (${e.nativeName})').toList(),
                            //   selectData: _registerCountryCode != null && curr.isNotEmpty ? '${curr[0].phonecode} (${curr[0].nativeName})' : '',
                            //   pickerStyle: PickerStyle(
                            //     showTitleBar: false,
                            //     backgroundColor: const Color(0xFF0859D2),
                            //     textColor: Colors.white,
                            //     pickerHeight: MediaQuery.of(context).size.height * 0.6,
                            //     menuHeight: MediaQuery.of(context).size.height * 0.6,
                            //   ),
                            //   overlapTabBar: true,
                            //   onChanged: (p, index) {
                            //     setState(() {
                            //       _registerCountryCode = countryCodeDataList[index].phonecode;
                            //     });
                            //   },
                            // );
                          },
                        ),
                      ],
                    ),),
                  ],
                ),
                const SizedBox(height: 12,),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                  child: Text(_formToNetwork ?? AppLocalizations.of(context)!.sendReferralFormItemHintChooseNetwork, style: TextStyle(fontSize: 14, color: _formToNetwork == null ? Colors.black38 : Colors.black87,), overflow: TextOverflow.ellipsis,),
                                ),
                                const Icon(Icons.arrow_drop_down_rounded, size: 22, color: Colors.black54,),
                              ],
                            ),
                          ),
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            // List<CountryCodeInfo> curr = countryCodeDataList.where((element) => element.phonecode == _registerCountryCode).toList();
                            // Pickers.showSinglePicker(context,
                            //   data: countryCodeDataList.map((e) => '${e.phonecode} (${e.nativeName})').toList(),
                            //   selectData: _registerCountryCode != null && curr.isNotEmpty ? '${curr[0].phonecode} (${curr[0].nativeName})' : '',
                            //   pickerStyle: PickerStyle(
                            //     showTitleBar: false,
                            //     backgroundColor: const Color(0xFF0859D2),
                            //     textColor: Colors.white,
                            //     pickerHeight: MediaQuery.of(context).size.height * 0.6,
                            //     menuHeight: MediaQuery.of(context).size.height * 0.6,
                            //   ),
                            //   overlapTabBar: true,
                            //   onChanged: (p, index) {
                            //     setState(() {
                            //       _registerCountryCode = countryCodeDataList[index].phonecode;
                            //     });
                            //   },
                            // );
                          },
                        ),
                      ],
                    ),),
                  ],
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
                            Text(AppLocalizations.of(context)!.sendReferralWhyLabel, style: TextStyle(fontSize: 15, color: Colors.black87.withAlpha(200),),),
                          ],
                        ),
                        const SizedBox(height: 8,),
                        Text(AppLocalizations.of(context)!.sendReferralWhyDetail, style: TextStyle(fontSize: 14, color: Colors.black87.withAlpha(140),),),
                        const SizedBox(height: 10,),
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
                            controller: _sendReferralWhyDetailController,
                            keyboardType: TextInputType.text,
                            maxLength: 100,
                            maxLines: 4,
                            cursorColor: Colors.blueAccent,
                            style: const TextStyle(textBaseline: TextBaseline.alphabetic),
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!.sendReferralWhyDetailHint,
                              hintStyle: const TextStyle(fontSize: 14, color: Colors.black38),
                              contentPadding: const EdgeInsets.only(top: 10,),
                              // counterText: '',
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
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLocalizations.of(context)!.sendReferralUploadNameCardLabel, style: TextStyle(fontSize: 15, color: Colors.black87.withAlpha(200),),),
                        const SizedBox(height: 8,),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 18,
                            mainAxisSpacing: 18,
                          ),
                          itemCount: _formUpload.length + 1,
                          itemBuilder: (BuildContext context, int index) {
                            if (index < _formUpload.length) {
                              String s = _formUpload[index];
                              return Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFDEE5ED),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              );
                            }
                            return GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFDEE5ED),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(Icons.add_circle, color: Color(0xFF0753C4), size: 26,),
                              ),
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                              },
                            );
                          },
                        ),
                      ],
                    ),),
                  ],
                ),
                const SizedBox(height: 40,),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 46,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(const Color(0xFFFBB714)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                      elevation: MaterialStateProperty.all(0),
                    ),
                    child: Text(AppLocalizations.of(context)!.sendReferralSubmitBtn, style: const TextStyle(color: Color(0xFF013B7B), fontWeight: FontWeight.w500,),),
                    onPressed: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
