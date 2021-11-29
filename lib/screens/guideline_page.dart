import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mmc/bean/guide_line_entity.dart';
import 'package:mmc/router/router.gr.dart';
import 'package:mmc/utils/comfun.dart';
import 'package:mmc/utils/http_request.dart';

class GuidelinePage extends StatefulWidget {
  const GuidelinePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GuidelinePageState();
  }
}

class _GuidelinePageState extends State<GuidelinePage> {
  late Future<List<GuideLineEntity>> _future;
  @override
  void initState() {
    _future = guideLine(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: const Text("Guideline"),
      ),
      body: FutureBuilder(
        future: _future,
        builder: (BuildContext context, AsyncSnapshot<List<GuideLineEntity>> snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: (){
                    AutoRouter.of(context).push(GuidelineDetailRoute(guideLineEntity: snapshot.data![index]));
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 16,right: 16,top: 20,bottom: 20),
                    margin: const EdgeInsets.only(left: 16,right: 16,top: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF043B94),
                          Color(0xFF0D66E5),
                        ],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(snapshot.data![index].guideLineTitle,style: const TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                        const Icon(CupertinoIcons.right_chevron,color: Colors.white,)
                      ],
                    ),
                  ),
                );
              },
            );
          }else{
            return Center(
                child: Image.asset('assets/image/no_data.png', height: 140,)
            );
          }
        },
      ),
    );
  }
}
