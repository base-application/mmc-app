import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_log/interceptor/dio_log_interceptor.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mmc/router/auth_guard.dart';
import 'package:mmc/router/router.gr.dart';
import 'package:provider/provider.dart';


import 'comfun.dart';

/// dio 构造器
class DioHttpUtil {
  factory DioHttpUtil(BuildContext context) => _sharedInstance(context);

  static DioHttpUtil? _instance;

  DioHttpUtil._(BuildContext context) {
    init(context);
  }

  static DioHttpUtil _sharedInstance(BuildContext context) {
    _instance ??= DioHttpUtil._(context);
    return _instance!;
  }

  Dio? _dio;

  // 初始化请求配置
  init(BuildContext context) {
    if (_dio == null) {
      _dio = Dio();

      (_dio!.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
        client.badCertificateCallback = (X509Certificate cert, String host, int port) {
          return true;
        };
      };

      LogUtil.init(isDebug: const bool.fromEnvironment('dart.vm.product') == false);
      _dio!.options.baseUrl = context.read<SystemSetService>().baseUrl;
      _dio!.options.connectTimeout = 60000;
      _dio!.options.receiveTimeout = 20000;
      _dio!.options.sendTimeout = 20000;
      _dio!.options.contentType = 'application/json';
      if (const bool.fromEnvironment('dart.vm.product') == false) _dio!.interceptors.add(LogInterceptor(responseBody: true));
      _dio!.interceptors.add(DioLogInterceptor());
      _dio!.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler,) {
          options.queryParameters.removeWhere((key, value) => value == null);
          handler.next(options);
        },
        onResponse: (Response e, ResponseInterceptorHandler handler) {
          handler.next(e);
        },
        onError: (DioError e, ErrorInterceptorHandler handler) {
          dismissLoading();
          if (e.response?.statusCode == 401) {
            // 无访问权限 or token过期失效
            debugPrint('数据请求状态为401');
            if(AutoRouter.of(ComFun.navigatorKey.currentState!.context).current.name !="SignInRoute"){
              AutoRouter.of(ComFun.navigatorKey.currentState!.context).push(const SignInRoute());
            }
          }
          if(e.response?.data.containsKey("message")){
            ComFun.showToast(msg: e.response?.data['message'], err: true);
            handler.next(e);
            return;
          }
          else {
            if (!quietRequest.contains(e.requestOptions.path)) {
              switch (e.type) {
                case DioErrorType.connectTimeout:
                  ComFun.showToast(msg: '连接超时，请检查网络连接', err: true);
                  break;
                case DioErrorType.other:
                  if (e.error is SocketException) {
                    if (e.message.contains('Connection refused')) {
                      ComFun.showToast(msg: '服务器拒绝了您的访问请求', err: true);
                    } else {
                      ComFun.showToast(msg: '当前网络连接不可用', err: true);
                    }
                  } else if (e.error is HttpException) {
                    ComFun.showToast(msg: '您的网络出现了问题，请求失败', err: true);
                  } else {
                    ComFun.showToast(msg: e.message.isNotEmpty ? e.message : '请求出现未知异常', err: true);
                  }
                  break;
                case DioErrorType.sendTimeout:
                  ComFun.showToast(msg: '连接超时', err: true);
                  break;
                case DioErrorType.receiveTimeout:
                  ComFun.showToast(msg: '连接超时', err: true);
                  break;
                case DioErrorType.response:
                  ComFun.showToast(msg: '请求出错，错误码${e.response?.statusCode}', err: true);
                  break;
                case DioErrorType.cancel:
                  ComFun.showToast(msg: '请求被取消', err: true);
                  break;
                default:
                  ComFun.showToast(msg: '请求出现未知错误', err: true);
                  break;
              }
            }
          }
          handler.next(e);
        }
      ));
    }
  }
}

void dismissLoading() {
  if (EasyLoading.isShow) EasyLoading.dismiss(animation: true);
}

/// get 请求
Future<BaseBean?> httpGet(BuildContext context, { required String url, Map<String, dynamic>? queryParameters, bool silence = false, String loadingTip ="", bool endHideLoading = true, bool successButErrShowTip = true, bool isShop = false }) async {
  if (!silence) EasyLoading.show();

  await requestAuthHead(context, DioHttpUtil(context)._dio!.options, url);

  var response = await DioHttpUtil(context)._dio!.get(url, queryParameters: queryParameters);

  if (response.statusCode == HttpStatus.ok) {
    try {
      var result = BaseBean.fromJson(response.data!);
      if (result.code == 200) {
        if (endHideLoading && !silence) dismissLoading();
        return result;
      } else {
        if (!silence) dismissLoading();
        if (!quietRequest.contains(response.requestOptions.path) && successButErrShowTip) ComFun.showToast(msg: result.message, err: true);
        return Future.error('error code ${result.code}');
      }
    } catch (e) {
      if (!silence) dismissLoading();
      if (!quietRequest.contains(response.requestOptions.path)) ComFun.showToast(msg: '请求出错，请稍后重试', err: true);
      return Future.error('error code $e');
    }
  }

  if (!silence) dismissLoading();
  return Future.error('error code ${response.statusCode}');
}

