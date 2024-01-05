import 'package:dio/dio.dart';

import '../utils/sp/sp_manager.dart';

/// @Author: gstory
/// @CreateDate: 2023/12/26 17:05
/// @Email gstory0404@gmail.com
/// @Description: token拦截器

class TokenInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['user_id'] =
        SPManager.instance.getUserInfo().userId ?? "";
    options.headers['token'] = SPManager.instance.getUserInfo().token ?? "";
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return super.onResponse(response, handler);
  }
}
