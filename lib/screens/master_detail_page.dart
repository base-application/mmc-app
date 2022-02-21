
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:mmc/bean/course_detail_entity.dart';
import 'package:mmc/screens/coming_soon_page.dart';
import 'package:mmc/utils/comfun.dart';
import 'package:mmc/utils/comm_widget.dart';
import 'package:mmc/utils/http_request.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart' hide File;
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';


class MasterDetailPage extends StatefulWidget {
  final int classId;
  const MasterDetailPage({Key? key, required this.classId}) : super(key: key);

  @override
  _MasterDetailPageState createState() => _MasterDetailPageState();
}

class _MasterDetailPageState extends State<MasterDetailPage> {
  VideoPlayerController? _controller;
  ChewieController? chewieController;
  final PageController _pageController = PageController();
  int pageIndex = 0;
  bool isInit = false;

  CourseDetailVideos? currVideo;

  late Future<CourseDetailEntity> _future;


  @override
  void initState() {
    _future = masterClassDetail(context,widget.classId);
    _future.then((value) {
      if(value.videos!=null && value.videos!.isNotEmpty){
        _initVideos(value.videos!.first);
      }
    });
    super.initState();
  }

  _initVideos(CourseDetailVideos video){
    chewieController?.pause();
    isInit = false;
    currVideo = video;
    setState(() {});
    _controller = VideoPlayerController.network(currVideo!.videoUrl!,videoPlayerOptions: VideoPlayerOptions());
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
    _controller?.removeListener(_listenerInit);
    _controller?.dispose();
    chewieController?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (BuildContext context, AsyncSnapshot<CourseDetailEntity> snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return LottieBuilder.asset(
            'assets/lottie/5039-planet.json',
            fit: BoxFit.contain,
          );
        }
        if(snapshot.hasError){
          return Center(child: Text(snapshot.error.toString()),);
        }
        if(snapshot.hasData){
          if(snapshot.data?.videos == null || snapshot.data!.videos!.isEmpty){
            return ComingSoonPage(title: snapshot.data!.categoryName??"");
          }
          List<PageEntity> _pages = [];
          _pages.add(
              PageEntity("Class",
                  Column(
                    children: [
                      SizedBox(
                        height: 70,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: snapshot.data!.videos!.map((e) =>
                              GestureDetector(
                                onTap: (){
                                  _initVideos(e);
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(left: 12,top: 20),
                                  padding: const EdgeInsets.all(12),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: currVideo?.videoUrl == e.videoUrl  ?  const Color(0xffFBB714) : const Color(0xff999999)),
                                      borderRadius: BorderRadius.circular(18)
                                  ),
                                  child: Text(e.videoTitle??"",style: TextStyle(color:currVideo?.videoUrl == e.videoUrl  ?  const Color(0xffFBB714) : const Color(0xff999999),fontSize: 12),),
                                ),
                              )
                          ).toList(),
                        ),
                      )
                    ],
                  ))
          );
          if((snapshot.data!.schedules?.length??0) > 0){
            _pages.add(
                PageEntity(
                    "Schedule",
                    ListView(
                      padding: const EdgeInsets.all(16),
                      children: snapshot.data!.schedules!.map((e) =>
                          Container(
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: const Color(0xffF4F5F9),
                              borderRadius: BorderRadius.circular(12)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(DateFormat().format(DateTime.fromMillisecondsSinceEpoch(e.scheduleTime!)),style: const TextStyle(color: Color(0xffFBB714),fontSize: 12),),
                                    Text(e.scheduleTitle??"",style: const TextStyle(color: Color(0xff000000)),),
                                  ],
                                ),
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(const Color(0xFFFBB714)),
                                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                                      elevation: MaterialStateProperty.all(0),
                                    ),
                                    onPressed: (){
                                      launch(e.scheduleUrl!);
                                    },
                                    child: const Text("Join",style: TextStyle(color: Color(0xff013B7B),fontWeight: FontWeight.bold),)
                                )
                              ],
                            ),
                          )
                      ).toList(),
                    )
                )
            );
          }
          _pages.add(PageEntity("Description",   Padding(
            padding: const EdgeInsets.all(16),
            child: ClassDescription(desc: snapshot.data!.courseDescription!,),
          )));
          if((snapshot.data!.files?.length??0) > 0){
            _pages.add(
                PageEntity("PDF",
                    ListView(
                      padding: const EdgeInsets.all(16),
                      children: snapshot.data!.files!.map((e) =>
                         Container(
                           margin: const EdgeInsets.only(bottom: 12),
                           padding: EdgeInsets.all(12),
                           decoration: BoxDecoration(
                             color: const Color(0xffF4F5F9),
                             borderRadius: BorderRadius.circular(16)
                           ),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text(e.fileTitle??"",style: const TextStyle(color: Color(0xffFBB714)),),
                               ElevatedButton(
                                   style: ButtonStyle(
                                     backgroundColor: MaterialStateProperty.all(const Color(0xFFFBB714)),
                                     shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                                     elevation: MaterialStateProperty.all(0),
                                   ),
                                   onPressed: (){
                                     _downloadImage(e.fileUrl!,e.fileTitle);
                                   },
                                   child: const Text("Download",style: TextStyle(color: Color(0xff013B7B),fontWeight: FontWeight.bold),)
                               )
                             ],
                           ),
                         )
                      ).toList(),
                    )
                )
            );
          }
         return  Scaffold(
            appBar: AppBar(
              title: Text(snapshot.data!.courseName??""),
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
                  child: Text(snapshot.data!.courseName??"",style:const TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16,top: 12),
                  child: Row(
                    children: [
                      const Icon(Icons.video_settings,size: 14,color: Color(0xff999999),),
                      const SizedBox(width: 6,),
                      Text(snapshot.data!.videos!.length.toString(),style: const TextStyle(color: Color(0xff999999),fontSize: 12),),
                    ],
                  ),
                ),
                const SizedBox(height: 12,),
                Row(
                  children: _pages.asMap().map((key, value) => MapEntry(key, GestureDetector(
                    onTap: (){
                      _pageController.animateToPage(key, duration: const Duration(milliseconds: 100), curve: Curves.easeInOutQuad);
                    },
                    child: TabIndicator(title: value.title,active: pageIndex == key ,),
                  ))).values.toList(),
                ),
                Expanded(
                    child:  PageView(
                      controller: _pageController,
                      onPageChanged: (i){
                        pageIndex = i;
                        setState(() {});
                      },
                      children: _pages.map((e) => e.page).toList(),
                    )
                )
              ],
            ) ,
            bottomNavigationBar: snapshot.data!.concatUs != null ?  SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 16,right: 16),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(const Color(0xFFFBB714)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    elevation: MaterialStateProperty.all(0),
                  ),
                  onPressed: () {
                    launch(snapshot.data!.concatUs!);
                  },
                  child: Text(AppLocalizations.of(context)!.contactUsNow),

                ),
              ),
            ) : null,
          );
        }
        return stateNoDate();
    },);
  }

  Future<void> _downloadImage(url,name) async {
    var tempDir = await getTemporaryDirectory();
    String fullPath = tempDir.path + name + ".pdf";
    try {
      Response response = await Dio().get(
        url,
        // onReceiveProgress: showDownloadProgress,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
      );
      File file = File(fullPath);
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();
      final pdfController = PdfController(
        document: PdfDocument.openFile(fullPath),
      );
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            elevation: 0,
            backgroundColor: const Color(0xFFFBB714),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Icon(CupertinoIcons.left_chevron),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
          body: PdfView(
            controller: pdfController,
          ),
        );}));
    } catch (e) {
      ComFun.showToast(msg: e.toString());
    }
  }
}

class TabIndicator extends StatelessWidget {
  final String title;
  final bool active;
  final double? width;
  const TabIndicator({Key? key, required this.title, required this.active,this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        const SizedBox(height: 5,),
        Container(
          margin: const EdgeInsets.only(left: 5,right: 5),
          padding: const EdgeInsets.only(left: 5,right: 5),
          decoration: BoxDecoration(
              color: active ? const Color(0xff013B7B) :  Colors.transparent,
              borderRadius: BorderRadius.circular(8)
          ),
          height: 4,
          child: Text(title,style: const TextStyle(color: Colors.transparent),),
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



class PageEntity{
  late String title;
  late Widget page;
  PageEntity(this.title, this.page);
}
