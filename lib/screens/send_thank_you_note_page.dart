import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mmc/utils/comfun.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SendThankYouNotePage extends StatefulWidget {
  const SendThankYouNotePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SendThankYouNotePageState();
  }
}

class _SendThankYouNotePageState extends State<SendThankYouNotePage> {
  final List<String> _upload = [];

  @override
  Widget build(BuildContext context) {
    Widget _scroll() {
      return SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 10, left: 26, right: 26, bottom: 30,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('I wish to send a thank you note to the friend who successfully refer a network to me', style: TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w500,),),
              const SizedBox(height: 30,),
              Text('Thank you note', style: TextStyle(fontSize: 14, color: Colors.black87),),
              const SizedBox(height: 6,),
              Text('You can write your own word here and he/she will know.', style: TextStyle(fontSize: 14, color: Colors.black45),),
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
                  // controller: _sendReferralWhyDetailController,
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.blueAccent,
                  maxLength: 100,
                  maxLines: 4,
                  style: const TextStyle(textBaseline: TextBaseline.alphabetic),
                  decoration: InputDecoration(
                    hintText: '输入答案',
                    hintStyle: const TextStyle(fontSize: 14, color: Colors.black38),
                    contentPadding: const EdgeInsets.only(top: 12,),
                    counterText: '',
                    isDense: true,
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Row(
                children: [
                  Text('Thank you note value', style: TextStyle(fontSize: 14, color: Colors.black87),),
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
                  // controller: _sendReferralWhyDetailController,
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.blueAccent,
                  style: const TextStyle(textBaseline: TextBaseline.alphabetic),
                  textAlign: TextAlign.end,
                  decoration: InputDecoration(
                    hintText: '输入答案',
                    hintStyle: const TextStyle(fontSize: 14, color: Colors.black38),
                    contentPadding: const EdgeInsets.only(top: 12,),
                    counterText: '',
                    isDense: true,
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Row(
                children: [
                  Text('Upload receipt', style: TextStyle(fontSize: 14, color: Colors.black87),),
                  const SizedBox(width: 4,),
                  Image.asset('assets/icon/form_required.png', width: 8, height: 8, color: Colors.redAccent, colorBlendMode: BlendMode.srcATop,),
                ],
              ),
              const SizedBox(height: 8,),
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _upload.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 18),
                    child: CachedNetworkImage(
                      height: MediaQuery.of(context).size.width * 10 / 16,
                      imageUrl: 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fup.enterdesk.com%2Fedpic%2Fcf%2F31%2Fed%2Fcf31edf65aa254cf0024ae95b363a382.jpg&refer=http%3A%2F%2Fup.enterdesk.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1638526975&t=196fd07be7d1dd48821b5fd9fdbc1a50',
                      placeholder: (BuildContext context, String url,) {
                        return Container(color: Colors.grey.shade300,);
                      },
                      fit: BoxFit.fill,
                      errorWidget: (BuildContext context, String url, dynamic error,) {
                        return Container(color: Colors.grey.shade300,);
                      },
                    ),
                  );
                },
              ),
              Center(
                child: GestureDetector(
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(Icons.add_circle_rounded, size: 30, color: Color(0xFF0544A6),),
                  ),
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                  },
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
