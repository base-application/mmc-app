import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mmc/utils/comfun.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mmc/utils/http_request.dart';

class SendThankYouNotePage extends StatefulWidget {
  final int referralId;
  const SendThankYouNotePage({Key? key, required this.referralId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SendThankYouNotePageState();
  }
}

class _SendThankYouNotePageState extends State<SendThankYouNotePage> {
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget _scroll() {
      return SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 10, left: 26, right: 26, bottom: 30,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('I wish to send a thank you note to the friend who successfully refer a network to me', style: TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w500,),),
              const SizedBox(height: 30,),
              const  Text('Thank you note', style: TextStyle(fontSize: 14, color: Colors.black87),),
              const SizedBox(height: 6,),
              const  Text('You can write your own word here and he/she will know.', style: TextStyle(fontSize: 14, color: Colors.black45),),
              const SizedBox(height: 8,),
              TextFormField(
                controller: _noteController,
                keyboardType: TextInputType.text,
                cursorColor: Colors.blueAccent,
                maxLength: 100,
                maxLines: 4,
                style: const TextStyle(textBaseline: TextBaseline.alphabetic),
                decoration: InputDecoration(
                  fillColor:Colors.white,
                  filled: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  label: Container(
                    alignment: Alignment.centerLeft,
                    child:  const Text("输入答案",style: TextStyle(fontSize: 14, color: Colors.black38),),
                  ),
                  contentPadding:  const EdgeInsets.only(left: 16,top: 10,bottom: 10,right: 16),
                  counterText: '',
                  isDense: true,
                  enabledBorder:  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(width: 0.6, color: Colors.grey.shade300,),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(width: 0.6, color: Colors.grey.shade300,),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Row(
                children: [
                  const  Text('Thank you note value', style: TextStyle(fontSize: 14, color: Colors.black87),),
                  const SizedBox(width: 4,),
                  Image.asset('assets/icon/form_required.png', width: 8, height: 8, color: Colors.redAccent, colorBlendMode: BlendMode.srcATop,),
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
                  controller: _valueController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  cursorColor: Colors.blueAccent,
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(fontSize: 14, color: Colors.black38),
                    contentPadding: EdgeInsets.only(top: 12,),
                    counterText: '',
                    isDense: true,
                    suffixIconConstraints: BoxConstraints(
                      maxWidth: 40,
                    ),
                    suffixIcon:Center(
                      child:  Text("MYR"),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 30,),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 46,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(const Color(0xFFFBB714)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    elevation: MaterialStateProperty.all(0),
                  ),
                  child: Text(AppLocalizations.of(context)!.btnSend, style: const TextStyle(color: Color(0xFF013B7B), fontSize: 16, fontWeight: FontWeight.bold,),),
                  onPressed: () async {
                    if(_valueController.text.isEmpty || _noteController.text.isEmpty){
                      ComFun.showToast(msg: "请输入");
                      return;
                    }
                    ComFun.confirm(context, () => thank(context,note: _noteController.text, value: _valueController.text,referralId: widget.referralId,result: (o) {
                      AutoRouter.of(context).pop(true);
                    }, ), AppLocalizations.of(context)!.confirmSend);
                  },
                ),
              ),
              const SizedBox(height: 60,),
            ],
          ),
        ),
      );
    }

    return PageContainer(
      title: 'Send Thank You Note',
      body: ScrollConfiguration(
        behavior: CusBehavior(),
        child: _scroll(),
      ),
    );
  }
}