/// post 请求
Future<BaseBean?> httpPost(BuildContext context, { required String url, Map<String, dynamic>? data, Map<String, dynamic>? queryParameters, bool silence = false, String loadingTip = '请求中..', bool endHideLoading = true, bool successButErrShowTip = true, bool isShop = false }) async {
  if (!silence) EasyLoading.show();

  await requestAuthHead(context, DioHttpUtil(context)._dio!.options, url);

  var response = await DioHttpUtil(context)._dio!.post(url, data: data, queryParameters: queryParameters);

  if (response.statusCode == HttpStatus.ok) {
    try {
      var result = BaseBean.fromJson(response.data!);
      if (result.code == 200) {
        if (endHideLoading && !silence) dismissLoading();
        return result;
      } else {
        if (!silence) dismissLoading();
        if (!quietRequest.contains(response.requestOptions.path) && successButErrShowTip) ComFun.showToast(msg: result.message, err: true);
        return Future.error('error code ${result.code}');
      }
    } catch (e) {
      if (!silence) dismissLoading();
      if (!quietRequest.contains(response.requestOptions.path)) ComFun.showToast(msg: '请求出错，请稍后重试', err: true);
      return Future.error('error code $e');
    }
  }

  if (!silence) dismissLoading();
  return Future.error('error code ${response.statusCode}');
}

/// delete 请求
Future<BaseBean?> httpDelete(BuildContext context, { required String url, Map<String, dynamic>? data, Map<String, dynamic>? queryParameters, bool silence = false, String loadingTip = '请求中..', bool endHideLoading = true, bool successButErrShowTip = true, bool isShop = false }) async {
  if (!silence) EasyLoading.show();

  await requestAuthHead(context, DioHttpUtil(context)._dio!.options, url);

  var response = await DioHttpUtil(context)._dio!.delete(url, data: data, queryParameters: queryParameters);

  if (response.statusCode == HttpStatus.ok) {
    try {
      var result = BaseBean.fromJson(response.data!);
      if (result.code == 200) {
        if (endHideLoading && !silence) dismissLoading();
        return result;
      } else {
        if (!silence) dismissLoading();
        if (!quietRequest.contains(response.requestOptions.path) && successButErrShowTip) ComFun.showToast(msg: result.message, err: true);
        return Future.error('error code ${result.code}');
      }
    } catch (e) {
      if (!silence) dismissLoading();
      if (!quietRequest.contains(response.requestOptions.path)) ComFun.showToast(msg: '请求出错，请稍后重试', err: true);
      return Future.error('error code $e');
    }
  }

  if (!silence) dismissLoading();
  return Future.error('error code ${response.statusCode}');
}

/// put 请求
Future<BaseBean?> httpPut(BuildContext context, { required String url, dynamic data, Map<String, dynamic>? queryParameters, bool silence = false, String loadingTip = '请求中..', bool endHideLoading = true, bool successButErrShowTip = true, bool isShop = false }) async {
  if (!silence) EasyLoading.show();

  await requestAuthHead(context, DioHttpUtil(context)._dio!.options, url);

  var response = await DioHttpUtil(context)._dio!.put(url, data: data, queryParameters: queryParameters);

  if (response.statusCode == HttpStatus.ok) {
    try {
      var result = BaseBean.fromJson(response.data!);
      if (result.code == 200) {
        if (endHideLoading && !silence) dismissLoading();
        return result;
      } else {
        if (!silence) dismissLoading();
        if (!quietRequest.contains(response.requestOptions.path) && successButErrShowTip) ComFun.showToast(msg: result.message, err: true);
        return Future.error('error code ${result.code}');
      }
    } catch (e) {
      if (!silence) dismissLoading();
      if (!quietRequest.contains(response.requestOptions.path)) ComFun.showToast(msg: '请求出错，请稍后重试', err: true);
      return Future.error('error code $e');
    }
  }

  if (!silence) dismissLoading();
  return Future.error('error code ${response.statusCode}');
}

