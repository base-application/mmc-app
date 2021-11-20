import 'package:flutter/material.dart';
import 'package:mmc/utils/comfun.dart';

class ThankYouNoteReceivedPage extends StatefulWidget {
  const ThankYouNoteReceivedPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ThankYouNoteReceivedPageState();
  }
}

class _ThankYouNoteReceivedPageState extends State<ThankYouNoteReceivedPage> {

  @override
  Widget build(BuildContext context) {
    Widget _scroll() {
      return SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 10, left: 26, right: 26, bottom: 30,),
          child: Column(
            children: [
              Text('Well Done! You play a big role in connecting our member in MMC network!', style: TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w500,),),
              const SizedBox(height: 30,),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 14,),
                    padding: const EdgeInsets.only(top: 10, bottom: 10, left: 14, right: 14,),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF043B94),
                          Color(0xFF095BD4),
                        ],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('You have done', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500,),),
                        Text('MYR 30,000 refer!!!', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500,),),
                        const SizedBox(height: 22,),
                        Text('Wednesday, 3 June 2021 | 10.00am', style: TextStyle(fontSize: 13, color: Colors.white.withAlpha(180), fontWeight: FontWeight.w300,),),
                        const SizedBox(height: 6,),
                        Text('From Cecelia Tay', style: TextStyle(fontSize: 13, color: Colors.white.withAlpha(180), fontWeight: FontWeight.w300,),),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
    }

    return PageContainer(
      title: 'Thank You Note Received',
      body: ScrollConfiguration(
        behavior: CusBehavior(),
        child: _scroll(),
      ),
    );
  }
}
