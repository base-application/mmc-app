import 'package:flutter/material.dart';
import 'package:mmc/utils/comfun.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyInboxPage extends StatefulWidget {
  const MyInboxPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyInboxPageState();
  }
}

class _MyInboxPageState extends State<MyInboxPage> {
  bool _isEdit = false;

  @override
  Widget build(BuildContext context) {
    Widget _scroll() {
      return SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              padding: const EdgeInsets.only(top: 8,),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 8,
              itemBuilder: (ctx, index) {
                return Container(
                  padding: const EdgeInsets.only(top: 8, left: 12, right: 12, bottom: 8,),
                  child: Row(
                    children: [
                      if (_isEdit) Container(
                        width: 27,
                        height: 27,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(width: 1.4, color: const Color(0xFF095DD8),),
                        ),
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: const Color(0xFF095DD8),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      if (_isEdit) const SizedBox(width: 8,),
                      Expanded(child: Container(
                        height: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xFF043B94),
                              Color(0xFF095BD4),
                            ],
                          ),
                        ),
                      )),
                    ],
                  ),
                );
              },
            ),
            if (_isEdit) const SizedBox(height: 30,),
            if (_isEdit) Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              margin: const EdgeInsets.only(left: 20, right: 20,),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(const Color(0xFFFBB714)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                  elevation: MaterialStateProperty.all(0),
                ),
                child: Text(AppLocalizations.of(context)!.delete, style: const TextStyle(color: Color(0xFF013B7B), fontSize: 16, fontWeight: FontWeight.bold,),),
                onPressed: () async {
                },
              ),
            ),
            const SizedBox(height: 60,),
          ],
        ),
      );
    }

    return PageContainer(
      title: 'My Inbox',
      body: ScrollConfiguration(
        behavior: CusBehavior(),
        child: _scroll(),
      ),
      rightBtn: ({ int? homeIndex }) {
        return {
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: _isEdit ? Padding(
              padding: const EdgeInsets.all(10),
              child: Text('Select All', style: TextStyle(fontSize: 12, color: Colors.grey.shade700, fontWeight: FontWeight.w500,),),
            ) : const Icon(Icons.create_rounded, size: 22,),
          ): (ctx) {
            if (!_isEdit) {
              _isEdit = true;
            } else {
            }
            setState(() {});
          },
        };
      },
    );
  }
}