/// put list数据请求
Future<BaseBean<List>?> httpPutList(BuildContext context, { required String url, Map<String, dynamic>? data, Map<String, dynamic>? queryParameters, bool silence = false, String loadingTip = '请求中..', bool endHideLoading = true, bool successButErrShowTip = true, bool isShop = false }) async {
  if (!silence) EasyLoading.show();

  await requestAuthHead(context, DioHttpUtil(context)._dio!.options, url);

  var response = await DioHttpUtil(context)._dio!.put(url, data: data, queryParameters: queryParameters);

  if (response.statusCode == HttpStatus.ok) {
    try {
      var result = BaseBean.fromJson(response.data!);
      if (result.code == 200) {
        if (endHideLoading && !silence) dismissLoading();

        var listResult = result.data as List;
        return BaseBean<List>(code: result.code, message: result.message, data: listResult);
      } else {
        if (!silence) dismissLoading();
        if (!quietRequest.contains(response.requestOptions.path) && successButErrShowTip) ComFun.showToast(msg: result.message, err: true);
        return Future.error('error code ${result.code}');
      }
    } catch (e) {
      if (!silence) dismissLoading();
      if (!quietRequest.contains(response.requestOptions.path)) ComFun.showToast(msg: '请求出错，请稍后重试', err: true);
      return Future.error('error code $e');
    }
  }

  if (!silence) dismissLoading();
  return Future.error('error code ${response.statusCode}');
}

/// get list数据请求
Future<BaseBean<List>?> httpGetList(BuildContext context, { required String url, Map<String, dynamic>? queryParameters, bool silence = false, String loadingTip = '请求中..', bool endHideLoading = true, bool successButErrShowTip = true, bool isShop = false }) async {
  if (!silence) EasyLoading.show();

  await requestAuthHead(context, DioHttpUtil(context)._dio!.options, url);

  var response = await DioHttpUtil(context)._dio!.get(url, queryParameters: queryParameters);

  if (response.statusCode == HttpStatus.ok) {
    try {
      var result = BaseBean.fromJson(response.data!);
      if (result.code == 200) {
        if (endHideLoading && !silence) dismissLoading();

        var listResult = result.data as List;
        return BaseBean<List>(code: result.code, message: result.message, data: listResult);
      } else {
        if (!silence) dismissLoading();
        if (!quietRequest.contains(response.requestOptions.path) && successButErrShowTip) ComFun.showToast(msg: result.message, err: true);
        return Future.error('error code ${result.code}');
      }
    } catch (e) {
      if (!silence) dismissLoading();
      if (!quietRequest.contains(response.requestOptions.path)) ComFun.showToast(msg: '请求出错，请稍后重试', err: true);
      return Future.error('error code $e');
    }
  }

  if (!silence) dismissLoading();
  return Future.error('error code ${response.statusCode}');
}
/// post list数据请求
Future<BaseBean<List>?> httpPostList(BuildContext context, { required String url, Map<String, dynamic>? queryParameters, bool silence = false, String loadingTip = '请求中..', bool endHideLoading = true, bool successButErrShowTip = true, bool isShop = false }) async {
  if (!silence) EasyLoading.show();

  await requestAuthHead(context, DioHttpUtil(context)._dio!.options, url);

  var response = await DioHttpUtil(context)._dio!.post(url, queryParameters: queryParameters);

  if (response.statusCode == HttpStatus.ok) {
    try {
      var result = BaseBean.fromJson(response.data!);
      if (result.code == 200) {
        if (endHideLoading && !silence) dismissLoading();

        var listResult = result.data as List;
        return BaseBean<List>(code: result.code, message: result.message, data: listResult);
      } else {
        if (!silence) dismissLoading();
        if (!quietRequest.contains(response.requestOptions.path) && successButErrShowTip) ComFun.showToast(msg: result.message, err: true);
        return Future.error('error code ${result.code}');
      }
    } catch (e) {
      if (!silence) dismissLoading();
      if (!quietRequest.contains(response.requestOptions.path)) ComFun.showToast(msg: '请求出错，请稍后重试', err: true);
      return Future.error('error code $e');
    }
  }

  if (!silence) dismissLoading();
  return Future.error('error code ${response.statusCode}');
}
/// get 分页请求
Future<BaseBean<PageBaseBean>?> httpGetPage(BuildContext context, { required String url, Map<String, dynamic>? queryParameters, bool silence = false, String loadingTip = '请求中..', bool endHideLoading = true, bool successButErrShowTip = true, bool isShop = false }) async {
  if (!silence) EasyLoading.show();

  await requestAuthHead(context, DioHttpUtil(context)._dio!.options, url);

  var response = await DioHttpUtil(context)._dio!.get(url, queryParameters: queryParameters);

  if (response.statusCode == HttpStatus.ok) {
    try {
      var result = BaseBean.fromJson(response.data!);
      if (result.code == 200) {
        if (endHideLoading && !silence) dismissLoading();
        var pageResult = PageBaseBean.fromJson(result.data);
        return BaseBean<PageBaseBean>(code: result.code, message: result.message, data: pageResult);
      } else {
        if (!silence) dismissLoading();
        if (!quietRequest.contains(response.requestOptions.path) && successButErrShowTip) ComFun.showToast(msg: result.message, err: true);
        return Future.error('error code ${result.code}');
      }
    } catch (e) {
      if (!silence) dismissLoading();
      if (!quietRequest.contains(response.requestOptions.path)) ComFun.showToast(msg: '请求出错，请稍后重试', err: true);
      return Future.error('error code $e');
    }
  }

  if (!silence) dismissLoading();
  return Future.error('error code ${response.statusCode}');
}
/// post 分页请求
Future<BaseBean<PageBaseBean>?> httpPostPage(BuildContext context, { required String url, Map<String, dynamic>? queryParameters, bool silence = false, String loadingTip = '请求中..', bool endHideLoading = true, bool successButErrShowTip = true, bool isShop = false }) async {
  if (!silence) EasyLoading.show();

  await requestAuthHead(context, DioHttpUtil(context)._dio!.options, url);

  var response = await DioHttpUtil(context)._dio!.post(url, queryParameters: queryParameters);

  if (response.statusCode == HttpStatus.ok) {
    try {
      var result = BaseBean.fromJson(response.data!);
      if (result.code == 200) {
        if (endHideLoading && !silence) dismissLoading();
        var pageResult = PageBaseBean.fromJson(result.data);
        return BaseBean<PageBaseBean>(code: result.code, message: result.message, data: pageResult);
      } else {
        if (!silence) dismissLoading();
        if (!quietRequest.contains(response.requestOptions.path) && successButErrShowTip) ComFun.showToast(msg: result.message, err: true);
        return Future.error('error code ${result.code}');
      }
    } catch (e) {
      if (!silence) dismissLoading();
      if (!quietRequest.contains(response.requestOptions.path)) ComFun.showToast(msg: '请求出错，请稍后重试', err: true);
      return Future.error('error code $e');
    }
  }

  if (!silence) dismissLoading();
  return Future.error('error code ${response.statusCode}');
}

