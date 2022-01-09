import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mmc/router/auth_guard.dart';
import 'package:provider/provider.dart';

import 'comfun.dart';

/// 404 状态页
Widget state404() {
  return Center(
    child: Column(
      children: [
        Image.asset('assets/image/404.png', height: 140,),
        Text('404', style: TextStyle(fontSize: 13, color: Colors.grey.shade400),),
      ],
    ),
  );
}

/// 网络问题 状态页
Widget stateNetWorkErr() {
  return Center(
    child: Column(
      children: [
        Image.asset('assets/image/err_net.png', height: 140,),
        Text('Sorry, seem like you are disconnect with wifi...', style: TextStyle(fontSize: 13, color: Colors.grey.shade400),),
      ],
    ),
  );
}

/// 空数据 状态页
Widget stateNoDate({ bool inRef = false }) {
  if (inRef) {
    return ScrollConfiguration(
      behavior: CusBehavior(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          width: double.infinity,
          height: 400,
          padding: const EdgeInsets.only(top: 120),
          child: Column(
            children: [
              Image.asset('assets/image/no_data.png', height: 140,),
              Text('No data now', style: TextStyle(fontSize: 13, color: Colors.grey.shade400),),
            ],
          ),
        ),
      ),
    );
  }
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/image/no_data.png', height: 140,),
        Text('No data now', style: TextStyle(fontSize: 13, color: Colors.grey.shade400),),
      ],
    ),
  );
}

Widget netImgWrap(BuildContext context, { String? url, String? assets, double? width, double? height, double? radius, BoxFit? fit, required Widget errorWidget }) {
  if (assets != null) {
    if (radius != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Image.asset(assets, width: width, height: height,),
      );
    }
    return Image.asset(assets, width: width, height: height,);
  }
  if (url == null || url.trim() == '') {
    if (radius != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: errorWidget,
      );
    }
    return errorWidget;
  }
  Widget _img = CachedNetworkImage(
    imageUrl: '${context.read<SystemSetService>().baseUrl}$url',
    progressIndicatorBuilder:(BuildContext context, String url, DownloadProgress progress,){
      return SizedBox(
        width: 20, height: 20,
        child: LottieBuilder.asset(
          'assets/lottie/5039-planet.json',
          fit: BoxFit.contain,
        ),
      );
    },
    width: width,
    height: height,
    fit: fit ?? BoxFit.fill,
    errorWidget: (BuildContext context, String url, dynamic error,) {
      return errorWidget;
    },
  );
  if (radius != null) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: _img,
    );
  }
  return _img;
}
