import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:larkmusic/main.dart';
import 'package:larkmusic/net/request_interceptor.dart';
import 'package:larkmusic/net/response_interceptor.dart';
import 'package:larkmusic/net/token_interceptor.dart';
import 'package:larkmusic/pages/login/login_page.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../entity/base_entity.dart';
import '../routes/app_pages.dart';
import '../utils/sp/sp_manager.dart';
import 'error_code.dart';

/// @Author: gstory
/// @CreateDate: 2023/12/26 16:43
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class LMHttp {
  factory LMHttp() => _getInstance();

  static LMHttp get instance => _getInstance();
  static LMHttp? _instance;

  static LMHttp _getInstance() {
    _instance ??= LMHttp._internal();
    return _instance!;
  }

  static late final Dio dio;
  final CancelToken _cancelToken = CancelToken();

  LMHttp._internal() {
    BaseOptions options = BaseOptions();
    dio = Dio(options);
    dio.interceptors.add(RequestInterceptor());
    dio.interceptors.add(ResponseInterceptor());
    dio.interceptors.add(TokenInterceptor());
    // 添加日志拦截器
    // dio.interceptors.add(PrettyDioLogger(
    //     requestHeader: true,
    //     requestBody: true,
    //     responseBody: true,
    //     responseHeader: false,
    //     error: true,
    //     compact: true,
    //     maxWidth: 90));
  }

  ///
  ///初始化
  ///
  /// [baseUrl] 服务器域名
  /// [connectTimeout] 连接超时赶时间
  /// [receiveTimeout] 接收超时赶时间
  /// [interceptors] 拦截器
  void init({
    String? baseUrl,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Map<String, String>? headers,
    List<Interceptor>? interceptors,
  }) {
    dio.options = dio.options.copyWith(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout ?? const Duration(seconds: 30),
      receiveTimeout: receiveTimeout ?? const Duration(seconds: 30),
      headers: headers ?? const {},
    );
    // 在初始化http类的时候，可以传入拦截器
    if (interceptors != null && interceptors.isNotEmpty) {
      dio.interceptors.addAll(interceptors);
    }
  }

  // 关闭dio
  void cancelRequests({required CancelToken token}) {
    token.cancel("cancelled");
  }

  ///get请求
  Future get<T>(
    String path, {
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
    Success<T>? success,
    Fail? fail,
  }) async {
    return _request<T>(path,
        method: "get",
        params: params,
        options: options,
        cancelToken: cancelToken,
        success: success,
        fail: fail);
  }

  ///post请求
  Future post<T>(
    String path, {
    data,
    Options? options,
    CancelToken? cancelToken,
    Success<T>? success,
    Fail? fail,
  }) async {
    return _request<T>(path,
        method: "post",
        data: data,
        options: options,
        cancelToken: cancelToken,
        success: success,
        fail: fail);
  }

  Future _request<T>(
    String path, {
    Map<String, dynamic>? params,
    data,
    String method = "post",
    Options? options,
    CancelToken? cancelToken,
    Success<T>? success,
    Fail? fail,
  }) async {
    if(dio.options.baseUrl.isEmpty){
      //初始化
      LMHttp.instance.init(baseUrl: SPManager.instance.getHost());
    }
    try {
      Options requestOptions = options ?? Options();
      Response response;
      if (method == "get") {
        response = await dio.get(
          path,
          queryParameters: params,
          options: requestOptions,
          cancelToken: cancelToken ?? _cancelToken,
        );
      } else {
        response = await dio.post(
          path,
          data: data,
          options: requestOptions,
          cancelToken: cancelToken ?? _cancelToken,
        );
      }
      BaseEntity entity = BaseEntity<T>.fromJson(response.data);
      if (entity.code == 1) {
        if (success != null) success(entity.data as T);
      } else {
        //token过期 清理用户缓存
        if (entity.code! == ErrorCode.tokenExpired) {
          SPManager.instance.cleanUserInfo();
          Future.delayed(const Duration(milliseconds:0)).then((onValue)  {
            LoginPage.go(rootNavigatorKey.currentState!.overlay!.context);
          });
        }
        if (fail != null) fail(entity.code!, entity.message ?? "");
      }
      return;
    } catch (e) {
      if (fail != null) fail(-1, e.toString());
    }
  }

  ///sse接口
  Future sse(
    String path, {
    Map<String, dynamic>? params,
    CancelToken? cancelToken,
    Success<String>? success,
    Fail? fail,
  }) async {
    try {
      Response response;
      response = await dio.get(
        path,
        queryParameters: params,
        options: Options(
          headers: {
            "Accept": "text/event-stream",
            "Cache-Control": "no-cache",
          },
          responseType: ResponseType.stream,
        ),
        cancelToken: cancelToken ?? _cancelToken,
      );
      response.data?.stream
          .transform(unit8Transformer)
          .transform(const Utf8Decoder())
          .transform(const LineSplitter())
          .listen((event) {
        if (success != null) success(event);
      });
    } catch (e) {
      if (fail != null) fail(-1, e.toString());
    }
  }

  StreamTransformer<Uint8List, List<int>> unit8Transformer =
      StreamTransformer.fromHandlers(
    handleData: (data, sink) {
      sink.add(List<int>.from(data));
    },
  );
}

typedef Success<T> = Function(T data); // 请求成功回调
typedef Fail = Function(int code, String message); // 请求失败统一回调