/// 文件上传
Future<String> httpUpload(BuildContext context, {String? loadingTip = '文件上传中...', bool endHideLoading = true, bool isShop = false,double? x,double? y }) async {
  late String filePath;
  final ImagePicker _picker = ImagePicker();
  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  if (image != null) {
    File? croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.ratio16x9
        ],
        aspectRatio: CropAspectRatio(ratioX: x??16, ratioY: y??9),
        androidUiSettings: const AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.white,
          toolbarWidgetColor: Colors.black87,
          initAspectRatio: CropAspectRatioPreset.ratio16x9,
          lockAspectRatio: true,
        ),
        iosUiSettings: const IOSUiSettings(
          minimumAspectRatio: 16 / 9,
          title: 'Cropper',
          aspectRatioLockEnabled: true,
          resetAspectRatioEnabled: false,
          rotateButtonsHidden: true,
          resetButtonHidden: false,
        )
    );
    if (croppedFile != null) {
      filePath = croppedFile.path;
      try {
        var formData = FormData.fromMap({
          'file': await MultipartFile.fromFile(filePath, filename: filePath.substring(filePath.lastIndexOf('/') + 1)),
        });

        if (loadingTip != null) EasyLoading.show();
        var response = await DioHttpUtil(context)._dio!.post('img/upload', data: formData);

        if (response.statusCode == HttpStatus.ok) {
          if (endHideLoading && loadingTip != null) dismissLoading();
          Map<String, dynamic> result = response.data!;
          return result['data'];
        }

        if (loadingTip != null) dismissLoading();
        return Future.error('error code ${response.statusCode}');
      } catch (e) {
        if (loadingTip != null) dismissLoading();
        return Future.error(e);
      }
    }
  }
  return "";
}

