import 'package:dio/dio.dart';

/// @Author: gstory
/// @CreateDate: 2023/12/26 17:03
/// @Email gstory0404@gmail.com
/// @Description: 返回参拦截器

class ResponseInterceptor extends Interceptor {

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return super.onResponse(response, handler);
  }
}