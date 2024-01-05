import 'package:dio/dio.dart';

/// @Author: gstory
/// @CreateDate: 2023/12/26 16:51
/// @Email gstory0404@gmail.com
/// @Description: dio错误拦截器

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    return super.onError(err, handler);
  }
}
