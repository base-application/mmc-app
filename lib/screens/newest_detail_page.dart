import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mmc/bean/newest_item_info_entity.dart';
import 'package:mmc/utils/comfun.dart';
import 'package:mmc/utils/comm_widget.dart';
import 'package:chewie/chewie.dart';
import 'package:mmc/utils/http_request.dart';
import 'package:video_player/video_player.dart';

class NewestDetailPage extends StatefulWidget {
  const NewestDetailPage({Key? key, required this.info}) : super(key: key);

  final NewestItemInfoEntity info;

  @override
  State<StatefulWidget> createState() {
    return _NewestDetailPageState();
  }
}

class _NewestDetailPageState extends State<NewestDetailPage> {
  VideoPlayerController? _controller;

  int _imgBannerIndex = 0;
  ChewieController? chewieController;
  bool isPlay = false;
  @override
  void initState() {
    newestRead(context,widget.info.storyId);
    super.initState();
    if (widget.info.link != null) {
      _controller = VideoPlayerController.network(widget.info.link!,videoPlayerOptions: VideoPlayerOptions());
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
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget _mainBody() {
      return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (widget.info.link != null) Positioned(
              child: GestureDetector(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.55,
                  color: Colors.black87,
                  child: Stack(
                    children: [
                      Center(
                        child: _controller!.value.isInitialized ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AspectRatio(
                              aspectRatio: _controller!.value.aspectRatio,
                              child: Chewie(controller: chewieController!,),
                            ),
                          ],
                        ): Container(),
                      )
                    ],
                  ),
                ),
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  setState(() {
                    _controller!.value.isPlaying
                        ? _controller!.pause()
                        : _controller!.play();
                  });
                },
              ),
              top: 0,
            ),
            if (widget.info.link == null) Positioned(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.55,
                color: Colors.black87,
                child: ScrollConfiguration(
                  behavior: CusBehavior(),
                  child: PageView.builder(
                    itemCount: widget.info.poster.length,
                    itemBuilder: (ctx, index) {
                      NewestItemInfoPoster posterItem = widget.info.poster[index];
                      return netImgWrap(context,
                        url: posterItem.url,
                        fit: BoxFit.fitWidth,
                        errorWidget: Container(),
                      );
                    },
                    onPageChanged: (page) {
                      setState(() {
                        _imgBannerIndex = page;
                      });
                    },
                  ),
                ),
              ),
              top: 0,
            ),
            Positioned(child: GestureDetector(
              child: Container(
                width: 46,
                height: 46,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(46),
                  color: Colors.black87.withAlpha(60),
                ),
                child: const Icon(Icons.arrow_back_ios_rounded, size: 26, color: Colors.white,),
              ),
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.of(context).pop();
              },
            ), top: MediaQuery.of(context).padding.top + 10, left: 20,),
            Positioned(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16),),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      blurRadius: 4,
                      color: Colors.black87.withAlpha(10),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        Builder(builder: (ctx) {
                          List<Widget> _indicators = [];
                          widget.info.poster.asMap().forEach((index, value) {
                            _indicators.add(Container(
                              width: 6,
                              height: 6,
                              margin: const EdgeInsets.only(left: 3, right: 3, top: 10,),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: index == _imgBannerIndex ? Colors.indigo : Colors.grey.shade400,
                              ),
                            ));
                          });
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: _indicators,
                          );
                        }),
                      ],
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    const SizedBox(height: 30,),
                    Padding(
                      padding: const EdgeInsets.only(left: 18, right: 18,),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.info.title, style: const TextStyle(fontSize: 22, color: Colors.black87, fontWeight: FontWeight.bold,),),
                          const SizedBox(height: 12,),
                          Text(DateFormat('EEEE, d MMMM yyyy | h:mm a', Localizations.localeOf(context).languageCode == 'en' ? 'en_US' : 'zh_CN').format(DateTime.fromMillisecondsSinceEpoch(widget.info.pushTime)), style: const TextStyle(fontSize: 15, color: Colors.black54, fontWeight: FontWeight.w400,),),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30,),
                    Container(
                      height: 6,
                      color: Colors.grey.shade200,
                    ),
                    const SizedBox(height: 30,),
                    Expanded(child: Padding(
                      padding: EdgeInsets.only(left: 18, right: 18, bottom: MediaQuery.of(context).padding.bottom,),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Text('Information', style: TextStyle(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.bold,),),
                          const SizedBox(height: 8,),
                          Expanded(child: ScrollConfiguration(
                            behavior: CusBehavior(),
                            child: SingleChildScrollView(
                              child: Text(widget.info.description, style: const TextStyle(fontSize: 15, color: Colors.black54, fontWeight: FontWeight.w400,),),
                            ),
                          )),
                        ],
                      ),
                    ),),
                  ],
                ),
              ),
              bottom: 0,
            ),
          ],
        ),
      );
    }

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaleFactor: ComFun.getTextScaleFactor(),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFF7F7F7),
        body: _mainBody(),
      ),
    );
  }
}