Future requestAuthHead(BuildContext context, BaseOptions options, String path) async {
  options.headers.addAll({ 'Accept-Language': context.read<SystemSetService>().appLanguage == 'en' ? 'en-US' : 'zh-CN' });
  List<String> excludePaths = ['app/history/last', 'login'];
  if (!excludePaths.contains(path)) {
    var token = Provider.of<AuthService>(context, listen: false).token ?? '';
    if (token.isEmpty) {
      await initLoginInfo(context);
      token = Provider.of<AuthService>(context, listen: false).token ?? '';
      if (token.isEmpty) {
        options.headers.removeWhere((key, value) => key == 'Authorization');
        return null;
      } else {
        options.headers.addAll({ 'Authorization': 'Bearer $token' });
        return token;
      }
    } else {
      options.headers.addAll({ 'Authorization': 'Bearer $token' });
      return token;
    }
  } else {
    if (path == 'login') options.headers.removeWhere((key, value) => key == 'Authorization');
  }
  return '';
}

class BaseBean<T> {
  final int code;
  final String message;
  final T? data;

  const BaseBean({ this.code = 0, this.message = '', this.data });

  BaseBean.fromJson(Map<String, dynamic> result):
        code = result.containsKey('code') ? result['code'] : 0,
        message = result.containsKey('message') ? result['message'] : '',
        data = result.containsKey('data') ? result['data'] : null;
}
class PageBaseBean {
  final int total; // 总条数
  final int pageNum ; // 页码
  final int pageSize; // 每页数量
  final int size; // 数据总条数
  final int startRow;
  final int endRow;
  final int pages; // 总页数
  final int prePage;
  final int nextPage;
  final bool isFirstPage;
  final bool isLastPage;
  final bool hasPreviousPage;
  final bool hasNextPage;
  final int navigatePages;
  final int navigateFirstPage;
  final int navigateLastPage;
  final List<dynamic> list;
  final List<dynamic> navigatepageNums;

  PageBaseBean.fromJson(Map<String, dynamic> result):
        total = result.containsKey('total') ? result['total'] : 0,
        pageNum = result.containsKey('pageNum') ? result['pageNum'] : 0,
        pageSize = result.containsKey('pageSize') ? result['pageSize'] : 0,
        size = result.containsKey('size') ? result['size'] : 0,
        startRow = result.containsKey('startRow') ? result['startRow'] : 0,
        endRow = result.containsKey('endRow') ? result['endRow'] : 0,
        pages = result.containsKey('pages') ? result['pages'] : 0,
        prePage = result.containsKey('prePage') ? result['prePage'] : 0,
        nextPage = result.containsKey('nextPage') ? result['nextPage'] : 0,
        isFirstPage = result.containsKey('isFirstPage') ? result['isFirstPage'] : false,
        isLastPage = result.containsKey('isLastPage') ? result['isLastPage'] : false,
        hasPreviousPage = result.containsKey('hasPreviousPage') ? result['hasPreviousPage'] : false,
        hasNextPage = result.containsKey('hasNextPage') ? result['hasNextPage'] : false,
        navigatePages = result.containsKey('navigatePages') ? result['navigatePages'] : 0,
        navigateFirstPage = result.containsKey('navigateFirstPage') ? result['navigateFirstPage'] : 0,
        navigateLastPage = result.containsKey('navigateLastPage') ? result['navigateLastPage'] : 0,
        list = result.containsKey('list') ? result['list'] : const [],
        navigatepageNums = result.containsKey('navigatepageNums') ? result['navigatepageNums'] : const [];
}

/// 请求一个第三方接口
requestFullPath(String authority, String unencodedPath,
    {
      bool isHttps = true,
      bool isGet = true,
      Map<String, dynamic>? queryParameters,
      String? loadingTip = '数据请求中...',
      String errTip = '数据请求失败',
      Function(Map data)? success,
    }
) async {
  if (loadingTip != null) EasyLoading.show();

  var httpClient = HttpClient();
  var uri = isHttps ? Uri.https(authority, unencodedPath, queryParameters) : Uri.http(authority, unencodedPath, queryParameters);
  try {
    HttpClientRequest request;
    if (isGet) {
      request = await httpClient.getUrl(uri);
    } else {
      request = await httpClient.postUrl(uri);
    }
    var response = await request.close();
    var responseBody = await response.transform(utf8.decoder).join();

    Map data = json.decode(responseBody);

    success?.call(data);
    dismissLoading();
  } catch (e) {
    debugPrint(e.toString());
    ComFun.showToast(msg: errTip, err: true);
    dismissLoading();
  }
}

class WhereOption {
  final String field;
  final dynamic value;
  final bool isLike;

  const WhereOption({
    required this.field,
    this.value,
    this.isLike = false,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['field'] = field;
    data['value'] = value;
    if (isLike) data['whereLink'] = 'LIKE';
    return data;
  }
}
