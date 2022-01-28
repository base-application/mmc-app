
import 'dart:ui';

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mmc/bean/master_class_entity.dart';
import 'package:video_player/video_player.dart';

class MasterDetailPage extends StatefulWidget {
  final MasterClassEntity masterClassEntity;
  const MasterDetailPage({Key? key, required this.masterClassEntity}) : super(key: key);

  @override
  _MasterDetailPageState createState() => _MasterDetailPageState();
}

class _MasterDetailPageState extends State<MasterDetailPage> {
  VideoPlayerController? _controller;
  ChewieController? chewieController;
  final PageController _pageController = PageController();
  int pageIndex = 0;

  @override
  void initState() {
    _controller = VideoPlayerController.network(widget.masterClassEntity.videos![0].url!,videoPlayerOptions: VideoPlayerOptions());
    chewieController = ChewieController(
      videoPlayerController: _controller!,
      autoPlay: true,
      looping: true,
    );
    _controller!.addListener(() {
      if(_controller!.value.isInitialized){
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    chewieController?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.masterClassEntity.title!),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Container(
             width: MediaQuery.of(context).size.width,
             color: Colors.black,
             child:  AspectRatio(
               aspectRatio: 9/5.5,
               child: Chewie(controller: chewieController!,),
             ),
           ),
          Padding(
            padding: const EdgeInsets.only(left: 16,top: 25),
            child: Text(widget.masterClassEntity.title??"",style:const TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              children: [
                const Icon(Icons.video_settings,size: 14,color: Color(0xff999999),),
                const SizedBox(width: 6,),
                Text(widget.masterClassEntity.videos!.length.toString(),style: const TextStyle(color: Color(0xff999999),fontSize: 12),)
              ],
            ),
          ),
          const SizedBox(height: 12,),
          Row(
            children: [
              GestureDetector(
                onTap: (){
                  _pageController.animateToPage(0, duration: const Duration(milliseconds: 100), curve: Curves.easeInOutQuad);
                },
                child: TabIndicator(title: "Class",active: pageIndex == 0 ,width: 60,),
              ),
              GestureDetector(
                onTap: (){
                  _pageController.animateToPage(1, duration: const Duration(milliseconds: 100), curve: Curves.easeInOutQuad);
                },
                child: TabIndicator(title: "Description",active: pageIndex == 1,width: 100,),
              ),
            ],
          ),
         Expanded(
             child:  PageView(
                 controller: _pageController,
                 onPageChanged: (i){
                   pageIndex = i;
                   setState(() {});
                 },
                 children: [
                   Column(
                     children: [
                       SizedBox(
                         height: 70,
                         child: ListView(
                           scrollDirection: Axis.horizontal,
                           children: widget.masterClassEntity.videos!.map((e) =>
                               Container(
                                 margin: EdgeInsets.only(left: 12,top: 20),
                                 padding: EdgeInsets.all(12),
                                 alignment: Alignment.center,
                                 decoration: BoxDecoration(
                                     border: Border.all(color: Color(0xffFBB714)),
                                   borderRadius: BorderRadius.circular(18)
                                 ),
                                 child: Text(e.title!,style: TextStyle(color: Color(0xffFBB714),fontSize: 12),),
                               )
                           ).toList(),
                         ),
                       )
                     ],
                   ),
                   Padding(
                     padding: EdgeInsets.all(16),
                     child: ClassDescription(desc: widget.masterClassEntity.introduction!,),
                   )
                 ],
             )
         )
        ],
      ) ,
    );
  }
}

class TabIndicator extends StatelessWidget {
  final String title;
  final bool active;
  final double width;
  const TabIndicator({Key? key, required this.title, required this.active, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        Container(
          margin: EdgeInsets.only(left: 5,right: 5),
          decoration: BoxDecoration(
              color: active ? const Color(0xff013B7B) :  Colors.white,
              borderRadius: BorderRadius.circular(8)
          ),
          height: 4,
          width: width,
        )
      ],
    );
  }
}


class ClassDescription extends StatelessWidget {
  final String desc;
  const ClassDescription({Key? key, required this.desc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(desc);
  }
}


