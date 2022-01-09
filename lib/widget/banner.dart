import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({ Key? key, required this.imageList, this.loopDuration = const Duration(seconds: 3), this.bg, this.width, this.height = 140, this.whRadio, this.topGradientHeight = 30, this.topGradientColor = const Color.fromRGBO(63, 68, 72, 1), this.padding, this.showIndicator = true, this.isNetImg = false, this.netImgLoadOrErr }): super(key: key);

  final List<String> imageList;

  /// 轮播的时间
  final Duration loopDuration;

  final Color? bg; // banner宽度
  final double? width; // banner宽度
  final double height; // banner高度
  final double? whRadio; // banner宽高比，设置后height参数无效
  final double topGradientHeight; // 顶部渐变区域高度
  final Color topGradientColor; // 顶部渐变区域颜色 -> 透明
  final EdgeInsetsGeometry? padding; // 边距
  final bool showIndicator; // 是否显示指示器

  final bool isNetImg; // 是否为网络图片
  final Widget? netImgLoadOrErr; // 网络图片加载中或加载失败的占位组件

  @override
  _BannerWidgetState createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  // 显示的轮播总页数
  int _total = 0;
  // 当前显示的页数
  int _current = 1;
  // 计时器
  late Timer _timer;
  late PageController _pageController;

  // 定义开始轮播的方法
  void startLoopFunction() {
    // 定时器
    try {
      stopLoopFunction();
    // ignore: empty_catches
    } catch (e) {}
    _timer = Timer.periodic(widget.loopDuration, (timer) {
      // 滑动到下一页
      _pageController.nextPage(
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 900,),
      );
    });
  }

  // 定义停止轮播的方法
  void stopLoopFunction() {
    _timer.cancel();
  }

  @override
  void initState() {
    super.initState();
    // 轮播图个数
    _total = widget.imageList.length;
    // 轮播控制器
    _pageController = PageController(
        initialPage: 0,
        keepPage: true,
        viewportFraction: 1
    );
    // 开始轮播
    startLoopFunction();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.bg ?? Colors.white,
      height: widget.whRadio != null ? (widget.width ?? MediaQuery.of(context).size.width) * widget.whRadio! : widget.height,
      width: widget.width ?? MediaQuery.of(context).size.width,
      child: GestureDetector(
        // 手指按下的回调
        onTapDown: (TapDownDetails details) {
          stopLoopFunction();
        },
        // 手指抬起的回调
        onTapUp: (TapUpDetails details) {
          startLoopFunction();
        },
        // 手指按下后滑动移出的回调
        onTapCancel: () {
          startLoopFunction();
        },
        child: buildStack(),
      ),
    );
  }

  Stack buildStack() {
    return Stack(
      children: [
        // 轮播层
        Positioned.fill(
          child: PageView.builder(
            // 控制器
            controller: _pageController,
            // 总页数
            itemCount: 10000,
            // 滑动时回调 value 当前显示的页面
            onPageChanged: (value) {
              setState(() {
                _current = value % widget.imageList.length + 1;
              });
            },
            itemBuilder: (BuildContext context, int index) {
              String image = widget.imageList[index % widget.imageList.length];
              if (widget.isNetImg) {
                return Padding(
                  padding: widget.padding ?? const EdgeInsets.all(0),
                  child: CachedNetworkImage(
                    imageUrl: image,
                    progressIndicatorBuilder:(BuildContext context, String url, DownloadProgress progress,){
                      return SizedBox(
                        width: 20, height: 20,
                        child: LottieBuilder.asset(
                          'assets/lottie/5039-planet.json',
                          fit: BoxFit.contain,
                        ),
                      );
                    },
                    fit: BoxFit.fill,
                    errorWidget: (BuildContext context, String url, dynamic error,) {
                      return widget.netImgLoadOrErr ?? Center(child: Text(AppLocalizations.of(context)!.imgLoadErrTip, style: const TextStyle(color: Colors.black54, fontSize: 13),),);
                    },
                  ),
                );
              } else {
                return Padding(
                  padding: widget.padding ?? const EdgeInsets.all(0),
                  child: Image.asset(image, fit: BoxFit.fill,),
                );
              }
            },
          ),
        ),
        // 顶部渐变层，优化过渡效果
        if (widget.topGradientHeight > 0) Positioned.fill(
          child: IgnorePointer(
            child: Container(
              width: double.infinity,
              height: widget.topGradientHeight,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0, 1],
                      colors: [widget.topGradientColor, widget.topGradientColor.withAlpha(0)]
                  )
              ),
            ),
          ),
        ),
        // 指示器层
        if (widget.showIndicator) Positioned(
          right: 14,
          bottom: 10,
          child: Padding(
            padding: widget.padding ?? const EdgeInsets.all(0),
            child: buildContainer(),
          ),
        ),
      ],
    );
  }

  Container buildContainer() {
    return Container(
      alignment: Alignment.center,
      width: 32,
      height: 15,
      decoration: BoxDecoration(
          color: Colors.grey[200]!.withOpacity(0.4),
          // 设置圆角
          borderRadius: const BorderRadius.all(Radius.circular(12))
      ),
      child: Text("$_current / $_total", textAlign: TextAlign.center, style: const TextStyle(fontSize: 10),),
    );
  }
}
