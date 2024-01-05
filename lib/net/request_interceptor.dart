import 'package:dio/dio.dart';

/// @Author: gstory
/// @CreateDate: 2023/12/26 17:01
/// @Email gstory0404@gmail.com
/// @Description: 请求参拦截器

class RequestInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return super.onResponse(response, handler);
  }
}
