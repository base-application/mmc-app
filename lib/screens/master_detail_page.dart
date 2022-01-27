import 'package:chewie/chewie.dart';
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

  @override
  void initState() {
    _controller = VideoPlayerController.network("https://vod-progressive.akamaized.net/exp=1643220430~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F2929%2F26%2F664645329%2F3057435736.mp4~hmac=4486542841b3d9489525a596c50bf95ea7aee57827c40caf84069b8179aab480/vimeo-prod-skyfire-std-us/01/2929/26/664645329/3057435736.mp4?filename=Final.mp4.mp4",videoPlayerOptions: VideoPlayerOptions());
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.masterClassEntity.title!),
      ),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: _controller!.value.aspectRatio,
            child: Chewie(controller: chewieController!,),
          )
        ],
      ) ,
    );
  }
}
