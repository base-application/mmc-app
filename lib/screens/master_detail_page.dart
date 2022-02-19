
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:mmc/bean/master_class_entity.dart';
import 'package:mmc/bean/master_class_videos_entity.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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
  bool isInit = false;

  MasterClassVideosEntity? currVideo;
  @override
  void initState() {
    _initVideos( widget.masterClassEntity.videos!.first);
    super.initState();
  }

  _initVideos(MasterClassVideosEntity video){
    chewieController?.pause();
    isInit = false;
    currVideo = video;
    setState(() {});
    _controller = VideoPlayerController.network(currVideo!.url!,videoPlayerOptions: VideoPlayerOptions());
    chewieController = ChewieController(
      videoPlayerController: _controller!,
      autoPlay: true,
      looping: true,
      deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]
    );
    _controller!.addListener(_listenerInit);
  }

  _listenerInit(){
    if(!isInit && _controller!.value.isInitialized){
      isInit = true;
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller!.removeListener(_listenerInit);
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
             child: isInit ? AspectRatio(
               aspectRatio:  _controller!.value.aspectRatio,
               child: Chewie(controller: chewieController!,),
             ) :  AspectRatio(
               aspectRatio: 9/5.5,
               child:Container(
                 alignment: Alignment.center,
                 color: Colors.black,
                 child: SizedBox(
                   width: 40,
                   height: 40,
                   child:  LottieBuilder.asset(
                     'assets/lottie/5039-planet.json',
                     fit: BoxFit.cover
                   ),
                 ),
               ),
             ),
           ),
          Padding(
            padding: const EdgeInsets.only(left: 16,top: 25),
            child: Text(widget.masterClassEntity.title??"",style:const TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16,top: 12),
            child: Row(
              children: [
                const Icon(Icons.video_settings,size: 14,color: Color(0xff999999),),
                const SizedBox(width: 6,),
                Text(widget.masterClassEntity.videos!.length.toString(),style: const TextStyle(color: Color(0xff999999),fontSize: 12),),
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
                               GestureDetector(
                                 onTap: (){
                                   _initVideos(e);
                                 },
                                 child: Container(
                                   margin: const EdgeInsets.only(left: 12,top: 20),
                                   padding: const EdgeInsets.all(12),
                                   alignment: Alignment.center,
                                   decoration: BoxDecoration(
                                       border: Border.all(color: currVideo?.url == e.url  ?  const Color(0xffFBB714) : const Color(0xff999999)),
                                       borderRadius: BorderRadius.circular(18)
                                   ),
                                   child: Text(e.title!,style: TextStyle(color:currVideo?.url == e.url  ?  const Color(0xffFBB714) : const Color(0xff999999),fontSize: 12),),
                                 ),
                               )
                           ).toList(),
                         ),
                       )
                     ],
                   ),
                   Padding(
                     padding: const EdgeInsets.all(16),
                     child: ClassDescription(desc: widget.masterClassEntity.introduction!,),
                   )
                 ],
             )
         )
        ],
      ) ,
      bottomNavigationBar: widget.masterClassEntity.concat != null ?  SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16,right: 16),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(const Color(0xFFFBB714)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              elevation: MaterialStateProperty.all(0),
            ),
            onPressed: () {
              launch(widget.masterClassEntity.concat!);
            },
            child: Text(AppLocalizations.of(context)!.contactUsNow),

          ),
        ),
      ) : null,
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
        SizedBox(height: 5,),
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


